<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="adminPage" value="product" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>상품관리 | Yongsinsa 관리자</title>
  <script>
    document.documentElement.classList.add("ys-page-loading");
    window.__ysPageLoaderStart = Date.now();
  </script>
  <script type="text/javascript"
    src="${pageContext.request.contextPath}/dist/jquery/js/jquery.min.js">
	</script>
  <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/list.css?v=20260813">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/modal.css?v=20260813">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/static-list.css?v=20260813">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/paginate.css" type="text/css">
</head>
<body data-context-path="${pageContext.request.contextPath}">
  <jsp:include page="/WEB-INF/views/common/page-loader.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/product/stockModal.jsp" />

  <main class="admin-main">
    <section class="page active admin-static-page" data-page-key="product">
      <div class="page-heading">
        <div>
          <p>관리자 페이지 / 상품관리</p>
          <h1>상품관리</h1>
          <span>상품 등록·조회·재고관리를 합니다.</span>
        </div>
        <button type="button" class="primary-btn" id="addButton">+ 상품 등록</button>
      </div>

      <nav class="sub-tabs" aria-label="상품관리 탭">
        <button type="button" class="active" disabled>등록 상품 조회</button>
      </nav>

      <!-- 검색 영역 : 화면 구조는 JSP에 두고 JS는 입력값을 읽어서 행을 보여주거나 숨기기만 합니다. -->
      <article class="panel search-panel">
        <div class="search-row">
          <select id="schType" aria-label="검색 항목">
            <option value="all">전체</option>
            <option value="prodName">상품명</option>
            <option value="brand">브랜드</option>
            <option value="ctgName">카테고리</option>
            <option value="inboundPrice">입고가</option>
            <option value="price">판매가</option>
            <option value="heelHeight">힐높이</option>
          </select>
          <input type="search" id="kwd" placeholder="검색어를 입력하세요">
          <button type="button" class="dark-btn" id="searchButton">검색</button>
          <button type="button" class="light-btn" id="resetButton">초기화</button>
        </div>

        <div class="filter-row" aria-label="추가 검색 조건">
          <div class="filter-control range-control">
            <label>등록기간</label>
            <div class="filter-date-range">
              <input type="date" id="dateFrom" aria-label="등록기간 시작일">
              <span>~</span>
              <input type="date" id="dateTo" aria-label="등록기간 종료일">
            </div>
          </div>

          <div class="filter-control">
            <label for="minGradeFilter">상품 노출등급</label>
            <select id="minGradeFilter">
              <option value="">전체</option>
              <option value="2">실버이상</option>
              <option value="3">골드이상</option>
              <option value="4">VIP</option>
            </select>
          </div>

          <div class="filter-control">
            <label for="statusFilter">상품상태</label>
            <select id="statusFilter">
              <option value="">전체</option>
              <option value="ready">판매대기</option>
              <option value="onSale">판매중</option>
              <option value="soldOut">품절</option>
            </select>
          </div>
        </div>
      </article>

      <!-- 상품 목록 : Controller에서 받은 list를 JSP가 직접 출력합니다. -->
      <article class="panel">
        <div class="panel-title">
          <div>
            <h2>등록 상품 목록</h2>
            <p>검색 결과 <b id="resultCount">${totalCount}</b>건 · 선택 <b id="selectedCount">0</b>건</p>
          </div>
          <div>
            <button type="button" class="light-btn danger-btn" id="deleteSelectedButton">선택 삭제</button>
            <button type="button" class="light-btn" id="resetListButton">전체 초기화</button>
          </div>
        </div>

        <div class="table-wrap">
          <table id="productTable">
            <thead>
              <tr>
                <th><input type="checkbox" id="checkAll" aria-label="현재 페이지 전체 선택"></th>
                <th>썸네일</th>
                <th>상품번호</th>
                <th>상품명</th>
                <th>브랜드</th>
                <th>카테고리</th>
                <th>입고가</th>
                <th>판매가</th>
                <th>힐높이</th>
                <th>노출등급</th>
                <th>등록일</th>
                <th>상태</th>
                <th>관리</th>
              </tr>
            </thead>
            <tbody id="productTableBody">
              <c:forEach var="dto" items="${list}">
                <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="상품 선택"></td>
                  <td class="thumbnail-cell">
                  	<img src="${pageContext.request.contextPath}/uploads/product/${dto.thumbnail}" class="product-thumbnail">
                  </td>
                  <td class="product-id-cell" data-field="productId"><c:out value="${dto.productId}"/></td>
                  <td data-field="prodName"><c:out value="${dto.prodName}"/></td>
                  <td data-field="brand"><c:out value="${dto.brand}"/></td>
                  <td data-field="categoryId"><c:out value="${dto.ctgName}"/></td>
                  <td data-field="inboundPrice" data-value="${dto.inboundPrice}">
                    <fmt:formatNumber value="${dto.inboundPrice}" pattern="#,##0"/>원
                  </td>
                  <td data-field="price" data-value="${dto.price}">
                    <fmt:formatNumber value="${dto.price}" pattern="#,##0"/>원
                  </td>
                  <td data-field="heelHeight"><c:out value="${dto.heelHeight}"/></td>
                  <td data-field="minGrade" data-value="${dto.minGrade}">
                    <c:choose>
                      <c:when test="${dto.minGrade == 1}">전체회원</c:when>
                      <c:when test="${dto.minGrade == 2}">실버이상</c:when>
                      <c:when test="${dto.minGrade == 3}">골드이상</c:when>
                      <c:when test="${dto.minGrade == 4}">VIP</c:when>
                      <c:otherwise><c:out value="${dto.minGrade}"/></c:otherwise>
                    </c:choose>
                  </td>
                  <td data-field="regDate" data-value="${dto.regDate}"><c:out value="${dto.regDate}"/></td>
                  <td data-field="status" data-value="${dto.status}">
                    <c:choose>
                      <c:when test="${dto.status == 'ready'}">
                        <span class="badge blue">판매대기</span>
                      </c:when>
                      <c:when test="${dto.status == 'onSale'}">
                        <span class="badge green">판매중</span>
                      </c:when>
                      <c:when test="${dto.status == 'soldOut'}">
                        <span class="badge gray">품절</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge">알 수 없음</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="action-cell">
                    <button type="button" class="light-btn stock-row" data-product-id="${dto.productId}">재고</button>
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <div class="empty-state" id="emptyState">검색 결과가 없습니다.</div>
	    <div class="page-navigation">
			${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
		</div>
      </article>

      <!-- CSV 다운로드에 사용하는 숨은 링크. 모양이 필요한 요소이므로 JSP에 미리 둡니다. -->
      <a id="adminCsvDownloadLink" hidden aria-hidden="true"></a>
    </section>
  </main>

  <!-- 상품 등록/수정 모달 : 입력 항목을 JS template으로 만들지 않고 JSP에 직접 작성합니다. -->
  <div class="modal-backdrop" id="productModal" aria-hidden="true" hidden>
    <section class="admin-modal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
      <div class="modal-head">
        <div>
          <p id="modalGuide">상품 정보를 입력합니다.</p>
          <h2 id="modalTitle">상품 등록</h2>
        </div>
        <button type="button" class="modal-close" id="modalClose" aria-label="닫기">×</button>
      </div>

      <form name="productForm" id="productForm" method="post" enctype="multipart/form-data"
            action="${pageContext.request.contextPath}/admin/product/write">
        <input type="hidden" name="productId" id="productId">
        <!-- 현재 Controller가 요구하는 값이라 숨은 입력으로 둡니다. -->
        <input type="hidden" name="imageId" value="0">
        <input type="hidden" name="sortOrder" value="1">

        <div class="form-grid">
          <div class="form-field">
            <label for="prodName">상품명</label>
            <input type="text" id="prodName" name="prodName" data-form-field="prodName"
                   placeholder="상품명 입력" required>
          </div>

          <div class="form-field">
            <label for="brand">브랜드</label>
            <input type="text" id="brand" name="brand" data-form-field="brand"
                   placeholder="브랜드 입력" required>
          </div>

			<div class="form-group category-group">
			    <label>카테고리</label>
			    <div class="category-select-wrap">
			        <select id="parentCategory">
			            <option value="">대분류 선택</option>
			             	<c:forEach var="ctg" items="${PCList}">
                				<option value="${ctg.categoryId}">
                   			 		${ctg.ctgName}
               				 	</option>
            			 	</c:forEach>
			        </select>
			        <select id="childCategory" name="categoryId" disabled>
			            <option value="">소분류 선택</option>
			            	<c:forEach var="ctg" items="${CCList}">
                				<option value="${ctg.categoryId}" 
                					data-parent-id="${ctg.parentId}">
                   			 		${ctg.ctgName}
               				 	</option>
            			 	</c:forEach>
			        </select>
			    </div>
			</div>
			
          <div class="form-field">
            <label for="inboundPrice">입고가</label>
            <input type="number" id="inboundPrice" name="inboundPrice" data-form-field="inboundPrice"
                   min="0" placeholder="입고가 입력" required>
          </div>

          <div class="form-field">
            <label for="price">판매가</label>
            <input type="number" id="price" name="price" data-form-field="price"
                   min="0" placeholder="판매가 입력" required>
          </div>

          <div class="form-field">
            <label for="heelHeight">힐높이</label>
            <input type="number" id="heelHeight" name="heelHeight" data-form-field="heelHeight"
                   min="0" value="0" placeholder="힐높이 입력">
          </div>

          <div class="form-field">
            <label for="discRate">할인율</label>
            <input type="number" id="discRate" name="discRate" min="0" max="100" value="0"
                   placeholder="할인율 입력">
          </div>

          <div class="form-field">
            <label for="minGrade">상품 노출등급</label>
            <select id="minGrade" name="minGrade" data-form-field="minGrade">
              <option value="1">전체회원</option>
              <option value="2">실버이상</option>
              <option value="3">골드이상</option>
              <option value="4">VIP</option>
            </select>
          </div>

          <div class="form-field">
            <label for="status">상태</label>
            <select id="status" name="status" data-form-field="status">
              <option value="ready">판매대기</option>
              <option value="onSale">판매중</option>
              <option value="soldOut">품절</option>
            </select>
          </div>

          <!-- 상품 이미지 영역도 JSP에서 직접 확인할 수 있도록 그대로 작성합니다. -->
          <div class="product-image-section">
            <div class="product-image-title">상품 이미지</div>
            <div class="image-container">
              <div class="main-image-area">
                <label class="image-label" for="thumbnail">
                  대표 이미지 <span>(필수)</span>
                </label>

                <div id="mainDropZone" class="main-drop-zone">
                  <div id="mainGuide" class="main-upload-guide">
                    <div class="upload-icon">📷</div>
                    <div class="upload-text">대표 이미지를 여기에 끌어다 놓으세요</div>
                    <div class="upload-or">또는</div>
                    <label for="thumbnail" class="upload-button">이미지 선택</label>
                    <div class="upload-info">JPG, PNG, WEBP / 최대 10MB</div>
                  </div>

                  <div id="mainPreviewArea" class="main-preview-area" hidden>
                    <img id="mainPreview" src="" alt="대표 이미지 미리보기">
                    <label for="thumbnail" class="change-image-button">이미지 변경</label>
                  </div>

                  <input type="file" id="thumbnail" name="thumbnail" hidden
                         accept="image/jpeg,image/png,image/webp">
                </div>
              </div>

              <div class="additional-image-area">
                <label class="image-label" for="files">
                  추가 이미지 <span>(선택)</span>
                </label>

                <div id="subImageList" class="sub-image-list">
                  <label for="files" class="sub-image-add">
                    <span class="plus">+</span>
                    <span>이미지 추가</span>
                  </label>
                </div>

                <div class="additional-info">
                  최대 10장까지 선택 가능합니다. <span id="subImageCount">선택 0장</span>
                </div>
                <input type="file" id="files" name="files" hidden multiple
                       accept="image/jpeg,image/png,image/webp">
              </div>
            </div>
          </div>
        </div>

        <div class="modal-actions">
          <button type="button" class="light-btn" id="modalCancel">취소</button>
          <button type="button" class="primary-btn" id="modalSave" onclick="sendOk()">저장</button>
        </div>
      </form>
    </section>
  </div>

  <div class="toast" id="toast">처리되었습니다.</div>
  
  <script type="text/javascript">
	$(function () {
		
		$('button.stock-row').on('click', function() {
			
		
		var productId = $(this).data("product-id");
		
		
		$.ajax({
			
			url : '${pageContext.request.contextPath}/admin/product/stock',
			type : 'GET',
			data : {productId},
			dataType : 'json',
			success : function(data) {
				
				$('#stockProductId').text(data.productId);
				$('#stockProdName').text(data.prodName);
				$('#stockPrice').text(data.price);
				$('#stockThumbnail').attr('src', 
						'${pageContext.request.contextPath}/uploads/product/' + data.thumbnail);
				
				$('#stockModal')
					.prop('hidden' , false)
					.attr('aria-hidden', 'false')
			}

		});
	});

		function closeStockModal() {
		    $('#stockModal')
		        .prop('hidden', true)
		        .attr('aria-hidden', 'true');
		}
		
		$('#stockModalClose').on('click', closeStockModal);
		$('#stockModalCancel').on('click', closeStockModal);

	});
	
	
	
  </script>
  

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
	<script>
	    var contextPath = "${pageContext.request.contextPath}";
	    var openWriteModal = ${openWriteModal ? 'true' : 'false'};
	</script>
  <script src="${pageContext.request.contextPath}/dist/js/admin/product.js?v=20260818"></script>
</body>
</html>
