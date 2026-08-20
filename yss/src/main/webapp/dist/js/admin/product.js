
"use strict";

// 상품관리 전용 JS
// HTML 구조와 디자인은 main.jsp / CSS에 두고,
// 이 파일에는 검색, 선택, 모달, 이미지 미리보기 같은 동작만 둡니다.
// Eclipse에서도 읽기 쉽도록 var / function / if 중심으로 작성했습니다.

var editingRow = null;
var previewUrl = "";

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


function updateSelectedCount() {
    var selected = document.querySelectorAll(".row-check:checked").length;
    document.querySelector("#selectedCount").textContent = selected;

    var visible = toArray(document.querySelectorAll(".data-row .row-check"));
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
	
	history.pushState(
	    {},
	    "",
	    contextPath + "/admin/product/write"
	);
}

function closeModal() {
    productModal.classList.remove("show");
    productModal.hidden = true;
    productModal.setAttribute("aria-hidden", "true");
    document.body.classList.remove("admin-modal-open");
    editingRow = null;
    resetPreview();
	
	history.pushState(
	    {},
	    "",
	    contextPath + "/admin/product"
	);
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

document.querySelector("#thumbnail").addEventListener("change" , () =>{
	showPreview(this.files[0]);
});

function showFilesPreview(files){
	
	var list = document.querySelector("#subImageList");
	var addButton = list.querySelector(".sub-image-add");
	
	var previews = list.querySelectorAll(".sub-image-preview");

	    for (var i = 0; i < previews.length; i++) {
	        previews[i].remove();
	    }

	    // 최대 10장
	    var count = Math.min(files.length, 10);

	    for (var i = 0; i < count; i++) {

	        var file = files[i];

	        if (file.type.indexOf("image/") !== 0) {
	            continue;
	        }

	        var url = URL.createObjectURL(file);

	        var wrapper = document.createElement("div");
	        wrapper.className = "sub-image-preview";

	        var img = document.createElement("img");
	        img.src = url;
	        img.alt = "추가 이미지 " + (i + 1);

	        wrapper.appendChild(img);

	        list.insertBefore(wrapper, addButton);
	    }

	    document.querySelector("#subImageCount").textContent =
	        "선택 " + count + "장";
}

document.querySelector("#files").addEventListener("change", function () {

    if (this.files.length > 10) {

        this.value = "";

        showToast("추가 이미지는 최대 10장까지 선택할 수 있습니다.");

        return;
    }
	
	showFilesPreview(this.files);
});


	


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


    checkAll.addEventListener("change", function () {
        var visibleChecks = toArray(document.querySelectorAll(".data-row .row-check"));

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
                }
            }
        }
    });


    document.querySelector("#addButton").addEventListener("click", function () {
        openModal(null);
    });

    document.querySelector("#modalClose").addEventListener("click", closeModal);
    document.querySelector("#modalCancel").addEventListener("click", closeModal);


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
        if (event.target === productModal) {
            closeModal();
        }
    });
	
	if (openWriteModal) {
	    openModal(null);
	}

}

if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initProduct);
} else {
    initProduct();
}






















function sendOk(){
	const f = document.productForm
	f.submit();
}
  	
  
  document.addEventListener("DOMContentLoaded", () => {
	const schType = document.querySelector("#schType");
 	const kwd = document.querySelector("#kwd");
	const dateFrom = document.querySelector("#dateFrom");
	const dateTo = document.querySelector("#dateTo");
	const minGradeFilter = document.querySelector("#minGradeFilter");
	const statusFilter = document.querySelector("#statusFilter");
	
	  
  	const searchEl = document.querySelector("#searchButton");
  	const resetEl = document.querySelector("#resetButton");
  	const resetListEl = document.querySelector("#resetListButton");
  	
  	const parentCategoryEl = document.querySelector("#parentCategory")
  	const childCategoryEl = document.querySelector("#childCategory")
  	
  	searchEl.addEventListener('click', searchList);
  	resetEl.addEventListener("click", resetSearch);
  	
  	schType.addEventListener("keydown", function (e) {
  	    if (e.key === "Enter" || e.keyCode === 13) {
  	        e.preventDefault();
  			searchList();
  	    }
  	});
  	
  	resetListEl.addEventListener('click', () => {
  		resetSearch();
  		location.href = contextPath +"/admin/product"
  	});
  	
	parentCategoryEl.addEventListener("change", function () {

	    const parentId = this.value;

	    childCategoryEl.value = "";

	    if (!parentId) {
	        childCategoryEl.disabled = true;
	        return;
	    }

	    childCategoryEl.disabled = false;

	    const options = childCategoryEl.querySelectorAll("option");

	    for (let i = 0; i < options.length; i++) {

	        const option = options[i];

	        // "소분류 선택"은 항상 표시
	        if (!option.value) {
	            option.hidden = false;
	            continue;
	        }

	        const optionParentId = option.getAttribute("data-parent-id");

	        // 선택한 대분류의 소분류만 표시
	        if (optionParentId === parentId) {
	            option.hidden = false;
	        } else {
	            option.hidden = true;
	        }
	    }

	});
  	

    function searchList(){
      	let params = new URLSearchParams;
      	params.set("schType", schType.value);
      	params.set("kwd", kwd.value.trim());
      	params.set("dateFrom", dateFrom.value);
      	params.set("dateTo", dateTo.value);
      	params.set("minGrade", minGradeFilter.value);
      	params.set("status", statusFilter.value);

      	location.href = contextPath + "/admin/product?" + params.toString();
      }
    
    function resetSearch() {
        schType.value = "all";
        kwd.value = "";
        dateFrom.value = "";
        dateTo.value = "";
        minGradeFilter.value = "";
        statusFilter.value = "";
    }
    
  });


  
  

