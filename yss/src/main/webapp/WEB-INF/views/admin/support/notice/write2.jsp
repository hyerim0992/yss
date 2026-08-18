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
        <a href="${pageContext.request.contextPath}/admin/support/inquiry/list">1:1 문의 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/faq/list">FAQ 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/notice/list" class="active">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/qna/list">상품문의 관리</a>
      </nav>
    </section>
    
    <article class="panel">
		<form name="noticeForm"  method="post">
				
			<table>
				<tr>
					<th>제목</th> 
					<td>
						<input type="text" name="title" value="${dto.title}">
				 	</td>
				</tr>
				
				<tr>
					<th>내 용</th>
					<td>
						<textarea name="content">${dto.content}</textarea>
					</td>
				</tr>
			</table>
			
			<button type="button" onclick="sendOk();">
			${mode=='update'?'수정완료':'등록완료'}
			</button>
			<button type="reset">다시입력</button>
			<button type="button" 
				onclick="location.href='${pageContext.request.contextPath}/admin/support/notice/list';">
				${mode=='update'?'수정취소':'등록취소'}
			</button>
			
			<c:if test="${mode=='update'}">
				<input type="hidden" name="noticeId" value="${dto.noticeId}">
				<input type="hidden" name="page" value="${page}">
			</c:if>
		</form>    
    </article>
    
    <script type="text/javascript">
    function sendOk() {
    	const f = document.noticeForm;
    	
    	if(! f.title.value.trim()) {
    		f.title.focus();
    		return;
    	} 
    	
    	if( ! f.content.value.trim()) {
    		f.content.focus();
    		return;
    	}
    	
    	f.action = '${pageContext.request.contextPath}/admin/support/notice/${mode}';
    	f.submit();
    }
    </script>
    
  </main>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>
