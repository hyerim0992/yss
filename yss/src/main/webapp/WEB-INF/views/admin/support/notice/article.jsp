<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="adminPage" value="support" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>공지사항 상세 | Yongsinsa 관리자</title>

  <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>

  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/dist/css/admin/list.css?v=20260812">

  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/dist/css/admin/support.css?v=20260812">
</head>

<body data-context-path="${pageContext.request.contextPath}">
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
  	<jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
  	
  	<main class="admin-main">
  		<section class="page active">
  		
  			<section class="page active">
			
				<div class="page-heading">
					<div>
						<p>관리자 페이지 / 고객 지원 / 관리</p>
						<h1>고객 지원 / 관리</h1>
						<span>1:1 문의, FAQ, 공지사항과 상품문의 답변을 관리합니다.</span>
					</div>
				</div>
			
				<nav class="support-tabs" aria-label="고객지원 관리 탭">
					<a href="${pageContext.request.contextPath}/admin/support/inquiry/list">1:1 문의 관리</a>
					<a href="${pageContext.request.contextPath}/admin/support/faq/list">FAQ 관리</a>
					<a href="${pageContext.request.contextPath}/admin/support/notice/list" class="active">공지사항 관리</a>
					<a href="${pageContext.request.contextPath}/admin/support/qna/list">상품문의 관리</a>
				</nav>
			
			</section>
  			
  			<article class="panel">
			
				<div class="support-detail-head">
					<h2><c:out value="${dto.title}"/></h2>
					<div class="support-detail-date">작성일 : <c:out value="${dto.createDate}"/></div>
				</div>
			
				<div class="support-detail-writer">작성자 : <c:out value="${dto.name}"/></div>
			
				<hr>
			
				<div class="support-detail-content">
					${dto.content}
				</div>
			
				<c:if test="${not empty listFile}">
					<details class="support-file-dropdown">
						<summary>첨부파일 <span>${listFile.size()}</span></summary>
			
						<div class="support-file-list">
							<c:forEach var="vo" items="${listFile}">
								<a href="${pageContext.request.contextPath}/admin/support/notice/download?fileId=${vo.fileId}"
									class="text-reset" data-no-page-loader>${vo.files}</a>
							</c:forEach>
						</div>
					</details>
				</c:if>
				
				<div class="support-actions support-detail-actions">
					<a href="${pageContext.request.contextPath}/admin/support/notice/list?${query}" class="light-btn">목록</a>
				
					<a href="${pageContext.request.contextPath}/admin/support/notice/update?noticeId=${dto.noticeId}&${query}" class="light-btn">수정</a>
				
					<a href="${pageContext.request.contextPath}/admin/support/notice/delete?noticeId=${dto.noticeId}&page=${page}&size=${size}"
              			class="light-btn"
              			onclick="return confirm('공지사항을 삭제하시겠습니까?');">
              			삭제
              		</a>
				</div>
			
			</article>
  		</section>
  	</main>

	<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

</body>
</html>