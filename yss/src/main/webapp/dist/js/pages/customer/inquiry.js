(function () {
  "use strict";
  function q(s, scope) { return (scope || document).querySelector(s); }
  function qa(s, scope) { return Array.prototype.slice.call((scope || document).querySelectorAll(s)); }
  var toastTimer;
  function toast(message) {
    var el = q("#abcCsToast");
    if (!el) return;
    el.textContent = message;
    el.classList.add("is-show");
    clearTimeout(toastTimer);
    toastTimer = setTimeout(function () { el.classList.remove("is-show"); }, 2200);
  }
  qa("[data-choice-group]").forEach(function (group) {
    var hidden = q('input[type="hidden"]', group);
    qa("[data-choice-value]", group).forEach(function (button) {
      button.addEventListener("click", function () {
        qa("[data-choice-value]", group).forEach(function (b) { b.classList.remove("is-active"); });
        button.classList.add("is-active");
        if (hidden) hidden.value = button.getAttribute("data-choice-value");
      });
    });
  });
  qa("[data-abc-count]").forEach(function (counter) {
    var field = q("#" + counter.getAttribute("data-abc-count"));
    if (field) field.addEventListener("input", function () { counter.textContent = String(field.value.length); });
  });

  function setPanel(name) {
    qa("[data-abc-inquiry-tab]").forEach(function (b) { b.classList.toggle("is-active", b.getAttribute("data-abc-inquiry-tab") === name); });
    qa("[data-abc-inquiry-panel]").forEach(function (p) { p.hidden = p.getAttribute("data-abc-inquiry-panel") !== name; });
  }
  qa("[data-abc-inquiry-tab]").forEach(function (button) { button.addEventListener("click", function () { setPanel(button.getAttribute("data-abc-inquiry-tab")); }); });

  var files = q("#abcInquiryFiles");
  if (files) files.addEventListener("change", function () {
    var names = Array.prototype.slice.call(files.files || []).slice(0, 3).map(function (f) { return f.name; });
    q("#abcInquiryFileNames").textContent = names.length ? names.join(", ") : "선택된 파일 없음";
    if ((files.files || []).length > 3) toast("파일은 최대 3개까지 첨부할 수 있습니다.");
  });

  var form = q("#abcInquiryForm");
  if (form) {
    form.addEventListener("reset", function () { setTimeout(function () {
      qa("[data-choice-value]", form).forEach(function (b) { b.classList.remove("is-active"); });
      q('[data-abc-count="abcInquiryContent"]').textContent = "0";
      q("#abcInquiryFileNames").textContent = "선택된 파일 없음";
    }, 0); });
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      if (!form.elements.inquiryType.value || !form.elements.inquiryDetail.value) { toast("문의 유형과 상세 유형을 선택해 주세요."); return; }
      if (!form.checkValidity()) { form.reportValidity(); return; }
      var template = q("#abcInquiryHistoryTemplate");
      var list = q("#abcInquiryHistoryList");
      if (template && list) {
        var row = template.content.cloneNode(true);
        q("[data-history-type]", row).textContent = form.elements.inquiryType.value;
        q("[data-history-title]", row).textContent = form.elements.title.value;
        q("[data-history-date]", row).textContent = new Date().toLocaleDateString("ko-KR");
        list.prepend(row);
      }
      form.reset();
      toast("연습용 문의가 목록에 추가되었습니다.");
      setPanel("history");
    });
  }
})();
