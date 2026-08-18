(function () {
  "use strict";

  function initTabs() {
    var root = document.querySelector(".admin-static-page");
    if (!root) {
      return;
    }

    var tabs = root.querySelectorAll("[data-section-target]");
    var sections = root.querySelectorAll("[data-admin-section]");

    for (var i = 0; i < tabs.length; i++) {
      tabs[i].addEventListener("click", function () {
        var target = this.getAttribute("data-section-target");

        for (var j = 0; j < tabs.length; j++) {
          tabs[j].classList.remove("active");
        }

        for (var k = 0; k < sections.length; k++) {
          if (sections[k].getAttribute("data-admin-section") === target) {
            sections[k].hidden = false;
            sections[k].classList.add("active");
          } else {
            sections[k].hidden = true;
            sections[k].classList.remove("active");
          }
        }

        this.classList.add("active");
      });
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initTabs);
  } else {
    initTabs();
  }
})();
