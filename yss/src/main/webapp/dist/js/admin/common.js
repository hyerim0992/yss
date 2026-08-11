(function () {
  "use strict";

  function contextPath() {
    return document.body ? (document.body.getAttribute("data-context-path") || "") : "";
  }

  function bindLogout() {
    var button = document.getElementById("logoutButton");
    if (!button) return;

    button.addEventListener("click", function () {
      if (window.confirm("관리자 화면에서 나가 쇼핑몰 메인으로 이동할까요?")) {
        window.location.href = contextPath() + "/main";
      }
    });
  }

  function init() {
    bindLogout();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }

  window.AdminCommon = {
    contextPath: contextPath
  };
})();
