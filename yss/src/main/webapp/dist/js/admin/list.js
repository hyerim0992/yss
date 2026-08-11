(function () {
  "use strict";

  var page = window.AdminPageData;
  var currentPageKey = window.AdminPageKey || "admin";
  var answers = window.AdminPageAnswers || {};
  var questionContents = window.AdminQuestionContents || {};

  if (!page || !Array.isArray(page.sections)) {
    console.error("[ADMIN] 페이지 데이터가 없습니다.");
    return;
  }

  var currentSectionIndex = 0;
  var filteredRows = [];
  var currentPageNumber = 1;
  var pageSize = 5;
  var editingIndex = -1;
  var answeringIndex = -1;
  var confirmAction = null;

  var sectionFieldOptions = {
    "브랜드 관리": { "상태": ["사용중", "사용중지"] },
    "공지사항 관리": {
      "공지등록": ["상단고정", "일반"],
      "상태": ["공개", "비공개"]
    }
  };

  var fixedAddValues = {
    "회원 등록 / 검색": { "상태": "일반" },
    "회원 제재 목록": { "상태": "진행중" },
    "쿠폰 관리": { "상태": "발급중" },
    "등록 상품 조회": { "상태": "판매중" },
    "브랜드 관리": { "상태": "사용중" },
    "재고 관리": { "상태": "입고완료" },
    "1:1 문의 관리": { "답변상태": "미답변", "담당자": "-" }
  };

  function sectionConfig() {
    return page.sections[currentSectionIndex];
  }

  function esc(value) {
    return String(value == null ? "" : value).replace(/[&<>"']/g, function (ch) {
      return {
        "&": "&amp;",
        "<": "&lt;",
        ">": "&gt;",
        '"': "&quot;",
        "'": "&#39;"
      }[ch];
    });
  }

  function showToast(message) {
    var toast = document.getElementById("toast");
    if (!toast) return;
    toast.textContent = message;
    toast.classList.add("show");
    clearTimeout(showToast.timer);
    showToast.timer = setTimeout(function () {
      toast.classList.remove("show");
    }, 1800);
  }

  function statusClass(value) {
    var text = String(value);
    if (/완료|일반|정상|판매중|배송중|공개|사용중|입고완료|발급중|일치|해제/.test(text)) return "green";
    if (/대기|예정|준비|진행|처리중|접수|확인중|출고대기|집화완료|배달출발/.test(text)) return "orange";
    if (/제한|불가|품절|요청|미답변|비공개|만료|종료|반려|상이|재고부족/.test(text)) return "gray";
    return "blue";
  }

  function isStatus(value) {
    return /완료|일반|정상|판매중|배송중|공개|사용중|입고완료|발급중|일치|해제|대기|예정|준비|진행|처리중|접수|확인중|출고대기|집화완료|배달출발|제한|불가|품절|요청|미답변|비공개|만료|종료|반려|상이|재고부족/.test(String(value));
  }

  function uniqueValues(values) {
    var result = [];
    values.forEach(function (value) {
      var text = String(value == null ? "" : value).trim();
      if (text && result.indexOf(text) === -1) result.push(text);
    });
    return result;
  }

  function fieldOptions(section, header, fieldIndex) {
    var options = [];
    var configured = sectionFieldOptions[section.name];

    if (configured && configured[header]) {
      options = options.concat(configured[header]);
    }

    (section.filters || []).forEach(function (filter) {
      if (filter.type === "select" &&
          filter.column === fieldIndex &&
          Array.isArray(filter.options)) {
        options = options.concat(filter.options);
      }
    });

    if (/상태/.test(header) || options.length) {
      options = options.concat(section.rows.map(function (row) {
        return row[fieldIndex];
      }));
    }

    return uniqueValues(options);
  }

  function fixedAddValue(section, header) {
    var configured = fixedAddValues[section.name];
    return configured && Object.prototype.hasOwnProperty.call(configured, header)
      ? configured[header]
      : null;
  }

  function renderModalField(section, header, fieldIndex, value) {
    var fixedValue = editingIndex === -1 ? fixedAddValue(section, header) : null;
    var options = fieldOptions(section, header, fieldIndex);
    var selectedValue = fixedValue !== null ? fixedValue : value;

    if (fixedValue !== null && options.indexOf(fixedValue) === -1) {
      options.unshift(fixedValue);
    }

    if (options.length) {
      var optionHtml = options.map(function (option) {
        return '<option value="' + esc(option) + '"' +
          (String(option) === String(selectedValue) ? " selected" : "") +
          ">" + esc(option) + "</option>";
      }).join("");

      if (fixedValue === null && editingIndex === -1) {
        optionHtml = '<option value="">선택해 주세요</option>' + optionHtml;
      }

      return '<div class="form-field">' +
        '<label for="field' + fieldIndex + '">' + esc(header) + '</label>' +
        '<select id="field' + fieldIndex + '"' +
        (fixedValue !== null ? ' class="fixed-field" disabled' : " required") +
        ">" + optionHtml + "</select>" +
        (fixedValue !== null
          ? '<small class="field-help fixed-help">신규 등록 시 자동으로 “' + esc(fixedValue) + '” 처리됩니다.</small>'
          : '<small class="field-help">목록에서 상태를 선택해 주세요.</small>') +
        "</div>";
    }

    return '<div class="form-field">' +
      '<label for="field' + fieldIndex + '">' + esc(header) + '</label>' +
      '<input id="field' + fieldIndex + '" value="' + esc(selectedValue || "") + '"' +
      (fixedValue !== null ? ' class="fixed-field" readonly' : " required") +
      ">" +
      (fixedValue !== null
        ? '<small class="field-help fixed-help">신규 등록 시 자동으로 “' + esc(fixedValue) + '” 입력됩니다.</small>'
        : "") +
      "</div>";
  }

  function renderFilters() {
    var section = sectionConfig();
    var filters = section.filters || [];
    var container = document.getElementById("filterFields");

    container.innerHTML = filters.map(function (filter) {
      if (filter.type === "dateRange") {
        return '<div class="filter-control range-control">' +
          "<label>" + esc(filter.label) + "</label>" +
          '<div class="filter-date-range">' +
          '<input type="date" id="filter-' + esc(filter.id) + '-from" aria-label="' + esc(filter.label) + ' 시작일">' +
          "<span>~</span>" +
          '<input type="date" id="filter-' + esc(filter.id) + '-to" aria-label="' + esc(filter.label) + ' 종료일">' +
          "</div></div>";
      }

      return '<div class="filter-control">' +
        '<label for="filter-' + esc(filter.id) + '">' + esc(filter.label) + "</label>" +
        '<select id="filter-' + esc(filter.id) + '"><option value="">전체</option>' +
        filter.options.map(function (option) {
          return '<option value="' + esc(option) + '">' + esc(option) + "</option>";
        }).join("") +
        "</select></div>";
    }).join("");

    container.classList.toggle("is-hidden", filters.length === 0);
  }

  function matchesExtraFilters(row) {
    var filters = sectionConfig().filters || [];

    return filters.every(function (filter) {
      var cell = String(row[filter.column] || "");

      if (filter.type === "dateRange") {
        var fromEl = document.getElementById("filter-" + filter.id + "-from");
        var toEl = document.getElementById("filter-" + filter.id + "-to");
        var from = fromEl ? fromEl.value : "";
        var to = toEl ? toEl.value : "";
        var dateValue = cell.slice(0, 10);
        if (from && dateValue < from) return false;
        if (to && dateValue > to) return false;
        return true;
      }

      var select = document.getElementById("filter-" + filter.id);
      var value = select ? select.value : "";
      return !value || cell === value;
    });
  }

  function applySearch() {
    var keyword = document.getElementById("searchKeyword").value.trim().toLowerCase();
    var type = document.getElementById("searchType").selectedIndex - 1;
    var section = sectionConfig();

    filteredRows = section.rows.map(function (row, index) {
      return { row: row, index: index };
    }).filter(function (item) {
      var keywordMatched = true;

      if (keyword) {
        if (type >= 0 && type < item.row.length) {
          keywordMatched = String(item.row[type]).toLowerCase().indexOf(keyword) > -1;
        } else {
          keywordMatched = item.row.join(" ").toLowerCase().indexOf(keyword) > -1;
        }
      }
      return keywordMatched && matchesExtraFilters(item.row);
    });

    currentPageNumber = 1;
    renderTable();
  }

  function renderTable() {
    var section = sectionConfig();
    var start = (currentPageNumber - 1) * pageSize;
    var items = filteredRows.slice(start, start + pageSize);

    document.getElementById("dataHead").innerHTML =
      '<tr><th><input type="checkbox" class="check-all" id="checkAll" aria-label="현재 페이지 전체 선택"></th>' +
      section.headers.map(function (header) {
        return "<th>" + esc(header) + "</th>";
      }).join("") +
      "<th>관리</th></tr>";

    document.getElementById("dataBody").innerHTML = items.map(function (item) {
      var answerButton = "";

      if (section.answerable) {
        var idColumn = section.answerFields.id;
        var completed = Boolean(answers[item.row[idColumn]]);
        answerButton =
          '<button type="button" class="light-btn answer-btn ' +
          (completed ? "completed" : "") + '">' +
          (completed ? "답변 수정" : "답변 등록") +
          "</button>";
      }

      return '<tr data-index="' + item.index + '">' +
        '<td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>' +
        item.row.map(function (value) {
          return "<td>" +
            (isStatus(value)
              ? '<span class="badge ' + statusClass(value) + '">' + esc(value) + "</span>"
              : esc(value)) +
            "</td>";
        }).join("") +
        '<td class="action-cell">' +
        answerButton +
        '<button type="button" class="light-btn edit-row">수정</button>' +
        '<button type="button" class="light-btn delete-row">삭제</button>' +
        "</td></tr>";
    }).join("");

    document.getElementById("resultCount").textContent = filteredRows.length;
    document.getElementById("selectedCount").textContent = "0";
    document.getElementById("emptyState").classList.toggle("show", items.length === 0);

    renderPagination();
    bindTableEvents();
  }

  function renderPagination() {
    var totalPages = Math.max(1, Math.ceil(filteredRows.length / pageSize));
    var html = '<button type="button" data-page-number="prev"' +
      (currentPageNumber === 1 ? " disabled" : "") + ">‹</button>";

    for (var i = 1; i <= totalPages; i += 1) {
      html += '<button type="button" data-page-number="' + i + '" class="' +
        (i === currentPageNumber ? "active" : "") + '">' + i + "</button>";
    }

    html += '<button type="button" data-page-number="next"' +
      (currentPageNumber === totalPages ? " disabled" : "") + ">›</button>";

    document.getElementById("pagination").innerHTML = html;

    document.querySelectorAll("#pagination button").forEach(function (button) {
      button.addEventListener("click", function () {
        var value = button.getAttribute("data-page-number");
        if (value === "prev") currentPageNumber -= 1;
        else if (value === "next") currentPageNumber += 1;
        else currentPageNumber = Number(value);
        renderTable();
      });
    });
  }

  function updateSelectedCount() {
    document.getElementById("selectedCount").textContent =
      document.querySelectorAll(".row-check:checked").length;
  }

  function bindTableEvents() {
    var checkAll = document.getElementById("checkAll");

    if (checkAll) {
      checkAll.addEventListener("change", function () {
        document.querySelectorAll(".row-check").forEach(function (check) {
          check.checked = checkAll.checked;
        });
        updateSelectedCount();
      });
    }

    document.querySelectorAll(".row-check").forEach(function (check) {
      check.addEventListener("change", updateSelectedCount);
    });

    document.querySelectorAll(".edit-row").forEach(function (button) {
      button.addEventListener("click", function () {
        openModal(Number(button.closest("tr").getAttribute("data-index")));
      });
    });

    document.querySelectorAll(".delete-row").forEach(function (button) {
      button.addEventListener("click", function () {
        var index = Number(button.closest("tr").getAttribute("data-index"));
        askConfirm("선택한 항목을 삭제할까요?", "화면의 예시 데이터에서 삭제됩니다.", function () {
          sectionConfig().rows.splice(index, 1);
          applySearch();
          showToast("항목을 삭제했습니다.");
        });
      });
    });

    document.querySelectorAll(".answer-btn").forEach(function (button) {
      button.addEventListener("click", function () {
        openAnswerModal(Number(button.closest("tr").getAttribute("data-index")));
      });
    });
  }

  function renderSection() {
    var section = sectionConfig();

    document.getElementById("tableTitle").textContent = section.table;
    document.getElementById("searchType").innerHTML =
      "<option>전체</option>" +
      section.headers.map(function (header) {
        return "<option>" + esc(header) + "</option>";
      }).join("");

    document.getElementById("searchKeyword").value = "";

    var addButton = document.getElementById("addButton");
    addButton.textContent = section.addLabel || "+ 신규 등록";
    addButton.classList.toggle("is-hidden", section.canAdd === false);

    renderFilters();
    applySearch();
  }

  function bindTabs() {
    document.querySelectorAll("#subTabs button").forEach(function (button) {
      button.addEventListener("click", function () {
        currentSectionIndex = Number(button.getAttribute("data-section-index"));
        document.querySelectorAll("#subTabs button").forEach(function (item) {
          item.classList.remove("active");
        });
        button.classList.add("active");
        renderSection();
        showToast(button.textContent + " 화면으로 변경했습니다.");
      });
    });
  }

  function renderPage() {
    document.getElementById("pageTitle").textContent = page.title;
    document.getElementById("pageDesc").textContent = page.desc;
    document.getElementById("breadcrumb").textContent = "관리자 페이지 / " + page.title;

    document.getElementById("subTabs").innerHTML = page.sections.map(function (section, index) {
      return '<button type="button" data-section-index="' + index + '" class="' +
        (index === 0 ? "active" : "") + '">' + esc(section.name) + "</button>";
    }).join("");

    bindTabs();
    renderSection();
  }

  function openModal(index) {
    var section = sectionConfig();
    editingIndex = typeof index === "number" ? index : -1;

    document.getElementById("modalTitle").textContent =
      editingIndex > -1
        ? "정보 수정"
        : (section.addLabel || "+ 신규 등록").replace(/^\+\s*/, "");

    document.getElementById("modalGuide").textContent =
      editingIndex > -1
        ? "상태 항목은 드롭다운에서 변경할 수 있습니다."
        : "업무 흐름상 자동으로 결정되는 상태는 고정되어 저장됩니다.";

    document.getElementById("formFields").innerHTML = section.headers.map(function (header, fieldIndex) {
      var value = editingIndex > -1 ? section.rows[editingIndex][fieldIndex] : "";
      return renderModalField(section, header, fieldIndex, value);
    }).join("");

    var editModal = document.getElementById("editModal");
    editModal.hidden = false;
    editModal.classList.add("show");
    editModal.setAttribute("aria-hidden", "false");
    document.body.classList.add("admin-modal-open");

    var firstField = document.querySelector(
      '#formFields input:not([readonly]), #formFields select:not([disabled])'
    );
    if (firstField) firstField.focus();
  }

  function closeModal() {
    var editModal = document.getElementById("editModal");
    editModal.classList.remove("show");
    editModal.hidden = true;
    editModal.setAttribute("aria-hidden", "true");
    document.body.classList.remove("admin-modal-open");
  }

  function openAnswerModal(index) {
    var section = sectionConfig();
    if (!section.answerable || !section.answerFields) return;

    var fields = section.answerFields;
    var row = section.rows[index];
    var number = row[fields.id];
    var hasAnswer = Boolean(answers[number]);

    answeringIndex = index;
    document.getElementById("answerModalTitle").textContent = hasAnswer ? "답변 수정" : "답변 등록";
    document.getElementById("answerModalGuide").textContent = hasAnswer
      ? "등록된 답변을 수정하거나 삭제할 수 있습니다."
      : "문의 내용을 확인하고 답변을 등록해 주세요.";
    document.getElementById("answerQuestionNumber").textContent = number;
    document.getElementById("answerWriter").textContent = row[fields.writer];
    document.getElementById("answerQuestionTitle").textContent = row[fields.title];
    document.getElementById("answerQuestionContent").textContent =
      questionContents[number] || row[fields.title];
    document.getElementById("answerText").value = answers[number] || "";
    document.getElementById("answerCount").textContent =
      document.getElementById("answerText").value.length;
    document.getElementById("answerSave").textContent = hasAnswer ? "답변 수정" : "답변 등록";
    document.getElementById("answerDelete").style.display = hasAnswer ? "inline-block" : "none";

    var answerModal = document.getElementById("answerModal");
    answerModal.hidden = false;
    answerModal.classList.add("show");
    answerModal.setAttribute("aria-hidden", "false");
    document.body.classList.add("admin-modal-open");

    setTimeout(function () {
      document.getElementById("answerText").focus();
    }, 0);
  }

  function closeAnswerModal() {
    var answerModal = document.getElementById("answerModal");
    answerModal.classList.remove("show");
    answerModal.hidden = true;
    answerModal.setAttribute("aria-hidden", "true");
    answeringIndex = -1;
    document.body.classList.remove("admin-modal-open");
  }

  function askConfirm(title, text, action) {
    confirmAction = action;
    document.getElementById("confirmTitle").textContent = title;
    document.getElementById("confirmText").textContent = text;
    var confirmBox = document.getElementById("confirmBox");
    confirmBox.hidden = false;
    confirmBox.classList.add("show");
    confirmBox.setAttribute("aria-hidden", "false");
    document.body.classList.add("admin-modal-open");
  }

  function closeConfirm() {
    var confirmBox = document.getElementById("confirmBox");
    confirmBox.classList.remove("show");
    confirmBox.hidden = true;
    confirmBox.setAttribute("aria-hidden", "true");
    confirmAction = null;
    document.body.classList.remove("admin-modal-open");
  }

  function exportCsv() {
    var section = sectionConfig();
    var lines = [section.headers.join(",")].concat(
      filteredRows.map(function (item) {
        return item.row.map(function (value) {
          return '"' + String(value).replace(/"/g, '""') + '"';
        }).join(",");
      })
    );

    var blob = new Blob(["\ufeff" + lines.join("\n")], {
      type: "text/csv;charset=utf-8"
    });
    var url = URL.createObjectURL(blob);
    var link = document.createElement("a");
    link.href = url;
    link.download = currentPageKey + "-" + currentSectionIndex + "-list.csv";
    link.click();
    URL.revokeObjectURL(url);
    showToast("현재 검색 결과를 CSV로 저장했습니다.");
  }

  function bindStaticEvents() {
    document.getElementById("searchButton").addEventListener("click", function () {
      applySearch();
      showToast("검색 결과 " + filteredRows.length + "건을 찾았습니다.");
    });

    document.getElementById("searchKeyword").addEventListener("keydown", function (event) {
      if (event.key === "Enter") document.getElementById("searchButton").click();
    });

    document.getElementById("filterFields").addEventListener("change", applySearch);

    document.getElementById("resetButton").addEventListener("click", function () {
      document.getElementById("searchKeyword").value = "";
      document.getElementById("searchType").selectedIndex = 0;
      renderFilters();
      applySearch();
      showToast("검색 조건을 초기화했습니다.");
    });

    document.getElementById("addButton").addEventListener("click", function () {
      openModal();
    });

    document.getElementById("modalClose").addEventListener("click", closeModal);
    document.getElementById("modalCancel").addEventListener("click", closeModal);
    document.getElementById("editModal").addEventListener("click", function (event) {
      if (event.target === this) closeModal();
    });

    document.getElementById("editForm").addEventListener("submit", function (event) {
      event.preventDefault();

      var section = sectionConfig();
      var values = section.headers.map(function (header, index) {
        var field = document.getElementById("field" + index);
        return field ? String(field.value).trim() : "";
      });

      if (editingIndex > -1) {
        section.rows[editingIndex] = values;
        showToast("수정한 내용을 저장했습니다.");
      } else {
        section.rows.unshift(values);
        showToast("새 항목을 등록했습니다.");
      }

      closeModal();
      applySearch();
    });

    document.getElementById("answerModalClose").addEventListener("click", closeAnswerModal);
    document.getElementById("answerCancel").addEventListener("click", closeAnswerModal);
    document.getElementById("answerModal").addEventListener("click", function (event) {
      if (event.target === this) closeAnswerModal();
    });

    document.getElementById("answerText").addEventListener("input", function () {
      document.getElementById("answerCount").textContent = this.value.length;
    });

    document.getElementById("answerForm").addEventListener("submit", function (event) {
      event.preventDefault();

      var section = sectionConfig();
      if (!section.answerable || answeringIndex < 0) return;

      var fields = section.answerFields;
      var row = section.rows[answeringIndex];
      var text = document.getElementById("answerText").value.trim();

      if (!text) {
        document.getElementById("answerText").focus();
        showToast("답변 내용을 입력해 주세요.");
        return;
      }

      answers[row[fields.id]] = text;
      row[fields.status] = "답변완료";
      row[fields.manager] = "관리자";
      closeAnswerModal();
      applySearch();
      showToast("답변을 저장하고 답변완료로 변경했습니다.");
    });

    document.getElementById("answerDelete").addEventListener("click", function () {
      var section = sectionConfig();
      if (!section.answerable || answeringIndex < 0) return;

      var fields = section.answerFields;
      var row = section.rows[answeringIndex];

      closeAnswerModal();
      askConfirm("등록된 답변을 삭제할까요?", "답변상태가 미답변으로 변경됩니다.", function () {
        delete answers[row[fields.id]];
        row[fields.status] = "미답변";
        row[fields.manager] = "-";
        applySearch();
        showToast("답변을 삭제하고 미답변으로 변경했습니다.");
      });
    });

    document.getElementById("deleteSelectedButton").addEventListener("click", function () {
      var indices = Array.prototype.map.call(
        document.querySelectorAll(".row-check:checked"),
        function (check) {
          return Number(check.closest("tr").getAttribute("data-index"));
        }
      );

      if (!indices.length) {
        showToast("먼저 삭제할 항목을 체크해 주세요.");
        return;
      }

      askConfirm("선택한 " + indices.length + "개 항목을 삭제할까요?", "화면의 예시 데이터에서 삭제됩니다.", function () {
        indices.sort(function (a, b) {
          return b - a;
        }).forEach(function (index) {
          sectionConfig().rows.splice(index, 1);
        });
        applySearch();
        showToast(indices.length + "개 항목을 삭제했습니다.");
      });
    });

    document.getElementById("exportButton").addEventListener("click", exportCsv);
    document.getElementById("confirmCancel").addEventListener("click", closeConfirm);
    document.getElementById("confirmOk").addEventListener("click", function () {
      var action = confirmAction;
      closeConfirm();
      if (action) action();
    });

    document.addEventListener("keydown", function (event) {
      if (event.key === "Escape") {
        closeModal();
        closeAnswerModal();
        closeConfirm();
      }
    });
  }

  function init() {
    bindStaticEvents();
    renderPage();
    window.AdminUI = {
      openAddModal: function () { openModal(); },
      closeAddModal: closeModal,
      renderPage: renderPage
    };
    window.ADMIN_UI_READY = true;
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
