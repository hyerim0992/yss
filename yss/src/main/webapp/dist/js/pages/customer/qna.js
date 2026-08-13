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
    qa("[data-abc-qna-tab]").forEach(function (b) { b.classList.toggle("is-active", b.getAttribute("data-abc-qna-tab") === name); });
    qa("[data-abc-qna-panel]").forEach(function (p) { p.hidden = p.getAttribute("data-abc-qna-panel") !== name; });
  }
  qa("[data-abc-qna-tab]").forEach(function (button) { button.addEventListener("click", function () { setPanel(button.getAttribute("data-abc-qna-tab")); }); });

  var form = q("#abcQnaForm");
  if (form) {
    form.addEventListener("reset", function () { setTimeout(function () {
      qa("[data-choice-value]", form).forEach(function (b) { b.classList.remove("is-active"); });
      q('[data-abc-count="abcQnaContent"]').textContent = "0";
    }, 0); });
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      if (!form.elements.qnaType.value) { toast("문의 유형을 선택해 주세요."); return; }
      if (!form.checkValidity()) { form.reportValidity(); return; }
      var template = q("#abcQnaHistoryTemplate");
      var list = q("#abcQnaHistoryList");
      if (template && list) {
        var row = template.content.cloneNode(true);
        q("[data-qna-product]", row).textContent = form.elements.productName.value;
        q("[data-qna-title]", row).textContent = form.elements.title.value;
        q("[data-qna-date]", row).textContent = new Date().toLocaleDateString("ko-KR");
        list.prepend(row);
      }
      form.reset();
      toast("연습용 상품문의가 목록에 추가되었습니다.");
      setPanel("history");
    });
  }
})();
