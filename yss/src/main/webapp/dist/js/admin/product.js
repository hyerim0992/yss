"use strict";

// 상품관리 전용 JS
// HTML 구조와 디자인은 main.jsp / CSS에 두고,
// 이 파일에는 검색, 선택, 모달, 이미지 미리보기 같은 동작만 둡니다.
// Eclipse에서도 읽기 쉽도록 var / function / if 중심으로 작성했습니다.


var editingRow = null;
var previewUrl = "";

var schType = document.querySelector("#schType");
var kwd = document.querySelector("#kwd");
var dateFrom = document.querySelector("#dateFrom");
var dateTo = document.querySelector("#dateTo");
var gradeFilter = document.querySelector("#gradeFilter");
var statusFilter = document.querySelector("#statusFilter");
var checkAll = document.querySelector("#checkAll");
var productModal = document.querySelector("#productModal");
var productForm = document.querySelector("#productForm");

function toArray(list) {
    return Array.prototype.slice.call(list);
}

function rows() {
    return toArray(document.querySelectorAll("#productTableBody .data-row"));
}

function cellValue(row, name) {
    var cell = row.querySelector('[data-field="' + name + '"]');

    if (!cell) {
        return "";
    }

    if (cell.getAttribute("data-value") !== null) {
        return cell.getAttribute("data-value");
    }

    return cell.textContent.trim();
}

// 검색 조건에 맞는 상품 행만 모으기
function filteredRows() {
    var keyword = schType.value.trim().toLowerCase();
    var allRows = rows();
    var result = [];

    for (var i = 0; i < allRows.length; i++) {
        var row = allRows[i];
        var target = "";

        if (schType.value === "all") {
            target = row.textContent;
        } else {
            target = cellValue(row, schType.value);
        }

        var regDate = cellValue(row, "regDate").slice(0, 10);
        var keywordOk = keyword === "" || target.toLowerCase().indexOf(keyword) !== -1;
        var dateFromOk = dateFrom.value === "" || regDate >= dateFrom.value;
        var dateToOk = dateTo.value === "" || regDate <= dateTo.value;
        var gradeOk = gradeFilter.value === "" || cellValue(row, "minGrade") === gradeFilter.value;
        var statusOk = statusFilter.value === "" || cellValue(row, "status") === statusFilter.value;

        if (keywordOk && dateFromOk && dateToOk && gradeOk && statusOk) {
            result.push(row);
        }
    }

    return result;
}

// 한 페이지에 10개씩 표시
function renderList() {
    var matched = filteredRows();


    var allRows = rows();
    var i;

    for (i = 0; i < allRows.length; i++) {
        allRows[i].hidden = true;
    }


    checkAll.checked = false;
    checkAll.indeterminate = false;

    for (i = 0; i < allRows.length; i++) {
        var rowCheck = allRows[i].querySelector(".row-check");
        if (rowCheck) {
            rowCheck.checked = false;
        }
    }

    updateSelectedCount();
}

function updateSelectedCount() {
    var selected = document.querySelectorAll(".row-check:checked").length;
    document.querySelector("#selectedCount").textContent = selected;

    var visible = toArray(document.querySelectorAll(".data-row:not([hidden]) .row-check"));
    var visibleChecked = 0;

    for (var i = 0; i < visible.length; i++) {
        if (visible[i].checked) {
            visibleChecked++;
        }
    }

    checkAll.checked = visible.length > 0 && visibleChecked === visible.length;
    checkAll.indeterminate = visibleChecked > 0 && visibleChecked < visible.length;
}

function showToast(message) {
    var toast = document.querySelector("#toast");
    if (!toast) {
        return;
    }

    toast.textContent = message;
    toast.classList.add("show");

    window.clearTimeout(showToast.timer);
    showToast.timer = window.setTimeout(function () {
        toast.classList.remove("show");
    }, 1800);
}

function resetSearch() {
    schType.value = "all";
    kwd.value = "";
    dateFrom.value = "";
    dateTo.value = "";
    gradeFilter.value = "";
    statusFilter.value = "";
    renderList();
}

// 상품 등록/수정 모달 열기
function openModal(row) {
    editingRow = row || null;
    productForm.reset();
    resetPreview();

    document.querySelector("#modalTitle").textContent = row ? "상품 정보 수정" : "상품 등록";
    document.querySelector("#modalGuide").textContent = row ? "현재 화면의 상품 정보를 수정합니다." : "새 상품 정보를 입력합니다.";
    document.querySelector("#modalSave").textContent = row ? "수정" : "저장";

    if (row) {
        document.querySelector("#productId").value = cellValue(row, "productId");

        var inputs = toArray(productForm.querySelectorAll("[data-form-field]"));
        for (var i = 0; i < inputs.length; i++) {
            inputs[i].value = cellValue(row, inputs[i].getAttribute("data-form-field"));
        }
    } else {
        document.querySelector("#heelHeight").value = "0";
        document.querySelector("#discRate").value = "0";
        document.querySelector("#minGrade").value = "1";
        document.querySelector("#status").value = "ready";
    }

    productModal.hidden = false;
    productModal.classList.add("show");
    productModal.setAttribute("aria-hidden", "false");
    document.body.classList.add("admin-modal-open");
}

function closeModal() {
    productModal.classList.remove("show");
    productModal.hidden = true;
    productModal.setAttribute("aria-hidden", "true");
    document.body.classList.remove("admin-modal-open");
    editingRow = null;
    resetPreview();
}

// 수정은 현재 화면의 행 값을 바꿈
function saveEditOnScreen() {
    var inputs = toArray(productForm.querySelectorAll("[data-form-field]"));

    for (var i = 0; i < inputs.length; i++) {
        var input = inputs[i];
        var fieldName = input.getAttribute("data-form-field");
        var cell = editingRow.querySelector('[data-field="' + fieldName + '"]');

        if (!cell) {
            continue;
        }

        cell.setAttribute("data-value", input.value);

        if (fieldName === "status") {
            var badge = cell.querySelector(".badge");
            var names = { ready: "판매대기", onSale: "판매중", soldOut: "품절" };
            var classes = { ready: "blue", onSale: "green", soldOut: "gray" };

            badge.textContent = names[input.value];
            badge.className = "badge " + classes[input.value];
        } else if (input.tagName === "SELECT") {
            cell.textContent = input.options[input.selectedIndex].text;
        } else if (fieldName === "price" || fieldName === "inboundPrice") {
            cell.textContent = Number(input.value || 0).toLocaleString("ko-KR") + "원";
        } else {
            cell.textContent = input.value;
        }
    }

    closeModal();
    renderList();
    showToast("화면의 상품 정보를 수정했습니다.");
}

// 대표 이미지 미리보기
function showPreview(file) {
    if (!file) {
        return;
    }

    if (previewUrl) {
        URL.revokeObjectURL(previewUrl);
    }

    previewUrl = URL.createObjectURL(file);
    document.querySelector("#mainPreview").src = previewUrl;
    document.querySelector("#mainGuide").hidden = true;
    document.querySelector("#mainPreviewArea").hidden = false;
}

function resetPreview() {
    if (previewUrl) {
        URL.revokeObjectURL(previewUrl);
    }

    previewUrl = "";
    document.querySelector("#mainPreview").removeAttribute("src");
    document.querySelector("#mainGuide").hidden = false;
    document.querySelector("#mainPreviewArea").hidden = true;
    document.querySelector("#subImageCount").textContent = "선택 0장";
}

// CSV 저장
function exportCsv() {
    var headerCells = toArray(document.querySelectorAll("#productTable thead th"));
    var headers = [];
    var data = [];
    var matched = filteredRows();
    var i;
    var j;

    for (i = 1; i < headerCells.length - 1; i++) {
        headers.push(headerCells[i].textContent.trim());
    }

    for (i = 0; i < matched.length; i++) {
        var cells = toArray(matched[i].querySelectorAll("td"));
        var line = [];

        for (j = 1; j < cells.length - 1; j++) {
            line.push(cells[j].textContent.trim());
        }

        data.push(line);
    }

    var lines = [headers].concat(data);
    var csvLines = [];

    for (i = 0; i < lines.length; i++) {
        var values = [];

        for (j = 0; j < lines[i].length; j++) {
            var value = String(lines[i][j]).replace(/"/g, '""');
            values.push('"' + value + '"');
        }

        csvLines.push(values.join(","));
    }

    var csv = csvLines.join("\n");
    var blob = new Blob(["\ufeff" + csv], { type: "text/csv;charset=utf-8" });
    var url = URL.createObjectURL(blob);
    var link = document.querySelector("#adminCsvDownloadLink");

    link.href = url;
    link.download = "product-list.csv";
    link.click();
    URL.revokeObjectURL(url);
}

// 기존 상품 한 행의 이벤트 연결
function bindProductRow(row) {
    var rowCheck = row.querySelector(".row-check");
    var editButton = row.querySelector(".edit-row");
    var deleteButton = row.querySelector(".delete-row");

    if (rowCheck) {
        rowCheck.addEventListener("change", updateSelectedCount);
    }

    if (editButton) {
        editButton.addEventListener("click", function () {
            openModal(row);
        });
    }

    if (deleteButton) {
        deleteButton.addEventListener("click", function () {
            if (window.confirm("선택한 상품을 화면에서 삭제할까요?")) {
                row.remove();
                renderList();
            }
        });
    }
}

function initProduct() {
    var allRows = rows();
    var i;

    for (i = 0; i < allRows.length; i++) {
        bindProductRow(allRows[i]);
    }

    document.querySelector("#searchButton").addEventListener("click", function () {
    });

    schType.addEventListener("keydown", function (event) {
        if (event.key === "Enter" || event.keyCode === 13) {
            event.preventDefault();
        }
    });

    document.querySelector("#resetButton").addEventListener("click", resetSearch);

    var filters = [dateFrom, dateTo, gradeFilter, statusFilter];
    for (i = 0; i < filters.length; i++) {
        filters[i].addEventListener("change", function () {
        });
    }



    checkAll.addEventListener("change", function () {
        var visibleChecks = toArray(document.querySelectorAll(".data-row:not([hidden]) .row-check"));

        for (var i = 0; i < visibleChecks.length; i++) {
            visibleChecks[i].checked = checkAll.checked;
        }

        updateSelectedCount();
    });

    document.querySelector("#deleteSelectedButton").addEventListener("click", function () {
        var selected = toArray(document.querySelectorAll(".row-check:checked"));

        if (selected.length === 0) {
            showToast("먼저 삭제할 상품을 선택해 주세요.");
            return;
        }

        if (window.confirm("선택한 " + selected.length + "개 상품을 화면에서 삭제할까요?")) {
            for (var i = 0; i < selected.length; i++) {
                var row = selected[i].closest("tr");
                if (row) {
                    row.remove();
                }
            }
            renderList();
        }
    });

    document.querySelector("#exportButton").addEventListener("click", exportCsv);

    document.querySelector("#addButton").addEventListener("click", function () {
        openModal(null);
    });

    document.querySelector("#modalClose").addEventListener("click", closeModal);
    document.querySelector("#modalCancel").addEventListener("click", closeModal);

    productModal.addEventListener("click", function (event) {
        if (event.target === productModal) {
            closeModal();
        }
    });

    productForm.addEventListener("submit", function (event) {
        // ProductManageController에는 아직 update가 없어서 수정은 화면 값만 변경합니다.
        if (editingRow) {
            event.preventDefault();
            saveEditOnScreen();
        }
    });

    document.querySelector("#thumbnail").addEventListener("change", function () {
        showPreview(this.files[0]);
    });

    document.querySelector("#files").addEventListener("change", function () {
        if (this.files.length > 10) {
            this.value = "";
            showToast("추가 이미지는 최대 10장까지 선택할 수 있습니다.");
        }
        document.querySelector("#subImageCount").textContent = "선택 " + this.files.length + "장";
    });

    var dropZone = document.querySelector("#mainDropZone");

    dropZone.addEventListener("dragover", function (event) {
        event.preventDefault();
        dropZone.classList.add("dragover");
    });

    dropZone.addEventListener("dragleave", function () {
        dropZone.classList.remove("dragover");
    });

    dropZone.addEventListener("drop", function (event) {
        event.preventDefault();
        dropZone.classList.remove("dragover");

        var file = event.dataTransfer.files[0];
        if (!file || file.type.indexOf("image/") !== 0) {
            return;
        }

        // 브라우저가 DataTransfer를 지원하는 경우 파일 input에도 넣습니다.
        if (typeof DataTransfer !== "undefined") {
            var transfer = new DataTransfer();
            transfer.items.add(file);
            document.querySelector("#thumbnail").files = transfer.files;
        }

        showPreview(file);
    });

    document.addEventListener("keydown", function (event) {
        if ((event.key === "Escape" || event.keyCode === 27) && !productModal.hidden) {
            closeModal();
        }
    });

    renderList();
}

if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initProduct);
} else {
    initProduct();
}
