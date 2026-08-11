(function () {
  "use strict";

  if (window.__ysPageLoaderInitialized) return;

  var loader = document.getElementById("ysPageLoader");
  if (!loader) {
    document.documentElement.classList.remove("ys-page-loading");
    return;
  }

  window.__ysPageLoaderInitialized = true;

  var label = loader.querySelector("[data-page-loader-label]");
  var currentProgress = 10;
  var visibleSince = Date.now();
  var driftTimer = null;
  var hideTimer = null;
  var restoreTimer = null;
  var MIN_VISIBLE_TIME = 420;

  if (window.__ysPageLoaderSafetyTimer) {
    clearTimeout(window.__ysPageLoaderSafetyTimer);
  }

  function clamp(value, min, max) {
    return Math.min(max, Math.max(min, value));
  }

  function setProgress(value, force) {
    var next = clamp(Number(value) || 0, 0, 100);

    if (!force && next < currentProgress) return;

    currentProgress = next;
    document.documentElement.style.setProperty(
      "--ys-loader-progress",
      currentProgress.toFixed(2) + "%"
    );
  }

  function stopDrift() {
    if (driftTimer) {
      clearInterval(driftTimer);
      driftTimer = null;
    }
  }

  function startDrift(limit) {
    stopDrift();

    driftTimer = setInterval(function () {
      if (currentProgress >= limit) {
        stopDrift();
        return;
      }

      var remaining = limit - currentProgress;
      var step = Math.max(0.35, Math.min(2.4, remaining * 0.08));
      setProgress(currentProgress + step);
    }, 180);
  }

  function show(message, resetProgress) {
    if (hideTimer) {
      clearTimeout(hideTimer);
      hideTimer = null;
    }

    if (restoreTimer) {
      clearTimeout(restoreTimer);
      restoreTimer = null;
    }

    visibleSince = Date.now();
    loader.classList.remove("is-complete");
    loader.classList.add("is-visible");
    loader.removeAttribute("aria-hidden");
    document.documentElement.classList.add("ys-page-loading");

    if (label) {
      label.textContent = message || "페이지를 불러오는 중";
    }

    if (resetProgress !== false) {
      setProgress(10, true);
    }

    startDrift(72);
  }

  function hide() {
    stopDrift();
    document.documentElement.classList.remove("ys-page-loading");
    loader.classList.remove("is-visible", "is-complete");
    loader.setAttribute("aria-hidden", "true");
  }

  function complete() {
    if (!document.documentElement.classList.contains("ys-page-loading") &&
        !loader.classList.contains("is-visible")) {
      return;
    }

    stopDrift();
    loader.classList.add("is-complete");
    setProgress(100);

    var elapsed = Date.now() - visibleSince;
    var wait = Math.max(240, MIN_VISIBLE_TIME - elapsed);

    if (hideTimer) clearTimeout(hideTimer);
    hideTimer = setTimeout(hide, wait);
  }

  function trackInitialImages() {
    var images = Array.prototype.slice.call(document.images || []);
    var total = images.length;
    var finished = 0;

    setProgress(24);

    if (!total) {
      setProgress(82);
      return;
    }

    function assetFinished() {
      finished += 1;
      var ratio = finished / total;
      setProgress(24 + ratio * 64);
    }

    images.forEach(function (image) {
      if (image.complete) {
        assetFinished();
        return;
      }

      image.addEventListener("load", assetFinished, { once: true });
      image.addEventListener("error", assetFinished, { once: true });
    });

    if (document.fonts && document.fonts.ready) {
      document.fonts.ready.then(function () {
        setProgress(Math.max(currentProgress, 84));
      });
    }
  }

  function isFullPageNavigation(anchor, event) {
    if (!anchor || event.defaultPrevented) return false;
    if (event.button !== 0) return false;
    if (event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return false;
    if (anchor.hasAttribute("download")) return false;
    if (anchor.getAttribute("target") === "_blank") return false;
    if (anchor.closest("[data-no-page-loader]")) return false;
    if (anchor.matches("[data-toggle], [data-bs-toggle], [data-open-search]")) return false;
    if (anchor.getAttribute("role") === "button") return false;

    var rawHref = (anchor.getAttribute("href") || "").trim();
    if (!rawHref || rawHref === "#" || rawHref.charAt(0) === "#") return false;
    if (/^(javascript:|mailto:|tel:)/i.test(rawHref)) return false;

    var targetUrl;
    try {
      targetUrl = new URL(anchor.href, window.location.href);
    } catch (error) {
      return false;
    }

    if (!/^https?:$/.test(targetUrl.protocol)) return false;

    var currentUrl = new URL(window.location.href);
    var sameDocument =
      targetUrl.origin === currentUrl.origin &&
      targetUrl.pathname === currentUrl.pathname &&
      targetUrl.search === currentUrl.search &&
      targetUrl.hash !== currentUrl.hash;

    return !sameDocument;
  }

  document.addEventListener("click", function (event) {
    var target = event.target;
    if (!target || !target.closest) return;

    var anchor = target.closest("a[href]");
    if (!isFullPageNavigation(anchor, event)) return;

    var locationBeforeClick = window.location.href;
    show("페이지 이동 중", true);

    // 자바스크립트에서 이동을 취소한 링크 때문에 로더가 남는 상황을 방지합니다.
    restoreTimer = setTimeout(function () {
      if (
        document.visibilityState === "visible" &&
        window.location.href === locationBeforeClick
      ) {
        complete();
      }
    }, 4000);
  });

  document.addEventListener("submit", function (event) {
    var form = event.target;
    if (event.defaultPrevented || !form || form.nodeName !== "FORM") return;
    if (form.getAttribute("target") === "_blank") return;
    if (form.closest("[data-no-page-loader]")) return;

    show("요청을 처리하는 중", true);
  });

  window.addEventListener("beforeunload", function () {
    show("페이지 이동 중", false);
  });

  window.addEventListener("load", complete, { once: true });

  window.addEventListener("pageshow", function (event) {
    if (event.persisted || document.readyState === "complete") {
      complete();
    }
  });

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", trackInitialImages, { once: true });
  } else {
    trackInitialImages();
  }

  show("페이지를 불러오는 중", true);

  if (document.readyState === "complete") {
    setTimeout(complete, 0);
  }

  window.YSPageLoader = {
    show: function (message) {
      show(message || "처리하는 중", true);
    },
    complete: complete,
    hide: hide,
    setProgress: function (value) {
      setProgress(value);
    }
  };
})();
