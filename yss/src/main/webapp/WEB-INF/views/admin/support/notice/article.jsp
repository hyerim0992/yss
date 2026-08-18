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
  		
  			<div class="page-heading">
  				<div>
  					<p>관리자 페이지 / 고객 지원 / 공지사항</p>
         		    <h1>공지사항 상세</h1>
  				</div>
  			</div>
  			
  			<article class="panel">
  				<h2>
  					<c:out value="${dto.title}"/>
  				</h2>
  				
  				<div>
  					작성자 : 
  					<c:out value="${dto.name}"/>
  				</div>
  				
  				<div>
  					작성일 : 
  					<c:out value="${dto.createDate}"/>
  				</div>
  				
  				<hr>
  				
  				<div>
  					${dto.content}
  				</div>
  				
  				<!-- 첨부파일 -->
  				<c:if test="${not empty listFile}">
  					<div class="support-file" style="margin-top: 20px;">
  						<i class="bi bi-folder2-open"></i>
  						<c:forEach var="vo" items="${listFile}" varStatus="status">
  							<a href="${pageContext.request.contextPath}/admin/support/notice/download?fileId=${vo.fileId}"
  								class="text-reset">${vo.files}</a>
  								<c:if test="${not status.last}"> | </c:if>
  						</c:forEach>
  					</div>
  				</c:if>
  				
  				<div class="support-actions" style="margin-top: 30px;">
  					<a href="${pageContext.request.contextPath}/admin/support/notice/list?${query}"
  						class="light-btn">
  						목록
  					</a>
  					
  					<a href="${pageContext.request.contextPath}/admin/support/notice/update?page=${page}&noticeId=${dto.noticeId}"
  						class="light-btn">
  						수정
  					</a>
  					
  					<a href="${pageContext.request.contextPath}/admin/support/notice/delete?noticeId=${dto.noticeId}&${query}"
  						class="light-btn"
  						onclick="return confirm('공지사항을 삭제하시겠습니까 ?');">
  						삭제
  					</a>
  				</div>
  				
  			</article>
  		</section>
  	</main>

	<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

</body>
</html>