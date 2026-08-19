<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="adminPage" value="support" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>1:1 문의 답변 작성 | Yongsinsa 관리자</title>

  <script>
    document.documentElement.classList.add("ys-page-loading");
    window.__ysPageLoaderStart = Date.now();
  </script>

  <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/list.css?v=20260812">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/support.css?v=20260812">
  
  <script type="text/javascript">
    function sendAnswer() {
        const f = document.answerForm;
        if (!f.content.value.trim()) {
            alert("답변 내용을 입력해 주세요.");
            f.content.focus();
            return;
        }
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
          <p>관리자 페이지 / 고객 지원 / 답변 작성</p>
          <h1>1:1 문의 답변 ${mode == 'update' ? '수정' : '작성'}</h1>
          <span>고객의 문의 내용을 참고하여 답변을 작성합니다.</span>
        </div>
      </div>

      <nav class="support-tabs" aria-label="고객지원 관리 탭">
        <a href="${pageContext.request.contextPath}/admin/support/inquiry/list" class="active">1:1 문의 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/faq/list">FAQ 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/notice/list">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/qna/list">상품문의 관리</a>
      </nav>

      <article class="panel">
        <!-- 고객 문의 내역 -->
        <div class="panel-title">
          <div>
            <h2>고객 문의 내용</h2>
          </div>
        </div>

        <div class="table-wrap">
          <table>
            <tbody>
              <tr>
                <th>문의 번호</th>
                <td><b>${inquiryId}</b></td>
                <th>문의 유형</th>
                <td><span class="badge light">${inquiryDto.inquiryType}</span></td>
              </tr>
              <tr>
                <th>작성자 ID</th>
                <td>${inquiryDto.memberId}</td>
                <th>등록일시</th>
                <td>${empty inquiryDto.createdAt ? '-' : inquiryDto.createdAt}</td>
              </tr>
              <tr>
                <th>문의 제목</th>
                <td colspan="3">${inquiryDto.title}</td>
              </tr>
              <tr>
                <th>문의 내용</th>
                <td colspan="3">${inquiryDto.content}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- 답변 작성 -->
        <form name="answerForm" method="post" action="${pageContext.request.contextPath}/admin/support/inquiry/write">
          <input type="hidden" name="inquiryId" value="${inquiryId}">
          <input type="hidden" name="page" value="${page}">
          <input type="hidden" name="mode" value="${mode}">

          <div class="panel-title">
            <div>
              <h2>관리자 답변 입력</h2>
            </div>
          </div>

          <div class="table-wrap">
            <table>
              <tbody>
                <tr>
                  <th>답변 내용</th>
                  <td colspan="3">
                    <textarea name="content" placeholder="고객에게 전달할 답변 내용을 입력하세요.">${answerDto.content}</textarea>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- 버튼 영역 -->
          <div class="support-actions">
            <div>
              <button type="button" class="dark-btn" onclick="sendAnswer();">
                ${mode == 'update' ? '답변 수정 완료' : '답변 등록 완료'}
              </button>
            </div>

            <div>
              <button type="button" class="light-btn" onclick="history.back();">취소</button>
            </div>
          </div>
        </form>

      </article>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>