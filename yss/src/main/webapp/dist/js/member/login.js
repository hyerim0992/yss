(function () {
  "use strict";

  var AUTH_STORAGE_KEY = "yongsinsaDemoLoggedIn";
  var USER_STORAGE_KEY = "yongsinsaDemoUserId";
  var REMEMBER_ID_KEY = "yongsinsaRememberedUserId";

  function getHeader() {
    return document.querySelector("[data-global-header]");
  }

  function getContextPath() {
    var header = getHeader();
    return header ? header.getAttribute("data-context-path") || "" : "";
  }

  function getQueryParameter(name) {
    var query = (window.location.search || "").replace(/^\?/, "").split("&");
    var i;

    for (i = 0; i < query.length; i += 1) {
      if (!query[i]) continue;
      var pair = query[i].split("=");
      if (decodeURIComponent(pair[0]) === name) {
        return decodeURIComponent((pair[1] || "").replace(/\+/g, " "));
      }
    }
    return "";
  }

  function getReturnUrl() {
    var contextPath = getContextPath();
    var returnUrl = getQueryParameter("return");
    var defaultUrl = contextPath + "/views/mypage/mypage.jsp";

    if (!returnUrl) return defaultUrl;
    if (returnUrl.indexOf(contextPath + "/") !== 0) return defaultUrl;
    if (returnUrl.indexOf("://") !== -1) return defaultUrl;

    return returnUrl;
  }

  function setStatus(element, message, isError) {
    if (!element) return;
    element.textContent = message || "";
    element.classList.toggle("is-error", Boolean(isError));
  }

  function saveDemoLogin(userId) {
    try {
      window.localStorage.setItem(AUTH_STORAGE_KEY, "true");
      window.localStorage.setItem(USER_STORAGE_KEY, userId);
    } catch (error) {
      // localStorage를 사용할 수 없으면 다음 저장소를 사용합니다.
    }

    try {
      window.sessionStorage.setItem(AUTH_STORAGE_KEY, "true");
      window.sessionStorage.setItem(USER_STORAGE_KEY, userId);
    } catch (error2) {
      // sessionStorage를 사용할 수 없으면 쿠키를 사용합니다.
    }

    document.cookie = AUTH_STORAGE_KEY + "=true; path=/; SameSite=Lax";
    document.cookie = USER_STORAGE_KEY + "=" + encodeURIComponent(userId) + "; path=/; SameSite=Lax";
  }

  function readRememberedUserId() {
    try {
      return window.localStorage.getItem(REMEMBER_ID_KEY) || "";
    } catch (error) {
      return "";
    }
  }

  function updateRememberedUserId(userId, remember) {
    try {
      if (remember) {
        window.localStorage.setItem(REMEMBER_ID_KEY, userId);
      } else {
        window.localStorage.removeItem(REMEMBER_ID_KEY);
      }
    } catch (error) {
      // 저장소를 사용할 수 없어도 로그인은 계속 진행합니다.
    }
  }

  function initializeMemberLogin() {
    var form = document.querySelector("[data-member-login-form]");
    if (!form) return;

    var userIdInput = form.querySelector('input[name="name"]');
    var passwordInput = form.querySelector('input[name="password"]');
    var rememberInput = form.querySelector('input[name="rememberUserId"]');
    var status = form.querySelector("[data-login-status]");
    var rememberedUserId = readRememberedUserId();
    var submitting = false;

    if (rememberedUserId && userIdInput) {
      userIdInput.value = rememberedUserId;
      if (rememberInput) rememberInput.checked = true;
      if (passwordInput) passwordInput.focus();
    }

    form.addEventListener("submit", function (event) {
      event.preventDefault();
      if (submitting) return;

      var userId = userIdInput ? userIdInput.value.replace(/^\s+|\s+$/g, "") : "";
      var password = passwordInput ? passwordInput.value : "";

      setStatus(status, "", false);

      if (!userId) {
        setStatus(status, "아이디를 입력해 주세요.", true);
        if (userIdInput) userIdInput.focus();
        return;
      }

      if (!password) {
        setStatus(status, "비밀번호를 입력해 주세요.", true);
        if (passwordInput) passwordInput.focus();
        return;
      }

      submitting = true;
      updateRememberedUserId(userId, rememberInput && rememberInput.checked);
      saveDemoLogin(userId);
      setStatus(status, "로그인 중입니다.", false);

      if (window.YSPageLoader && typeof window.YSPageLoader.show === "function") {
        window.YSPageLoader.show("로그인 중");
      }

      window.location.assign(getReturnUrl());
    });
  }

  function initializeGuestOrderLookup() {
    var form = document.querySelector("[data-guest-order-form]");
    if (!form) return;

    var orderNumberInput = form.querySelector('input[name="guestOrderNumber"]');
    var passwordInput = form.querySelector('input[name="guestOrderPassword"]');
    var status = form.querySelector("[data-guest-status]");

    form.addEventListener("submit", function (event) {
      event.preventDefault();

      var orderNumber = orderNumberInput
        ? orderNumberInput.value.replace(/\D/g, "")
        : "";
      var password = passwordInput ? passwordInput.value : "";

      if (orderNumber.length !== 8) {
        setStatus(status, "주문번호 8자리를 입력해 주세요.", true);
        if (orderNumberInput) orderNumberInput.focus();
        return;
      }

      if (password.length < 6) {
        setStatus(status, "주문 비밀번호를 6자 이상 입력해 주세요.", true);
        if (passwordInput) passwordInput.focus();
        return;
      }

      setStatus(
        status,
        "현재는 UI 단계입니다. 주문조회 Controller 연결 후 실제 내역이 표시됩니다.",
        false
      );
    });
  }

  function initializeDemoLinks() {
    var links = document.querySelectorAll("[data-demo-message]");
    var i;

    for (i = 0; i < links.length; i += 1) {
      links[i].addEventListener("click", function (event) {
        event.preventDefault();
        alert(this.getAttribute("data-demo-message") || "준비 중인 기능입니다.");
      });
    }
  }

  function initializeLoginPage() {
    initializeMemberLogin();
    initializeGuestOrderLookup();
    initializeDemoLinks();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initializeLoginPage);
  } else {
    initializeLoginPage();
  }
})();
