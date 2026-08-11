(function () {
  "use strict";

  var AUTH_STORAGE_KEY = "yongsinsaDemoLoggedIn";
  var USER_STORAGE_KEY = "yongsinsaDemoUserId";

  function getHeader() {
    return document.querySelector("[data-global-header]");
  }

  function getContextPath() {
    var header = getHeader();
    return header ? header.getAttribute("data-context-path") || "" : "";
  }

  function getHeaderUrl(name, fallback) {
    var header = getHeader();
    var value = header ? header.getAttribute(name) : "";
    return value || getContextPath() + fallback;
  }

  function readCookie(name) {
    var cookies = document.cookie ? document.cookie.split(";") : [];
    var prefix = name + "=";
    var i;

    for (i = 0; i < cookies.length; i += 1) {
      var cookie = cookies[i].replace(/^\s+/, "");
      if (cookie.indexOf(prefix) === 0) {
        return decodeURIComponent(cookie.substring(prefix.length));
      }
    }
    return "";
  }

  function getStoredLoginState() {
    try {
      if (window.localStorage.getItem(AUTH_STORAGE_KEY) === "true") return true;
    } catch (error) {
      // localStorage를 사용할 수 없으면 다음 저장소를 확인합니다.
    }

    try {
      if (window.sessionStorage.getItem(AUTH_STORAGE_KEY) === "true") return true;
    } catch (error2) {
      // sessionStorage를 사용할 수 없으면 쿠키를 확인합니다.
    }

    return readCookie(AUTH_STORAGE_KEY) === "true";
  }

  function clearStoredLoginState() {
    try {
      window.localStorage.removeItem(AUTH_STORAGE_KEY);
      window.localStorage.removeItem(USER_STORAGE_KEY);
    } catch (error) {
      // 저장소 접근이 제한되어 있어도 로그아웃은 계속 진행합니다.
    }

    try {
      window.sessionStorage.removeItem(AUTH_STORAGE_KEY);
      window.sessionStorage.removeItem(USER_STORAGE_KEY);
    } catch (error2) {
      // 저장소 접근이 제한되어 있어도 로그아웃은 계속 진행합니다.
    }

    document.cookie = AUTH_STORAGE_KEY + "=; max-age=0; path=/";
    document.cookie = USER_STORAGE_KEY + "=; max-age=0; path=/";
  }

  function hasLogoutParameter() {
    return /(?:\?|&)logout=1(?:&|$)/.test(window.location.search || "");
  }

  function setVisible(element, visible) {
    if (!element) return;
    element.classList.toggle("is-hidden", !visible);
  }

  function forEachElement(selector, callback) {
    var elements = document.querySelectorAll(selector);
    var i;
    for (i = 0; i < elements.length; i += 1) {
      callback(elements[i]);
    }
  }

  function parseUrl(url) {
    try {
      return new URL(url, window.location.href);
    } catch (error) {
      return null;
    }
  }

  function isCurrentMypage(mypageUrl) {
    var currentUrl = parseUrl(window.location.href);
    var targetUrl = parseUrl(mypageUrl);

    if (!currentUrl || !targetUrl) return false;

    return (
      currentUrl.origin === targetUrl.origin &&
      currentUrl.pathname === targetUrl.pathname
    );
  }

  function openMypageSection(section) {
    if (!section) return;

    if (
      window.YSMypage &&
      typeof window.YSMypage.activateView === "function"
    ) {
      window.YSMypage.activateView(section);
      return;
    }

    if (window.location.hash !== "#" + section) {
      window.location.hash = section;
    } else {
      document.dispatchEvent(
        new CustomEvent("yongsinsa:mypage-view", {
          detail: { view: section }
        })
      );
    }
  }

  function initializeAuthHeader() {
    var header = getHeader();
    if (!header || header.getAttribute("data-auth-ready") === "true") return;
    header.setAttribute("data-auth-ready", "true");

    if (hasLogoutParameter()) {
      clearStoredLoginState();
    }

    var serverAuthenticated =
      header.getAttribute("data-server-authenticated") === "true";
    var authenticated = serverAuthenticated || getStoredLoginState();
    var loginUrl = getHeaderUrl("data-login-url", "/member/login");
    var mypageUrl = getHeaderUrl("data-mypage-url", "/mypage");
    var logoutUrl = getHeaderUrl("data-logout-url", "/member/logout");

    forEachElement(
      "[data-desktop-login-item], [data-mobile-login-item]",
      function (item) {
        setVisible(item, !authenticated);
      }
    );

    forEachElement(
      "[data-desktop-logout-item], [data-mobile-logout-item]",
      function (item) {
        setVisible(item, authenticated);
      }
    );

    forEachElement("[data-mypage-link]", function (link) {
      link.setAttribute("href", mypageUrl);

      link.addEventListener("click", function (event) {
        event.preventDefault();
        event.stopPropagation();

        if (isCurrentMypage(mypageUrl)) {
          openMypageSection("home");
          if (window.YSPageLoader && typeof window.YSPageLoader.hide === "function") {
            window.YSPageLoader.hide();
          }
          return;
        }

        window.location.assign(mypageUrl);
      });
    });

    forEachElement("[data-mypage-section-link]", function (link) {
      var section = link.getAttribute("data-mypage-section-link");
      link.setAttribute("href", mypageUrl + "#" + section);

      link.addEventListener("click", function (event) {
        if (!isCurrentMypage(mypageUrl)) return;

        event.preventDefault();
        event.stopPropagation();
        openMypageSection(section);

        if (window.YSPageLoader && typeof window.YSPageLoader.hide === "function") {
          window.YSPageLoader.hide();
        }
      });
    });

    forEachElement("[data-logout-link]", function (link) {
      link.setAttribute("href", logoutUrl);

      link.addEventListener("click", function (event) {
        event.preventDefault();
        event.stopPropagation();
        clearStoredLoginState();
        window.location.assign(logoutUrl);
      });
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initializeAuthHeader);
  } else {
    initializeAuthHeader();
  }
})();
