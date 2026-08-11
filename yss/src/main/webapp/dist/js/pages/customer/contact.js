(function () {
  "use strict";

  function q(selector, scope) {
    return (scope || document).querySelector(selector);
  }

  function qa(selector, scope) {
    return Array.prototype.slice.call((scope || document).querySelectorAll(selector));
  }

  var page = q("#abcCsPage");
  if (!page) {
    return;
  }

  var isLoggedIn = page.getAttribute("data-logged-in") === "true";
  var contextPath = page.getAttribute("data-context-path") || "";

  function requireLogin() {
    showToast("로그인 후 이용할 수 있습니다.");
    window.setTimeout(function () {
      window.location.href = contextPath + "/member/login";
    }, 650);
  }

  var toastTimer;
  function showToast(message) {
    var toast = q("#abcCsToast");
    if (!toast) {
      return;
    }
    toast.textContent = message;
    toast.classList.add("is-show");
    window.clearTimeout(toastTimer);
    toastTimer = window.setTimeout(function () {
      toast.classList.remove("is-show");
    }, 2400);
  }

  function openView(name, updateHash) {
    qa("[data-abc-view]").forEach(function (view) {
      var active = view.getAttribute("data-abc-view") === name;
      view.hidden = !active;
      view.classList.toggle("is-active", active);
    });

    qa("[data-abc-open]").forEach(function (button) {
      button.classList.toggle("is-active", button.getAttribute("data-abc-open") === name);
    });

    if (updateHash && window.history && window.history.replaceState) {
      window.history.replaceState(null, "", window.location.pathname + window.location.search + "#" + name);
    }

    if (updateHash) {
      var content = q(".abc-cs-content");
      if (content) {
        window.setTimeout(function () {
          var headerOffset = 24;
          var targetTop = content.getBoundingClientRect().top + window.pageYOffset - headerOffset;
          window.scrollTo({
            top: Math.max(targetTop, 0),
            behavior: "smooth"
          });
        }, 0);
      }
    }
  }

  qa("[data-abc-open]").forEach(function (button) {
    button.addEventListener("click", function () {
      openView(button.getAttribute("data-abc-open"), true);
    });
  });

  function setInquiryPanel(panelName, updateHash) {
    var tabs = qa("[data-abc-inquiry-tab]");
    var panels = qa("[data-abc-inquiry-panel]");

    if (!tabs.length || !panels.length) {
      return;
    }

    tabs.forEach(function (item) {
      item.classList.toggle("is-active", item.getAttribute("data-abc-inquiry-tab") === panelName);
    });

    panels.forEach(function (panel) {
      panel.hidden = panel.getAttribute("data-abc-inquiry-panel") !== panelName;
    });

    if (panelName === "history") {
      renderInquiryHistory();
    }

    if (updateHash && window.history && window.history.replaceState) {
      window.history.replaceState(null, "", window.location.pathname + window.location.search + (panelName === "history" ? "#inquiry-history" : "#inquiry"));
    }
  }

  function openViewFromHash() {
    var startView = (window.location.hash || "").replace("#", "");

    if (startView === "inquiry-history") {
      openView("inquiry", false);
      setInquiryPanel("history", false);
      return;
    }

    if (["faq", "notice", "inquiry", "voice"].indexOf(startView) !== -1) {
      openView(startView, false);
      return;
    }

    openView("faq", false);
  }

  openViewFromHash();
  window.addEventListener("hashchange", openViewFromHash);

  var faqCategory = "전체";
  function filterFaq() {
    var input = q("#abcFaqSearchInput");
    var keyword = input ? (input.value || "").trim().toLowerCase() : "";
    var visible = 0;

    qa(".abc-cs-faq-item").forEach(function (item) {
      var categoryMatch = faqCategory === "전체" || item.getAttribute("data-category") === faqCategory;
      var keywordMatch = !keyword || (item.getAttribute("data-search") || "").toLowerCase().indexOf(keyword) !== -1;
      var show = categoryMatch && keywordMatch;
      item.hidden = !show;
      if (show) {
        visible += 1;
      }
    });

    var count = q("#abcFaqCount");
    var empty = q("#abcFaqEmpty");
    if (count) {
      count.textContent = String(visible);
    }
    if (empty) {
      empty.hidden = visible !== 0;
    }
  }

  qa("[data-abc-faq-category]").forEach(function (button) {
    button.addEventListener("click", function () {
      faqCategory = button.getAttribute("data-abc-faq-category");
      qa("[data-abc-faq-category]").forEach(function (item) {
        item.classList.remove("is-active");
      });
      button.classList.add("is-active");
      filterFaq();
    });
  });

  var faqForm = q("#abcFaqSearchForm");
  var faqInput = q("#abcFaqSearchInput");
  if (faqForm) {
    faqForm.addEventListener("submit", function (event) {
      event.preventDefault();
      filterFaq();
    });
  }
  if (faqInput) {
    faqInput.addEventListener("input", filterFaq);
  }

  qa(".abc-cs-faq-question").forEach(function (button) {
    button.addEventListener("click", function () {
      var item = button.parentElement;
      var willOpen = !item.classList.contains("is-open");

      qa(".abc-cs-faq-item.is-open").forEach(function (opened) {
        opened.classList.remove("is-open");
        var openedButton = q(".abc-cs-faq-question", opened);
        if (openedButton) {
          openedButton.setAttribute("aria-expanded", "false");
        }
      });

      item.classList.toggle("is-open", willOpen);
      button.setAttribute("aria-expanded", willOpen ? "true" : "false");
    });
  });

  var noticeCategory = "전체";
  function filterNotices() {
    var input = q("#abcNoticeSearchInput");
    var keyword = input ? (input.value || "").trim().toLowerCase() : "";
    var visible = 0;

    qa(".abc-cs-notice-row").forEach(function (row) {
      var categoryMatch = noticeCategory === "전체" || row.getAttribute("data-category") === noticeCategory;
      var keywordMatch = !keyword || (row.getAttribute("data-title") || "").toLowerCase().indexOf(keyword) !== -1;
      var show = categoryMatch && keywordMatch;
      row.hidden = !show;
      if (show) {
        visible += 1;
      }
    });

    var empty = q("#abcNoticeEmpty");
    if (empty) {
      empty.hidden = visible !== 0;
    }
  }

  qa("[data-abc-notice-category]").forEach(function (button) {
    button.addEventListener("click", function () {
      noticeCategory = button.getAttribute("data-abc-notice-category");
      qa("[data-abc-notice-category]").forEach(function (item) {
        item.classList.remove("is-active");
      });
      button.classList.add("is-active");
      filterNotices();
    });
  });

  var noticeForm = q("#abcNoticeSearchForm");
  var noticeInput = q("#abcNoticeSearchInput");
  if (noticeForm) {
    noticeForm.addEventListener("submit", function (event) {
      event.preventDefault();
      filterNotices();
    });
  }
  if (noticeInput) {
    noticeInput.addEventListener("input", filterNotices);
  }

  qa(".abc-cs-notice-row").forEach(function (row) {
    row.addEventListener("click", function () {
      q("#abcNoticeDetailType").textContent = row.getAttribute("data-category");
      q("#abcNoticeDetailTitle").textContent = row.getAttribute("data-title");
      q("#abcNoticeDetailDate").textContent = row.getAttribute("data-date");
      q("#abcNoticeDetailBody").textContent = row.getAttribute("data-body");
      q("#abcNoticeList").hidden = true;
      q("#abcNoticeEmpty").hidden = true;
      q("#abcNoticeDetail").hidden = false;
      q("#abcNoticeSearchForm").hidden = true;
      q(".abc-cs-category-grid--notice").hidden = true;
      q(".abc-cs-notice-columns").hidden = true;
    });
  });

  var noticeBack = q("#abcNoticeBack");
  if (noticeBack) {
    noticeBack.addEventListener("click", function () {
      q("#abcNoticeList").hidden = false;
      q("#abcNoticeDetail").hidden = true;
      q("#abcNoticeSearchForm").hidden = false;
      q(".abc-cs-category-grid--notice").hidden = false;
      q(".abc-cs-notice-columns").hidden = false;
      filterNotices();
    });
  }

  qa("[data-abc-inquiry-tab]").forEach(function (button) {
    button.addEventListener("click", function () {
      if (!isLoggedIn) {
        requireLogin();
        return;
      }
      setInquiryPanel(button.getAttribute("data-abc-inquiry-tab"), true);
    });
  });

  qa("[data-choice-group]").forEach(function (group) {
    var hiddenInput = q('input[type="hidden"]', group);
    qa("[data-choice-value]", group).forEach(function (button) {
      button.addEventListener("click", function () {
        qa("[data-choice-value]", group).forEach(function (item) {
          item.classList.remove("is-active");
        });
        button.classList.add("is-active");
        if (hiddenInput) {
          hiddenInput.value = button.getAttribute("data-choice-value");
        }
      });
    });
  });

  qa("[data-abc-count]").forEach(function (counter) {
    var field = q("#" + counter.getAttribute("data-abc-count"));
    if (!field) {
      return;
    }
    field.addEventListener("input", function () {
      counter.textContent = String(field.value.length);
    });
  });

  var filesInput = q("#abcInquiryFiles");
  if (filesInput) {
    filesInput.addEventListener("change", function () {
      var files = Array.prototype.slice.call(filesInput.files || []);
      var list = q("#abcInquiryFileList");
      list.innerHTML = "";

      files.slice(0, 3).forEach(function (file) {
        var tag = document.createElement("span");
        tag.textContent = file.name;
        list.appendChild(tag);
      });

      if (files.length > 3) {
        showToast("파일은 최대 3개까지 첨부할 수 있습니다.");
      }
    });
  }

  function readInquiryHistory() {
    try {
      return JSON.parse(window.localStorage.getItem("yongsinsaCustomerInquiries") || "[]");
    } catch (error) {
      return [];
    }
  }

  function writeInquiryHistory(items) {
    try {
      window.localStorage.setItem("yongsinsaCustomerInquiries", JSON.stringify(items));
    } catch (error) {
      return;
    }
  }

  function renderInquiryHistory() {
    var items = readInquiryHistory();
    var list = q("#abcInquiryHistoryList");
    var empty = q("#abcInquiryHistoryEmpty");

    if (!list || !empty) {
      return;
    }

    list.innerHTML = "";
    empty.hidden = items.length !== 0;

    items.forEach(function (item) {
      var row = document.createElement("div");
      row.className = "abc-cs-history-row";

      var type = document.createElement("span");
      type.textContent = item.type;
      var title = document.createElement("strong");
      title.textContent = item.title;
      var date = document.createElement("time");
      date.textContent = item.date;

      row.appendChild(type);
      row.appendChild(title);
      row.appendChild(date);
      list.appendChild(row);
    });
  }

  function resetChoiceGroups(form) {
    qa("[data-choice-group]", form).forEach(function (group) {
      qa("[data-choice-value]", group).forEach(function (button) {
        button.classList.remove("is-active");
      });
      var hidden = q('input[type="hidden"]', group);
      if (hidden) {
        hidden.value = "";
      }
    });
  }

  var inquiryForm = q("#abcInquiryForm");
  if (inquiryForm) {
    inquiryForm.addEventListener("reset", function () {
      window.setTimeout(function () {
        resetChoiceGroups(inquiryForm);
        q('[data-abc-count="abcInquiryContent"]').textContent = "0";
        q("#abcInquiryFileList").innerHTML = "";
      }, 0);
    });

    inquiryForm.addEventListener("submit", function (event) {
      event.preventDefault();

      if (!isLoggedIn) {
        requireLogin();
        return;
      }

      if (!inquiryForm.elements.inquiryType.value || !inquiryForm.elements.inquiryDetail.value) {
        showToast("문의 유형과 상세 유형을 선택해 주세요.");
        return;
      }

      if (!inquiryForm.checkValidity()) {
        inquiryForm.reportValidity();
        return;
      }

      var items = readInquiryHistory();
      items.unshift({
        type: inquiryForm.elements.inquiryType.value,
        title: inquiryForm.elements.title.value,
        date: new Date().toLocaleDateString("ko-KR")
      });
      writeInquiryHistory(items.slice(0, 10));
      inquiryForm.reset();
      showToast("문의가 접수되었습니다. 문의내역으로 이동합니다.");
      setInquiryPanel("history", true);

      var historyPanel = q('[data-abc-inquiry-panel="history"]');
      if (historyPanel) {
        window.setTimeout(function () {
          historyPanel.scrollIntoView({ behavior: "smooth", block: "start" });
        }, 80);
      }
    });
  }

  var voiceForm = q("#abcVoiceForm");
  if (voiceForm) {
    voiceForm.addEventListener("reset", function () {
      window.setTimeout(function () {
        resetChoiceGroups(voiceForm);
        q('[data-abc-count="abcVoiceContent"]').textContent = "0";
      }, 0);
    });

    voiceForm.addEventListener("submit", function (event) {
      event.preventDefault();

      if (!isLoggedIn) {
        requireLogin();
        return;
      }

      if (!voiceForm.elements.voiceType.value || !voiceForm.elements.voiceDetail.value) {
        showToast("의견 유형과 상세 유형을 선택해 주세요.");
        return;
      }

      if (!voiceForm.checkValidity()) {
        voiceForm.reportValidity();
        return;
      }

      voiceForm.reset();
      showToast("소중한 의견이 접수되었습니다.");
    });
  }
})();
