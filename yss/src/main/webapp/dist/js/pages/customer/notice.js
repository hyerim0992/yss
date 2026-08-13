(function () {
  "use strict";
  function q(s, scope) { return (scope || document).querySelector(s); }
  function qa(s, scope) { return Array.prototype.slice.call((scope || document).querySelectorAll(s)); }
  var category = "전체";

  function filterNotice() {
    var input = q("#abcNoticeSearchInput");
    var keyword = input ? input.value.trim().toLowerCase() : "";
    var visible = 0;
    qa(".abc-cs-notice-row").forEach(function (row) {
      var c = category === "전체" || row.getAttribute("data-category") === category;
      var k = !keyword || (row.getAttribute("data-title") || "").toLowerCase().indexOf(keyword) !== -1;
      row.hidden = !(c && k);
      if (!row.hidden) visible += 1;
    });
    var empty = q("#abcNoticeEmpty");
    if (empty) empty.hidden = visible !== 0;
  }

  qa("[data-abc-notice-category]").forEach(function (button) {
    button.addEventListener("click", function () {
      category = button.getAttribute("data-abc-notice-category");
      qa("[data-abc-notice-category]").forEach(function (item) { item.classList.remove("is-active"); });
      button.classList.add("is-active");
      filterNotice();
    });
  });
  var form = q("#abcNoticeSearchForm");
  var input = q("#abcNoticeSearchInput");
  if (form) form.addEventListener("submit", function (e) { e.preventDefault(); filterNotice(); });
  if (input) input.addEventListener("input", filterNotice);

  qa(".abc-cs-notice-row").forEach(function (row) {
    row.addEventListener("click", function () {
      q("#abcNoticeDetailType").textContent = row.getAttribute("data-category") || "공지";
      q("#abcNoticeDetailTitle").textContent = row.getAttribute("data-title") || "";
      q("#abcNoticeDetailDate").textContent = row.getAttribute("data-date") || "";
      q("#abcNoticeDetailBody").textContent = row.getAttribute("data-body") || "";
      q("#abcNoticeList").hidden = true;
      q("#abcNoticeEmpty").hidden = true;
      q("#abcNoticeDetail").hidden = false;
      q("#abcNoticeSearchForm").hidden = true;
      q(".abc-cs-category-grid--notice").hidden = true;
      q(".abc-cs-notice-columns").hidden = true;
    });
  });
  var back = q("#abcNoticeBack");
  if (back) back.addEventListener("click", function () {
    q("#abcNoticeList").hidden = false;
    q("#abcNoticeDetail").hidden = true;
    q("#abcNoticeSearchForm").hidden = false;
    q(".abc-cs-category-grid--notice").hidden = false;
    q(".abc-cs-notice-columns").hidden = false;
    filterNotice();
  });
})();
