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
        <a href="${pageContext.request.contextPath}/admin/support/inquiry/list" class="active">1:1 문의 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/faq/list">FAQ 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/notice/list">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/qna/list">상품문의 관리</a>
      </nav>

      <article class="panel">
        <div class="panel-title">
          <div>
            <h2><i class="bi bi-app"></i> 1:1 문의 답변 ${mode=='update'?'수정':'등록'}</h2>
            <p>문의 번호 <b>${inquiryId}</b>번에 대한 답변을 작성합니다.</p>
          </div>
        </div>

        <div class="body-main">
          <form name="boardForm" method="post">
            <table class="table mt-3 write-form">
              <tr>
                <td class="bg-light col-sm-2" scope="row">답변 작성자</td>
                <td>
                  <p class="form-control-plaintext">${sessionScope.member.memberId}</p>
                </td>
              </tr>

              <tr>
                <td class="bg-light col-sm-2" scope="row">답변 내용</td>
                <td>
                  <textarea name="content" class="form-control" rows="10" placeholder="답변 내용을 입력하세요.">${answerDto.content}</textarea>
                </td>
              </tr>
            </table>

            <!-- 숨김 -->
            <input type="hidden" name="inquiryId" value="${inquiryId}">
            <input type="hidden" name="page" value="${page}">
            <input type="hidden" name="mode" value="${mode}">

            <table class="table table-borderless">
              <tr>
                <td class="text-center">
                  <button type="button" class="btn btn-dark" onclick="sendOk();">
                    ${mode=='update'?'수정완료':'등록완료'}&nbsp;<i class="bi bi-check2"></i>
                  </button>
                  <button type="reset" class="btn btn-light">다시입력</button>
                  <button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/admin/support/inquiry/list?page=${page}';">
                    ${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i>
                  </button>
                </td>
              </tr>
            </table>
          </form>
        </div>
      </article>

    </section>
  </main>

  <script type="text/javascript">
  function sendOk() {
      const f = document.boardForm;
      let str;

      str = f.content.value.trim();
      if( ! str ) {
          alert('답변 내용을 입력하세요.');
          f.content.focus();
          return;
      }

      f.action = '${pageContext.request.contextPath}/admin/support/inquiry/write';
      f.submit();
  }
  </script>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>