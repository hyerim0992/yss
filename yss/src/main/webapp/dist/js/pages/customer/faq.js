(function () {
  "use strict";
  function q(s, scope) { return (scope || document).querySelector(s); }
  function qa(s, scope) { return Array.prototype.slice.call((scope || document).querySelectorAll(s)); }

  var category = "전체";
  function filterFaq() {
    var input = q("#abcFaqSearchInput");
    var keyword = input ? input.value.trim().toLowerCase() : "";
    var visible = 0;
    qa(".abc-cs-faq-item").forEach(function (item) {
      var categoryMatch = category === "전체" || item.getAttribute("data-category") === category;
      var keywordMatch = !keyword || (item.getAttribute("data-search") || "").toLowerCase().indexOf(keyword) !== -1;
      item.hidden = !(categoryMatch && keywordMatch);
      if (!item.hidden) visible += 1;
    });
    var count = q("#abcFaqCount");
    var empty = q("#abcFaqEmpty");
    if (count) count.textContent = String(visible);
    if (empty) empty.hidden = visible !== 0;
  }

  qa("[data-abc-faq-category]").forEach(function (button) {
    button.addEventListener("click", function () {
      category = button.getAttribute("data-abc-faq-category");
      qa("[data-abc-faq-category]").forEach(function (item) { item.classList.remove("is-active"); });
      button.classList.add("is-active");
      filterFaq();
    });
  });

  var form = q("#abcFaqSearchForm");
  var input = q("#abcFaqSearchInput");
  if (form) form.addEventListener("submit", function (e) { e.preventDefault(); filterFaq(); });
  if (input) input.addEventListener("input", filterFaq);

  qa(".abc-cs-faq-question").forEach(function (button) {
    button.addEventListener("click", function () {
      var item = button.parentElement;
      var willOpen = !item.classList.contains("is-open");
      qa(".abc-cs-faq-item.is-open").forEach(function (opened) {
        opened.classList.remove("is-open");
        var b = q(".abc-cs-faq-question", opened);
        if (b) b.setAttribute("aria-expanded", "false");
      });
      item.classList.toggle("is-open", willOpen);
      button.setAttribute("aria-expanded", willOpen ? "true" : "false");
    });
  });
})();
