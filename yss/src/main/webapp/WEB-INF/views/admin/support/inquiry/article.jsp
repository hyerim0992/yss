<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="adminPage" value="support" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>1:1 문의 상세보기 | Yongsinsa 관리자</title>

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
          <p>관리자 페이지 / 고객 지원 / 1:1 문의 상세</p>
          <h1>1:1 문의 상세보기</h1>
          <span>고객이 접수한 1:1 문의의 상세 내용과 답변을 확인합니다.</span>
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
            <h2>문의 번호 : ${inquiryId}</h2>
          </div>
          <div>
            <c:choose>
              <c:when test="${not empty answerDto}">
                <span class="badge green">답변완료</span>
              </c:when>
              <c:otherwise>
                <span class="badge gray">접수중</span>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- 고객 문의 내용 -->
        <div class="table-wrap">
          <table>
            <tbody>
              <tr>
                <th>문의 번호</th>
                <td><b>${inquiryId}</b></td>
                <th>문의 유형</th>
                <td><span class="badge light">${dto.inquiryType}</span></td>
              </tr>
              <tr>
                <th>작성자 ID</th>
                <td>${dto.memberId}</td>
                <th>등록일시</th>
                <td>${empty dto.createdAt ? '-' : dto.createdAt}</td>
              </tr>
              <tr>
                <th>문의 제목</th>
                <td colspan="3">${dto.title}</td>
              </tr>
              <tr>
                <th>고객 문의 내용</th>
                <td colspan="3">${dto.content}</td>
              </tr>

              <!-- 관리자 답변 내용 -->
              <c:if test="${not empty answerDto}">
                <tr>
                  <th>관리자 답변</th>
                  <td colspan="3">
                    <div><b>작성자: ${answerDto.answerer}</b> (${answerDto.createdAt})</div>
                    <div>${answerDto.content}</div>
                  </td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>

        <!-- 하단 버튼 -->
        <div class="support-actions">
          <div>
            <c:choose>
              <c:when test="${not empty answerDto}">
                <a href="${pageContext.request.contextPath}/admin/support/inquiry/write?inquiryId=${inquiryId}&page=${page}" class="dark-btn">답변 수정</a>
              </c:when>
              <c:otherwise>
                <a href="${pageContext.request.contextPath}/admin/support/inquiry/write?inquiryId=${inquiryId}&page=${page}" class="dark-btn">답변 등록</a>
              </c:otherwise>
            </c:choose>
          </div>

          <div>
            <button type="button" class="light-btn" onclick="location.href='${pageContext.request.contextPath}/admin/support/inquiry/list?${query}';">목록으로</button>
          </div>
        </div>

      </article>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>