<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="adminPage" value="support" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>고객지원 | Yongsinsa 관리자</title>

  <script>
    document.documentElement.classList.add("ys-page-loading");
    window.__ysPageLoaderStart = Date.now();
  </script>

  <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/list.css?v=20260812">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/support.css?v=20260812">
  
  <script type="text/javascript">
    function searchList() {
        const f = document.searchForm;
        f.submit();
    }
  </script>
</head>
<body>
  <jsp:include page="/WEB-INF/views/common/page-loader.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

  <main class="admin-main">
    <section class="page active">
      <div class="page-heading">
        <div>
          <p>관리자 페이지 / 고객 지원 / 관리</p>
          <h1>고객 지원 / 관리</h1>
          <span>1:1 문의, FAQ, 공지사항과 상품문의 답변을 관리합니다.</span>
        </div>
      </div>

      <nav class="support-tabs" aria-label="고객지원 관리 탭">
        <a href="${pageContext.request.contextPath}/admin/support/inquiry/list" class="active">1:1 문의 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/faq/list">FAQ 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/notice/list">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/qna/list">상품문의 관리</a>
      </nav>

      <!-- 검색 및 상태 필터 폼 -->
      <form name="searchForm" method="get" action="${pageContext.request.contextPath}/admin/support/inquiry/list"
            class="panel search-panel support-search-form">
        <div class="search-row">
          <select name="schType">
            <option value="all" ${schType=='all'?'selected':''}>전체</option>
            <option value="title" ${schType=='title'?'selected':''}>문의제목</option>
            <option value="content" ${schType=='content'?'selected':''}>문의내용</option>
            <option value="inquiryType" ${schType=='inquiryType'?'selected':''}>문의유형</option>
            <option value="name" ${schType=='name'?'selected':''}>작성자</option>
          </select>

          <input type="text" name="kwd" value="${kwd}" placeholder="검색어를 입력하세요">

          <button type="button" class="dark-btn" onclick="searchList();">검색</button>
          <a href="${pageContext.request.contextPath}/admin/support/inquiry/list" class="light-btn">초기화</a>
        </div>
			<div class="filter-row">
			  <div class="filter-control">
			    <label for="status">답변상태</label>
			    <select name="status" id="status" onchange="searchList();">
			      <option value="all" ${status=='all'?'selected':''}>전체</option>
			      <option value="0" ${status=='0'?'selected':''}>접수중</option>
			      <option value="1" ${status=='1'?'selected':''}>답변완료</option>
			    </select>
			  </div>
			</div>
      </form>

      <article class="panel">
        <div class="panel-title">
          <div>
            <h2>1:1 문의 목록</h2>
            <p>검색 결과 <b>${dataCount}</b>건 (페이지 ${page}/${total_page})</p>
          </div>

          <div>
            <button type="button" class="light-btn danger-btn">선택 삭제</button>
            <button type="button" class="light-btn">CSV 저장</button>
          </div>
        </div>
        
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th><input type="checkbox"></th>
                <th>문의번호</th>
                <th>문의유형</th>
                <th>문의제목</th>
                <th>작성자</th>
                <th>등록일</th>
                <th>답변상태</th>
                <th>관리</th>
              </tr>
            </thead>

            <tbody>
              <c:forEach var="dto" items="${list}">
                <tr>
                  <td><input type="checkbox" name="nums" value="${dto.inquiryId}"></td>
                  <td>${dto.inquiryId}</td>
                  <td><span class="badge light">${dto.inquiryType}</span></td>
                  <td>
                  	<a href="${pageContext.request.contextPath}/admin/support/inquiry/article?inquiryId=${dto.inquiryId}&page=${page}" class="text-reset">
  						${dto.title}
					</a>
				  </td>
                  <td>${dto.memberId}</td>
                  <td>${dto.createdAt}</td>
                  <td>
                    <c:choose>
                      <c:when test="${dto.status == 1}">
                        <span class="badge green">답변완료</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge gray">접수중</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <div class="support-actions">
                      <c:choose>
                        <c:when test="${dto.status == 1}">
                          <a href="${writeUrl}&inquiryId=${dto.inquiryId}" class="light-btn answer-btn completed">답변 수정</a>
                        </c:when>
                        <c:otherwise>
                          <a href="${writeUrl}&inquiryId=${dto.inquiryId}" class="light-btn answer-btn">답변 등록</a>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${dataCount == 0}">
                <tr>
                  <td colspan="8" style="text-align: center; padding: 30px 0;">
                    등록된 문의가 없습니다.
                  </td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>

        <!-- 동적 페이징 -->
        <div class="support-pagination">
          ${paging}
        </div>
      </article>

    </section>
  </main>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>