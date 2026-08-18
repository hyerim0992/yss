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
  <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/list.css?v=20260813">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/modal.css?v=20260813">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/static-list.css?v=20260813">
</head>
<body data-context-path="${pageContext.request.contextPath}">
  <jsp:include page="/WEB-INF/views/common/page-loader.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

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
        <button type="button" data-section-target="0" class="active" disabled>등록 상품 조회</button>
      </nav>

      <section class="admin-section-panel active" data-admin-section="0" data-section-name="등록 상품 조회" data-table-title="등록 상품 목록" data-add-label="+ 상품 등록" data-can-add="true">
        <article class="panel search-panel">
          <div class="search-row">
            <select class="js-search-type" aria-label="검색 항목">
              <option value="all">전체</option>
              <option value="0">상품번호</option>
              <option value="1">상품명</option>
              <option value="2">브랜드</option>
              <option value="3">카테고리</option>
              <option value="4">입고가</option>
              <option value="5">판매가</option>
              <option value="6">힐높이</option>
            </select>
            <input type="search" class="js-search-keyword" placeholder="검색어를 입력하세요">
            <button type="button" class="dark-btn js-search-button">검색</button>
            <button type="button" class="light-btn js-reset-button">초기화</button>
          </div>
          <div class="filter-row" aria-label="추가 검색 조건">
          <div class="filter-control range-control" data-filter-type="dateRange" data-filter-column="7">
            <label>등록기간</label>
            <div class="filter-date-range">
              <input type="date" class="filter-from" aria-label="등록기간 시작일">
              <span>~</span>
              <input type="date" class="filter-to" aria-label="등록기간 종료일">
            </div>
          </div>
          <div class="filter-control" data-filter-type="select" data-filter-column="6">
            <label>상품 노출등급</label>
            <select class="extra-filter" id="filter-sellerLevel">
              <option value="">전체</option>
              <option value="실버회원">실버회원</option>
              <option value="골드회원">골드회원</option>
              <option value="VIP">VIP</option>
            </select>
          </div>
          <div class="filter-control" data-filter-type="select" data-filter-column="8">
            <label>상품상태</label>
            <select class="extra-filter" id="filter-productStatus">
              <option value="ready">판매대기</option>
              <option value="onSale">판매중</option>
              <option value="soldOut">품절</option>
            </select>
          </div>
          </div>
        </article>

        <article class="panel">
          <div class="panel-title">
            <div>
              <h2>등록 상품 목록</h2>
              <p>검색 결과 <b class="result-count">4</b>건 · 선택 <b class="selected-count">0</b>건</p>
            </div>
            <div>
              <button type="button" class="light-btn danger-btn delete-selected-button">선택 삭제</button>
              <button type="button" class="light-btn export-button">CSV 저장</button>
            </div>
          </div>

          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th><input type="checkbox" class="check-all" aria-label="현재 페이지 전체 선택"></th>
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
              <tbody class="data-body">
				<c:forEach var="dto" items="${list}">
	              <tr class="data-row">
	                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
	                  <td>${dto.thumbnail}</td>
	                  <td>${dto.productId}</td>
	                  <td>${dto.prodName}</td>
	                  <td>${dto.brand}</td>
	                  <td>${dto.categoryId}</td>
	                  <td>${dto.inboundPrice}</td>
	                  <td>${dto.price}</td>
	                  <td>${dto.heelHeight}</td>
	                  <td>${dto.minGrade}</td>
	                  <td>${dto.regDate}</td>
	                  <td>
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
	                    <button type="button" class="light-btn stock-row">재고</button>
	                    <button type="button" class="light-btn edit-row">수정</button>
	                    <button type="button" class="light-btn delete-row">삭제</button>
	                  </td>
	              </tr>
				</c:forEach>
              </tbody>
            </table>
          </div>

          <div class="empty-state">검색 결과가 없습니다.</div>
          <div class="pagination" aria-label="목록 페이지 이동">
            <!-- 페이지 버튼의 모양은 JSP에 있고 JS는 이 template을 복제해서 번호만 바꿉니다. -->
          </div>
        </article>

         <template class="admin-row-template">
          <tr class="data-row">
            <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
              <td data-field-index="0"></td>
              <td data-field-index="1"></td>
              <td data-field-index="2"></td>
              <td data-field-index="3"></td>
              <td data-field-index="4"></td>
              <td data-field-index="5"></td>
              <td data-field-index="6"></td>
              <td data-field-index="7"></td>
              <td data-field-index="8"><span class="badge blue"></span></td>
            <td class="action-cell">
              <button type="button" class="light-btn edit-row">수정</button>
              <button type="button" class="light-btn delete-row">삭제</button>
            </td>
          </tr>
        </template>

        <template class="admin-form-template">
          <div class="form-field">
            <label>상품명</label>
            <input type="text" name="prodName" data-field-index="0" data-default="" placeholder="상품명 입력">
          </div>
          <div class="form-field">
            <label>브랜드</label>
            <input type="text" name="brand" data-field-index="1" data-default="" placeholder="브랜드 입력">
          </div>
          <div class="form-field">
            <label>카테고리</label>
            <input type="text" name="categoryId" data-field-index="2" data-default="" placeholder="카테고리 입력">
          </div>
          <div class="form-field">
            <label>입고가</label>
            <input type="text" name="inboundPrice" data-field-index="3" data-default="" placeholder="가격 입력">
          </div>
          <div class="form-field">
            <label>판매가</label>
            <input type="text" name="price" data-field-index="4" data-default="" placeholder="가격 입력">
          </div>
          <div class="form-field">
            <label>힐높이</label>
            <input type="text" name="heelHeight" data-field-index="5" data-default="0" placeholder="힐높이 입력">
          </div>
          <div class="form-field">
            <label>할인율</label>
            <input type="text" name="discRate" data-field-index="6" data-default="0" placeholder="할인율 입력">
          </div>
          <div class="form-field">
            <label>상품노출레벨</label>
            <select name="minGrade" data-field-index="7" data-default="1">
              <option value="1" selected>전체</option>
              <option value="2">실버이상</option>
              <option value="3">골드이상</option>
              <option value="4">VIP</option>
            </select>
          </div>
          <div class="form-field">
            <label>상태</label>
            <select name="status" data-field-index="8" data-default="ready">
              <option value="ready" selected>판매대기</option>
              <option value="onSele" >판매중</option>
              <option value="soldOut">품절</option>
            </select>
          </div>
		  <!-- 상품 이미지 -->
		  <div class="product-image-section">
		      <div class="product-image-title">상품 이미지</div>
		  <div class="image-container">
		        <div class="main-image-area">
		            <label class="image-label">
		                대표 이미지 <span>(필수)</span>
		            </label>
		            <div id="mainDropZone" class="main-drop-zone">
		                <!-- 이미지가 없을 때 -->
		                <div id="mainGuide" class="main-upload-guide">
		                    <div class="upload-icon"> 📷 </div>
		                    <div class="upload-text"> 대표 이미지를 여기에 끌어다 놓으세요 </div>
		                    <div class="upload-or"> 또는 </div>
		                    <label for="mainImage" class="upload-button"> 이미지 선택 </label>
		                    <div class="upload-info">  JPG, PNG, WEBP / 최대 10MB </div>
		                </div>
		                <!-- 이미지 선택 후 미리보기 -->
		                <div id="mainPreviewArea" class="main-preview-area" style="display: none;">
		                    <img id="mainPreview" src="" alt="대표 이미지">
		                    <label for="mainImage" class="change-image-button"> 이미지 변경 </label>
		                </div>
		                <input type="file" id="thumbnail" name="thumbnail" hidden
		                       accept="image/jpeg,image/png,image/webp">
		            </div>
		        </div>
		        <div class="additional-image-area">
		            <label class="image-label">
		                추가 이미지 <span>(선택)</span>
		            </label>
		            <div id="subImageList" class="sub-image-list">
		                <label for="subImages" class="sub-image-add">
		                    <div class="plus"> + </div>
		                    <span> 이미지 추가 </span>
		                </label>
		            </div>
		            <div class="additional-info">최대 10장까지 추가 가능합니다.</div>
		            <!-- 여러 파일 선택 -->
		            <input type="file" id="files" name="files" hidden multiple
		                   accept="image/jpeg,image/png,image/webp">
		        </div>
		    </div>
		</div>        
        </template>
      </section>


      <!-- JS가 버튼 HTML을 문자열로 만들지 않도록 JSP에 페이지 버튼 템플릿을 둡니다. -->
      <template id="paginationButtonTemplate">
        <button type="button" class="page-number-button"></button>
      </template>

      <!-- CSV 저장용 링크도 JSP에 미리 둡니다. JS는 주소와 파일명만 설정합니다. -->
      <a id="adminCsvDownloadLink" hidden aria-hidden="true"></a>
    </section>
  </main>
  
  <script type="text/javascript">
  function sendOk() {
		const f = document.editForm;
		
		f.submit();
	}

	document.querySelector('#thumbnail').addEventListener('click', uploadFile);

	function uploadFile() {
		
	}

  </script>


  <!-- 등록/수정 모달의 바깥 디자인은 기존 공용 JSP를 그대로 사용합니다. -->
  <jsp:include page="/WEB-INF/views/admin/layout/modal.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
  <script src="${pageContext.request.contextPath}/dist/js/admin/list.js?v=20260813"></script>
</body>
</html>
