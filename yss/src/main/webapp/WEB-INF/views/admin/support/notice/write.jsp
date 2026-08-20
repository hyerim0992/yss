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
<body data-context-path="${pageContext.request.contextPath}">
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
		<form name="noticeForm"  method="post" enctype="multipart/form-data">
				
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
						<textarea name="content" id="ir1" class="form-control" style="width: 99%; height: 300px;">${dto.content}</textarea>
					</td>
				</tr>
				
				<tr>
					<th>파일</th> 
					<td>
						<input type="file" name="selectFile" multiple>
				 	</td>
				</tr>
				<c:if test="${mode=='update'}">
					<c:forEach var="vo" items="${listFile}">
						<tr>
							<td>첨부된파일</td>
							<td>
								<p class="update-file-item">
									<span>${vo.files}</span>
									<a href="javascript:deleteFile('${vo.fileId}');" class="light-btn">삭제</a>
								</p>
							</td>
						</tr>
					</c:forEach>
				</c:if>				
			</table>
			
			<div class="support-form-actions">
				<button type="button" class="light-btn" onclick="submitContents(this.form);">${mode=='update'?'수정완료':'등록완료'}</button>
				<button type="button" class="light-btn" onclick="resetForm(this.form);">다시입력</button>
				<button type="button" class="light-btn" onclick="location.href='${pageContext.request.contextPath}/admin/support/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			</div>
			
			<c:if test="${mode=='update'}">
				<input type="hidden" name="noticeId" value="${dto.noticeId}">
				<input type="hidden" name="page" value="${page}">
			</c:if>
		</form>    
    </article>
    
    <script type="text/javascript">
    function check() {
    	const f = document.noticeForm;
    	
    	if(! f.title.value.trim()) {
    		f.title.focus();
    		return false;
    	} 
    	
    	let str = f.content.value.trim();
    	if( ! str || str === '<p><br></p>' ) {
    		alert('내용을 입력하세요. ');
    		return false;
    	}
    	
    	f.action = '${pageContext.request.contextPath}/admin/support/notice/${mode}';

		return true;
    }
    </script>
    
  </main>

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: 'ir1',
	sSkinURI: '${pageContext.request.contextPath}/dist/se2/SmartEditor2Skin.html',
	fCreator: 'createSEditor2',
	fOnAppLoad: function(){
		// 로딩 완료 후
		oEditors.getById['ir1'].setDefaultFont('돋움', 12);
	},
});

function submitContents(elClickedObj) {
	 oEditors.getById['ir1'].exec('UPDATE_CONTENTS_FIELD', []);
	 try {
		if(! check()) {
			return;
		}
		
		elClickedObj.submit();
		
	} catch(e) {
	}
}

<c:if test = "${mode == 'update'}">
	function deleteFile(fileId) {
		if(! confirm('파일을 삭제 하시겠습니까 ? ')) {
			return
		}
		
		let params = 'noticeId=${dto.noticeId}&fileId=' + fileId + '&page=${page}';
		let url = '${pageContext.request.contextPath}/admin/support/notice/deleteFile?' + params;
		location.href = url;
	}
</c:if>

function resetForm(f) {
	f.reset();
	oEditors.getById["ir1"].exec("SET_IR", [f.content.value]);
}
</script>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>
