(function () {
  "use strict";

  var root = document.querySelector(".admin-static-page");
  if (!root) return;

  var pageSize = 5;
  var currentSection = null;
  var currentPage = 1;
  var editingRow = null;
  var confirmAction = null;

  function qs(selector, parent) {
    return (parent || document).querySelector(selector);
  }

  function qsa(selector, parent) {
    return Array.prototype.slice.call((parent || document).querySelectorAll(selector));
  }

  function showToast(message) {
    var toast = qs("#toast");
    if (!toast) return;
    toast.textContent = message;
    toast.classList.add("show");
    window.clearTimeout(showToast.timer);
    showToast.timer = window.setTimeout(function () {
      toast.classList.remove("show");
    }, 1800);
  }

  function statusClass(value) {
    var text = String(value || "");
    if (/완료|일반|정상|판매중|배송중|공개|사용중|입고완료|발급중|일치|해제/.test(text)) return "green";
    if (/대기|예정|준비|진행|처리중|접수|확인중|출고대기|집화완료|배달출발/.test(text)) return "orange";
    if (/제한|불가|품절|요청|미답변|비공개|만료|종료|반려|상이|재고부족/.test(text)) return "gray";
    return "blue";
  }

  function getCellValue(row, index) {
    var cell = qs('[data-field-index="' + index + '"]', row);
    return cell ? cell.textContent.trim() : "";
  }

  function setCellValue(row, index, value) {
    var cell = qs('[data-field-index="' + index + '"]', row);
    if (!cell) return;
    var badge = qs(".badge", cell);
    if (badge) {
      badge.textContent = value;
      badge.classList.remove("green", "orange", "gray", "blue");
      badge.classList.add(statusClass(value));
    } else {
      cell.textContent = value;
    }
  }

  function allRows(section) {
    return qsa(".data-body .data-row", section);
  }

  function matchesExtraFilters(row, section) {
    return qsa(".filter-control[data-filter-column]", section).every(function (filter) {
      var column = Number(filter.getAttribute("data-filter-column"));
      var value = getCellValue(row, column);
      var type = filter.getAttribute("data-filter-type");

      if (type === "dateRange") {
        var from = qs(".filter-from", filter);
        var to = qs(".filter-to", filter);
        var fromValue = from ? from.value : "";
        var toValue = to ? to.value : "";
        var dateValue = value.slice(0, 10);
        if (fromValue && dateValue < fromValue) return false;
        if (toValue && dateValue > toValue) return false;
        return true;
      }

      var select = qs(".extra-filter", filter);
      return !select || !select.value || value === select.value;
    });
  }

  function filteredRows(section) {
    var keywordInput = qs(".js-search-keyword", section);
    var typeSelect = qs(".js-search-type", section);
    var keyword = keywordInput ? keywordInput.value.trim().toLowerCase() : "";
    var type = typeSelect ? typeSelect.value : "all";

    return allRows(section).filter(function (row) {
      var keywordMatched = true;
      if (keyword) {
        if (type === "all") {
          keywordMatched = row.textContent.toLowerCase().indexOf(keyword) !== -1;
        } else {
          keywordMatched = getCellValue(row, Number(type)).toLowerCase().indexOf(keyword) !== -1;
        }
      }
      return keywordMatched && matchesExtraFilters(row, section);
    });
  }

  function updateSelectedCount(section) {
    var count = qsa(".row-check:checked", section).length;
    var selected = qs(".selected-count", section);
    if (selected) selected.textContent = count;
  }

  function clonePaginationButton() {
    var template = qs("#paginationButtonTemplate", root);
    if (!template) return null;
    return template.content.firstElementChild.cloneNode(true);
  }

  function renderPagination(section, rows) {
    var pagination = qs(".pagination", section);
    if (!pagination) return;
    pagination.replaceChildren();

    var totalPages = Math.max(1, Math.ceil(rows.length / pageSize));
    if (currentPage > totalPages) currentPage = totalPages;

    var prev = clonePaginationButton();
    if (prev) {
      prev.textContent = "‹";
      prev.disabled = currentPage === 1;
      prev.setAttribute("aria-label", "이전 페이지");
      prev.addEventListener("click", function () {
        if (currentPage > 1) {
          currentPage -= 1;
          applySearch(section);
        }
      });
      pagination.appendChild(prev);
    }

    for (var i = 1; i <= totalPages; i += 1) {
      var button = clonePaginationButton();
      if (!button) continue;
      button.textContent = String(i);
      button.classList.toggle("active", i === currentPage);
      button.setAttribute("data-page", String(i));
      button.addEventListener("click", function () {
        currentPage = Number(this.getAttribute("data-page"));
        applySearch(section);
      });
      pagination.appendChild(button);
    }

    var next = clonePaginationButton();
    if (next) {
      next.textContent = "›";
      next.disabled = currentPage === totalPages;
      next.setAttribute("aria-label", "다음 페이지");
      next.addEventListener("click", function () {
        if (currentPage < totalPages) {
          currentPage += 1;
          applySearch(section);
        }
      });
      pagination.appendChild(next);
    }
  }

  function applySearch(section) {
    if (!section) return;
    var matched = filteredRows(section);
    var start = (currentPage - 1) * pageSize;
    var end = start + pageSize;

    allRows(section).forEach(function (row) {
      row.hidden = true;
    });

    matched.forEach(function (row, index) {
      row.hidden = !(index >= start && index < end);
    });

    var count = qs(".result-count", section);
    if (count) count.textContent = matched.length;

    var empty = qs(".empty-state", section);
    if (empty) empty.classList.toggle("show", matched.length === 0);

    var checkAll = qs(".check-all", section);
    if (checkAll) checkAll.checked = false;
    qsa(".row-check", section).forEach(function (check) { check.checked = false; });
    updateSelectedCount(section);
    renderPagination(section, matched);
  }

  function resetSection(section) {
    var keyword = qs(".js-search-keyword", section);
    var type = qs(".js-search-type", section);
    if (keyword) keyword.value = "";
    if (type) type.value = "all";
    qsa(".extra-filter", section).forEach(function (select) { select.value = ""; });
    qsa(".filter-from, .filter-to", section).forEach(function (input) { input.value = ""; });
    currentPage = 1;
    applySearch(section);
  }

  function activateSection(index) {
    var panels = qsa("[data-admin-section]", root);
    var tabs = qsa("[data-section-target]", root);
    var next = panels.filter(function (panel) {
      return Number(panel.getAttribute("data-admin-section")) === index;
    })[0];
    if (!next) return;

    panels.forEach(function (panel) {
      var active = panel === next;
      panel.hidden = !active;
      panel.classList.toggle("active", active);
    });
    tabs.forEach(function (tab) {
      tab.classList.toggle("active", Number(tab.getAttribute("data-section-target")) === index);
    });

    currentSection = next;
    currentPage = 1;

    var addButton = qs("#addButton");
    if (addButton) {
      addButton.textContent = next.getAttribute("data-add-label") || "+ 신규 등록";
      addButton.classList.toggle("is-hidden", next.getAttribute("data-can-add") === "false");
    }

    applySearch(next);
  }

  function openEditModal(row) {
    if (!currentSection) return;
    editingRow = row || null;

    var template = qs(".admin-form-template", currentSection);
    var fields = qs("#formFields");
    if (!template || !fields) return;

    fields.replaceChildren(template.content.cloneNode(true));

    qsa("[data-field-index]", fields).forEach(function (control) {
      var index = Number(control.getAttribute("data-field-index"));
      var defaultValue = control.getAttribute("data-default") || "";
      control.value = editingRow ? getCellValue(editingRow, index) : defaultValue;
    });

    var title = qs("#modalTitle");
    var guide = qs("#modalGuide");
    if (title) title.textContent = editingRow ? "정보 수정" : (currentSection.getAttribute("data-add-label") || "+ 신규 등록").replace(/^\+\s*/, "");
    if (guide) guide.textContent = editingRow ? "JSP에 작성된 입력 항목의 값을 수정합니다." : "JSP에 작성된 입력 항목에 새 값을 입력합니다.";

    var modal = qs("#editModal");
    if (!modal) return;
    modal.hidden = false;
    modal.classList.add("show");
    modal.setAttribute("aria-hidden", "false");
    document.body.classList.add("admin-modal-open");

    var first = qs("#formFields input, #formFields select");
    if (first) first.focus();
  }

  function closeEditModal() {
    var modal = qs("#editModal");
    if (!modal) return;
    modal.classList.remove("show");
    modal.hidden = true;
    modal.setAttribute("aria-hidden", "true");
    document.body.classList.remove("admin-modal-open");
    editingRow = null;
  }

  function saveEditModal() {
    if (!currentSection) return;
    var controls = qsa("#formFields [data-field-index]");
    var targetRow = editingRow;

    if (!targetRow) {
      var rowTemplate = qs(".admin-row-template", currentSection);
      var body = qs(".data-body", currentSection);
      if (!rowTemplate || !body) return;
      targetRow = rowTemplate.content.firstElementChild.cloneNode(true);
      body.insertBefore(targetRow, body.firstChild);
      bindRowEvents(targetRow, currentSection);
    }

    controls.forEach(function (control) {
      setCellValue(targetRow, Number(control.getAttribute("data-field-index")), String(control.value || "").trim());
    });

    closeEditModal();
    currentPage = 1;
    applySearch(currentSection);
  }

  function askConfirm(title, text, action) {
    confirmAction = action;
    var titleEl = qs("#confirmTitle");
    var textEl = qs("#confirmText");
    if (titleEl) titleEl.textContent = title;
    if (textEl) textEl.textContent = text;
    var box = qs("#confirmBox");
    if (!box) return;
    box.hidden = false;
    box.classList.add("show");
    box.setAttribute("aria-hidden", "false");
    document.body.classList.add("admin-modal-open");
  }

  function closeConfirm() {
    var box = qs("#confirmBox");
    if (!box) return;
    box.classList.remove("show");
    box.hidden = true;
    box.setAttribute("aria-hidden", "true");
    document.body.classList.remove("admin-modal-open");
    confirmAction = null;
  }

  function bindRowEvents(row, section) {
    var check = qs(".row-check", row);
    var edit = qs(".edit-row", row);
    var del = qs(".delete-row", row);

    if (check) check.addEventListener("change", function () { updateSelectedCount(section); });
    if (edit) edit.addEventListener("click", function () { openEditModal(row); });
    if (del) {
      del.addEventListener("click", function () {
        askConfirm("선택한 항목을 삭제할까요?", "화면의 예시 데이터에서 삭제됩니다.", function () {
          row.remove();
          applySearch(section);
          showToast("항목을 삭제했습니다.");
        });
      });
    }
  }

  function exportCsv(section) {
    var headers = qsa("thead th", section).slice(1, -1).map(function (th) { return th.textContent.trim(); });
    var rows = filteredRows(section).map(function (row) {
      return qsa("td[data-field-index]", row).map(function (td) { return td.textContent.trim(); });
    });
    var lines = [headers].concat(rows).map(function (row) {
      return row.map(function (value) { return '"' + String(value).replace(/"/g, '""') + '"'; }).join(",");
    });
    var blob = new Blob(["\ufeff" + lines.join("\n")], { type: "text/csv;charset=utf-8" });
    var url = URL.createObjectURL(blob);
    var link = qs("#adminCsvDownloadLink", root);
    if (!link) {
      URL.revokeObjectURL(url);
      return;
    }
    link.href = url;
    link.download = (root.getAttribute("data-page-key") || "admin") + "-list.csv";
    link.click();
    URL.revokeObjectURL(url);
    showToast("현재 검색 결과를 CSV로 저장했습니다.");
  }

  function bindSection(section) {
    var searchButton = qs(".js-search-button", section);
    var keyword = qs(".js-search-keyword", section);
    var reset = qs(".js-reset-button", section);
    var checkAll = qs(".check-all", section);
    var deleteSelected = qs(".delete-selected-button", section);
    var exportButton = qs(".export-button", section);

    if (searchButton) searchButton.addEventListener("click", function () { currentPage = 1; applySearch(section); showToast("검색 결과를 갱신했습니다."); });
    if (keyword) keyword.addEventListener("keydown", function (event) { if (event.key === "Enter") { event.preventDefault(); currentPage = 1; applySearch(section); } });
    if (reset) reset.addEventListener("click", function () { resetSection(section); showToast("검색 조건을 초기화했습니다."); });
    qsa(".extra-filter, .filter-from, .filter-to", section).forEach(function (control) {
      control.addEventListener("change", function () { currentPage = 1; applySearch(section); });
    });

    if (checkAll) {
      checkAll.addEventListener("change", function () {
        allRows(section).filter(function (row) { return !row.hidden; }).forEach(function (row) {
          var check = qs(".row-check", row);
          if (check) check.checked = checkAll.checked;
        });
        updateSelectedCount(section);
      });
    }

    allRows(section).forEach(function (row) { bindRowEvents(row, section); });

    if (deleteSelected) {
      deleteSelected.addEventListener("click", function () {
        var selectedRows = qsa(".row-check:checked", section).map(function (check) { return check.closest("tr"); });
        if (!selectedRows.length) {
          showToast("먼저 삭제할 항목을 체크해 주세요.");
          return;
        }
        askConfirm("선택한 " + selectedRows.length + "개 항목을 삭제할까요?", "화면의 예시 데이터에서 삭제됩니다.", function () {
          selectedRows.forEach(function (row) { row.remove(); });
          applySearch(section);
          showToast(selectedRows.length + "개 항목을 삭제했습니다.");
        });
      });
    }

    if (exportButton) exportButton.addEventListener("click", function () { exportCsv(section); });
  }

  function bindModalEvents() {
    var addButton = qs("#addButton");
    var editForm = qs("#editForm");
    var modalClose = qs("#modalClose");
    var modalCancel = qs("#modalCancel");
    var editModal = qs("#editModal");
    var confirmCancel = qs("#confirmCancel");
    var confirmOk = qs("#confirmOk");

    if (addButton) addButton.addEventListener("click", function () { if (currentSection && currentSection.getAttribute("data-can-add") !== "false") openEditModal(null); });
    if (editForm) editForm.addEventListener("submit", function (event) { event.preventDefault(); var wasEditing = Boolean(editingRow); saveEditModal(); showToast(wasEditing ? "수정한 내용을 저장했습니다." : "새 항목을 등록했습니다."); });
    if (modalClose) modalClose.addEventListener("click", closeEditModal);
    if (modalCancel) modalCancel.addEventListener("click", closeEditModal);
    if (editModal) editModal.addEventListener("click", function (event) { if (event.target === editModal) closeEditModal(); });
    if (confirmCancel) confirmCancel.addEventListener("click", closeConfirm);
    if (confirmOk) confirmOk.addEventListener("click", function () { var action = confirmAction; closeConfirm(); if (action) action(); });

    document.addEventListener("keydown", function (event) {
      if (event.key === "Escape") {
        closeEditModal();
        closeConfirm();
      }
    });
  }

  function init() {
    qsa("[data-admin-section]", root).forEach(bindSection);
    qsa("[data-section-target]", root).forEach(function (tab) {
      tab.addEventListener("click", function () {
        activateSection(Number(tab.getAttribute("data-section-target")));
        showToast(tab.textContent.trim() + " 화면으로 변경했습니다.");
      });
    });
    bindModalEvents();
    activateSection(0);
    window.ADMIN_UI_READY = true;
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
