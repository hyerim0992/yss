"use strict";

// 회원관리 전용 JS
// 화면 HTML은 JSP에 두고, 이 파일에는 클릭/검색/페이징 같은 동작만 둡니다.
// Eclipse 호환을 위해 var / function 문법을 사용합니다.

var PAGE_SIZE = 10;
var root = document.querySelector(".admin-static-page");
var sections = qsa("[data-admin-section]");
var tabs = qsa("[data-section-target]");

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

function rows(section) {
    return qsa(".data-body .data-row", section);
}

function cellText(row, index) {
    var cell = qs('[data-field-index="' + index + '"]', row);
    return cell ? cell.textContent.trim() : "";
}

// 검색 조건 확인
function isMatch(row, section) {
    var keywordInput = qs(".js-search-keyword", section);
    var typeSelect = qs(".js-search-type", section);
    var keyword = keywordInput ? keywordInput.value.trim().toLowerCase() : "";
    var type = typeSelect ? typeSelect.value : "all";

    if (keyword) {
        var text = type === "all"
            ? row.textContent.toLowerCase()
            : cellText(row, Number(type)).toLowerCase();

        if (text.indexOf(keyword) === -1) {
            return false;
        }
    }

    var filters = qsa(".filter-control[data-filter-column]", section);

    return filters.every(function (filter) {
        var column = Number(filter.getAttribute("data-filter-column"));
        var value = cellText(row, column);
        var filterType = filter.getAttribute("data-filter-type");

        if (filterType === "dateRange") {
            var from = qs(".filter-from", filter);
            var to = qs(".filter-to", filter);
            var date = value.slice(0, 10);

            if (from && from.value && date < from.value) return false;
            if (to && to.value && date > to.value) return false;
            return true;
        }

        var select = qs(".extra-filter", filter);
        return !select || !select.value || value === select.value;
    });
}

function filteredRows(section) {
    return rows(section).filter(function (row) {
        return isMatch(row, section);
    });
}

// 현재 페이지 10개 표시
function showPage(section) {
    var matched = filteredRows(section);
    var totalPages = Math.max(1, Math.ceil(matched.length / PAGE_SIZE));
    var start;

    if (currentPage > totalPages) {
        currentPage = totalPages;
    }

    rows(section).forEach(function (row) {
        row.hidden = true;
    });

    start = (currentPage - 1) * PAGE_SIZE;
    matched.slice(start, start + PAGE_SIZE).forEach(function (row) {
        row.hidden = false;
    });

    var count = qs(".result-count", section);
    var empty = qs(".empty-state", section);
    var prev = qs(".page-prev", section);
    var next = qs(".page-next", section);
    var info = qs(".page-info", section);

    if (count) count.textContent = matched.length;
    if (empty) empty.classList.toggle("show", matched.length === 0);
    if (prev) prev.disabled = currentPage === 1;
    if (next) next.disabled = currentPage === totalPages;
    if (info) info.textContent = currentPage + " / " + totalPages;

    clearChecks(section);
}

function resetSearch(section) {
    var keyword = qs(".js-search-keyword", section);
    var type = qs(".js-search-type", section);

    if (keyword) keyword.value = "";
    if (type) type.value = "all";

    qsa(".extra-filter", section).forEach(function (select) {
        select.value = "";
    });

    qsa(".filter-from, .filter-to", section).forEach(function (input) {
        input.value = "";
    });

    currentPage = 1;
    showPage(section);
}

// 체크박스
function updateChecks(section) {
    var count = qsa(".row-check:checked", section).length;
    var countBox = qs(".selected-count", section);
    var checkAll = qs(".check-all", section);

    if (countBox) countBox.textContent = count;
    if (!checkAll) return;

    var visible = rows(section).filter(function (row) {
        return !row.hidden;
    }).map(function (row) {
        return qs(".row-check", row);
    }).filter(function (box) {
        return box !== null;
    });

    var checked = visible.filter(function (box) {
        return box.checked;
    }).length;

    checkAll.checked = visible.length > 0 && checked === visible.length;
    checkAll.indeterminate = checked > 0 && checked < visible.length;
}

function clearChecks(section) {
    qsa(".row-check", section).forEach(function (box) {
        box.checked = false;
    });

    var checkAll = qs(".check-all", section);
    if (checkAll) {
        checkAll.checked = false;
        checkAll.indeterminate = false;
    }

    updateChecks(section);
}

// 상단 탭 변경
function openSection(index) {
    var next = null;

    sections.forEach(function (section) {
        if (Number(section.getAttribute("data-admin-section")) === index) {
            next = section;
        }
    });

    if (!next) return;

    sections.forEach(function (section) {
        var active = section === next;
        section.hidden = !active;
        section.classList.toggle("active", active);
    });

    tabs.forEach(function (tab) {
        var tabIndex = Number(tab.getAttribute("data-section-target"));
        tab.classList.toggle("active", tabIndex === index);
    });

    currentSection = next;
    currentPage = 1;

    var addButton = qs("#addButton");
    if (addButton) {
        addButton.textContent = next.getAttribute("data-add-label") || "+ 신규 등록";
        addButton.classList.toggle("is-hidden", next.getAttribute("data-can-add") === "false");
    }

    showPage(next);
}

function currentFields() {
    if (!currentSection) return null;

    var index = currentSection.getAttribute("data-admin-section");
    return qs('.section-form-fields[data-form-section="' + index + '"]');
}

function badgeClass(value) {
    if (/완료|일반|정상|판매중|배송중|공개|사용중|입고완료|발급중|일치|해제/.test(value)) return "green";
    if (/대기|예정|준비|진행|처리중|접수|확인중|출고대기|집화완료|배달출발/.test(value)) return "orange";
    if (/제한|불가|품절|요청|미답변|비공개|만료|종료|반려|상이|재고부족/.test(value)) return "gray";
    return "blue";
}

function setCell(row, index, value) {
    var cell = qs('[data-field-index="' + index + '"]', row);
    if (!cell) return;

    var badge = qs(".badge", cell);

    if (badge) {
        badge.textContent = value;
        badge.className = "badge " + badgeClass(value);
    } else {
        cell.textContent = value;
    }
}

// 등록/수정 모달
function openModal(row) {
    editingRow = row || null;

    qsa(".section-form-fields").forEach(function (fields) {
        fields.hidden = true;
    });

    var fields = currentFields();
    if (!fields) return;

    fields.hidden = false;

    qsa('[data-field-index]', fields).forEach(function (control) {
        var index = Number(control.getAttribute("data-field-index"));
        var defaultValue = control.getAttribute("data-default") || "";
        control.value = row ? cellText(row, index) : defaultValue;
    });

    var title = qs("#modalTitle");
    var guide = qs("#modalGuide");
    var save = qs("#modalSave");
    var addLabel = currentSection.getAttribute("data-add-label") || "+ 신규 등록";

    if (title) title.textContent = row ? "정보 수정" : addLabel.replace(/^\+\s*/, "");
    if (guide) guide.textContent = row ? "현재 표의 값을 수정합니다." : "새 항목의 값을 입력합니다.";
    if (save) save.textContent = row ? "수정" : "저장";

    var modal = qs("#editModal");
    if (!modal) return;

    modal.hidden = false;
    modal.classList.add("show");
    modal.setAttribute("aria-hidden", "false");
    document.body.classList.add("admin-modal-open");
}

function closeModal() {
    var modal = qs("#editModal");
    if (!modal) return;

    modal.hidden = true;
    modal.classList.remove("show");
    modal.setAttribute("aria-hidden", "true");
    document.body.classList.remove("admin-modal-open");
    editingRow = null;
}

// 새 행의 디자인은 JSP template에 있고 JS는 복사만 합니다.
function newRow(section) {
    var template = qs(".admin-row-template", section);
    var body = qs(".data-body", section);
    if (!template || !body) return null;

    var row = template.content.firstElementChild.cloneNode(true);
    body.insertBefore(row, body.firstChild);
    bindRow(row, section);
    return row;
}

function saveModal() {
    var fields = currentFields();
    if (!fields || !currentSection) return;

    var wasEditing = editingRow !== null;
    var row = editingRow || newRow(currentSection);
    if (!row) return;

    qsa('[data-field-index]', fields).forEach(function (control) {
        var index = Number(control.getAttribute("data-field-index"));
        setCell(row, index, String(control.value || "").trim());
    });

    closeModal();
    currentPage = 1;
    showPage(currentSection);
    toast(wasEditing ? "항목을 수정했습니다." : "항목을 등록했습니다.");
}

// 삭제 확인창
function confirmDelete(title, action) {
    confirmAction = action;

    var titleBox = qs("#confirmTitle");
    var textBox = qs("#confirmText");
    var box = qs("#confirmBox");

    if (titleBox) titleBox.textContent = title;
    if (textBox) textBox.textContent = "현재 화면의 예시 데이터에서 삭제됩니다.";
    if (!box) return;

    box.hidden = false;
    box.classList.add("show");
    box.setAttribute("aria-hidden", "false");
    document.body.classList.add("admin-modal-open");
}

function closeConfirm() {
    var box = qs("#confirmBox");
    if (!box) return;

    box.hidden = true;
    box.classList.remove("show");
    box.setAttribute("aria-hidden", "true");
    document.body.classList.remove("admin-modal-open");
    confirmAction = null;
}

function toast(message) {
    var box = qs("#toast");
    if (!box) return;

    box.textContent = message;
    box.classList.add("show");
    window.clearTimeout(toast.timer);

    toast.timer = window.setTimeout(function () {
        box.classList.remove("show");
    }, 1800);
}

// 한 행의 버튼 연결
function bindRow(row, section) {
    var check = qs(".row-check", row);
    var edit = qs(".edit-row", row);
    var del = qs(".delete-row", row);

    if (check) {
        check.addEventListener("change", function () {
            updateChecks(section);
        });
    }

    if (edit) {
        edit.addEventListener("click", function () {
            openModal(row);
        });
    }

    if (del) {
        del.addEventListener("click", function () {
            confirmDelete("선택한 항목을 삭제할까요?", function () {
                row.remove();
                showPage(section);
                toast("항목을 삭제했습니다.");
            });
        });
    }
}

// CSV 저장
function saveCsv(section) {
    var headers = qsa("thead th", section).slice(1, -1).map(function (th) {
        return th.textContent.trim();
    });

    var data = filteredRows(section).map(function (row) {
        return qsa('td[data-field-index]', row).map(function (td) {
            return td.textContent.trim();
        });
    });

    var lines = [headers].concat(data).map(function (line) {
        return line.map(function (value) {
            return '"' + String(value).replace(/"/g, '""') + '"';
        }).join(",");
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
}

// 검색/체크/삭제/페이지 버튼 연결
function bindSection(section) {
    var searchButton = qs(".js-search-button", section);
    var keyword = qs(".js-search-keyword", section);
    var resetButton = qs(".js-reset-button", section);
    var checkAll = qs(".check-all", section);
    var deleteSelected = qs(".delete-selected-button", section);
    var exportButton = qs(".export-button", section);
    var prevButton = qs(".page-prev", section);
    var nextButton = qs(".page-next", section);

    if (searchButton) {
        searchButton.addEventListener("click", function () {
            currentPage = 1;
            showPage(section);
        });
    }

    if (keyword) {
        keyword.addEventListener("keydown", function (event) {
            if (event.key === "Enter" || event.keyCode === 13) {
                event.preventDefault();
                currentPage = 1;
                showPage(section);
            }
        });
    }

    if (resetButton) {
        resetButton.addEventListener("click", function () {
            resetSearch(section);
        });
    }

    qsa(".extra-filter, .filter-from, .filter-to", section).forEach(function (control) {
        control.addEventListener("change", function () {
            currentPage = 1;
            showPage(section);
        });
    });

    if (checkAll) {
        checkAll.addEventListener("change", function () {
            rows(section).filter(function (row) {
                return !row.hidden;
            }).forEach(function (row) {
                var box = qs(".row-check", row);
                if (box) box.checked = checkAll.checked;
            });

            updateChecks(section);
        });
    }

    rows(section).forEach(function (row) {
        bindRow(row, section);
    });

    if (deleteSelected) {
        deleteSelected.addEventListener("click", function () {
            var selectedRows = qsa(".row-check:checked", section).map(function (box) {
                return box.closest("tr");
            });

            if (!selectedRows.length) {
                toast("먼저 삭제할 항목을 체크해 주세요.");
                return;
            }

            confirmDelete("선택한 " + selectedRows.length + "개 항목을 삭제할까요?", function () {
                selectedRows.forEach(function (row) {
                    row.remove();
                });

                showPage(section);
                toast(selectedRows.length + "개 항목을 삭제했습니다.");
            });
        });
    }

    if (exportButton) {
        exportButton.addEventListener("click", function () {
            saveCsv(section);
        });
    }

    if (prevButton) {
        prevButton.addEventListener("click", function () {
            if (currentPage > 1) {
                currentPage--;
                showPage(section);
            }
        });
    }

    if (nextButton) {
        nextButton.addEventListener("click", function () {
            var totalPages = Math.max(1, Math.ceil(filteredRows(section).length / PAGE_SIZE));

            if (currentPage < totalPages) {
                currentPage++;
                showPage(section);
            }
        });
    }
}

function init() {
    if (!root) return;

    sections.forEach(function (section) {
        bindSection(section);
    });

    tabs.forEach(function (tab) {
        tab.addEventListener("click", function () {
            openSection(Number(tab.getAttribute("data-section-target")));
        });
    });

    var addButton = qs("#addButton");
    var modalClose = qs("#modalClose");
    var modalCancel = qs("#modalCancel");
    var modalSave = qs("#modalSave");
    var confirmCancel = qs("#confirmCancel");
    var confirmOk = qs("#confirmOk");
    var editModal = qs("#editModal");

    if (addButton) addButton.addEventListener("click", function () { openModal(null); });
    if (modalClose) modalClose.addEventListener("click", closeModal);
    if (modalCancel) modalCancel.addEventListener("click", closeModal);
    if (modalSave) modalSave.addEventListener("click", saveModal);
    if (confirmCancel) confirmCancel.addEventListener("click", closeConfirm);

    if (confirmOk) {
        confirmOk.addEventListener("click", function () {
            var action = confirmAction;
            closeConfirm();
            if (action) action();
        });
    }

    if (editModal) {
        editModal.addEventListener("click", function (event) {
            if (event.target === event.currentTarget) closeModal();
        });
    }

    document.addEventListener("keydown", function (event) {
        if (event.key === "Escape" || event.keyCode === 27) {
            closeModal();
            closeConfirm();
        }
    });

    openSection(0);
}

if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
} else {
    init();
}
