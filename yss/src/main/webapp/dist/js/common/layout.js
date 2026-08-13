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

  function setCurrentYear() {
    document.querySelectorAll("[data-current-year]").forEach(function (element) {
      element.textContent = String(new Date().getFullYear());
    });
  }

  function initialize() {
    syncShellHeights();
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
