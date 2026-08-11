(function () {
  "use strict";

  function getContextPath() {
    var header = document.querySelector("[data-global-header]");
    if (header) return header.getAttribute("data-context-path") || "";
    return document.body.getAttribute("data-context-path") || "";
  }

  function syncShellHeights() {
    var header = document.querySelector("[data-global-header]");
    if (header) {
      var headerHeight = Math.ceil(header.getBoundingClientRect().height);
      if (headerHeight > 0) {
        document.documentElement.style.setProperty("--ys-global-header-height", headerHeight + "px");
      }
    }

    document.documentElement.style.setProperty("--ys-global-footer-height", "0px");
  }

  function initializeSearch() {
    var modal = document.getElementById("globalSearch");
    if (!modal) return;

    var contextPath = getContextPath();
    document.body.setAttribute("data-context-path", contextPath);

    document.querySelectorAll(".search-icon[data-open-search]").forEach(function (trigger) {
      trigger.addEventListener("keydown", function (event) {
        if (event.key === "Enter" || event.key === " ") {
          event.preventDefault();
          trigger.click();
        }
      });
    });

    if (window.__yongsinsaSearchInitialized) return;
    if (document.querySelector('script[data-global-search-script]')) return;

    var script = document.createElement("script");
    script.src = contextPath + "/dist/js/pages/product/search.js?v=20260806-0030";
    script.setAttribute("data-global-search-script", "true");
    document.body.appendChild(script);
  }

  function setCurrentYear() {
    document.querySelectorAll("[data-current-year]").forEach(function (element) {
      element.textContent = String(new Date().getFullYear());
    });
  }

  function initialize() {
    syncShellHeights();
    initializeSearch();
    setCurrentYear();

    window.addEventListener("resize", syncShellHeights);
    window.addEventListener("load", syncShellHeights);

    if (window.ResizeObserver) {
      var header = document.querySelector("[data-global-header]");
      if (header) {
        new ResizeObserver(syncShellHeights).observe(header);
      }
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initialize);
  } else {
    initialize();
  }
})();
