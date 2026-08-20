<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!doctype html>
<html class="no-js" lang="ko">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="x-ua-compatible" content="ie=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="shortcut icon" type="image/x-icon" href="${ctx}/dist/images/favicon.ico" />
  
  <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
  <link rel="stylesheet" href="${ctx}/dist/css/pages/customer/contact.css?v=20260812-jsp" />
  <link rel="stylesheet" href="${ctx}/dist/css/common/layout.css?v=20260806-0140" />
  <title>1:1 문의 상세 | Yongsinsa</title>
</head>
<body class="has-site-layout">
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main class="abc-cs-page" id="abcCsPage" data-context-path="${ctx}">
    <div class="abc-cs-wrap">
      <nav class="abc-cs-breadcrumb" aria-label="현재 위치">
        <a href="${ctx}/index.jsp">HOME</a>
        <span>&gt;</span>
        <a href="${ctx}/customer/inquiry/list">고객센터</a>
        <span>&gt;</span>
        <strong>1:1 문의 상세</strong>
      </nav>

      <div class="abc-cs-layout">
        <!-- 사이드바 메뉴 -->
        <aside class="abc-cs-sidebar" aria-label="고객센터 메뉴">
          <h1>고객센터</h1>
          <nav class="abc-cs-side-menu">
            <a href="${ctx}/customer/faq/list">자주 묻는 질문</a>
            <a href="${ctx}/customer/notice/list">공지사항</a>
            <a href="${ctx}/customer/inquiry/list" class="is-active">1:1 문의</a>
            <a href="${ctx}/customer/qna/list">상품문의</a>
          </nav>

          <div class="abc-cs-contact-box">
            <span>CS CENTER</span>
            <strong>1588-9667</strong>
            <p>평일 09:00 - 18:00</p>
            <p>점심 12:00 - 13:00</p>
            <p class="muted">주말·공휴일 휴무</p>
          </div>
        </aside>

        <!-- 메인 콘텐츠 영역 -->
        <div class="abc-cs-content">
          <section class="abc-cs-view is-active" aria-labelledby="abcInquiryTitle">
            <header class="abc-cs-section-head">
              <div>
                <h2 id="abcInquiryTitle">1:1 문의 상세</h2>
                <p>고객님이 남겨주신 문의 내용과 답변을 확인하실 수 있습니다.</p>
              </div>
            </header>

            <div class="body-main mt-3">
              <!-- 문의 제목 과 정보 -->
              <table class="table board-article table-bordered mb-4">
                <thead>
                  <tr class="table-light">
                    <td colspan="2" class="fw-bold fs-5 text-start p-3">
                      <span class="badge bg-secondary me-2">${dto.inquiryType}</span>
                      <c:out value="${dto.title}"/>
                    </td>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="w-50 text-muted p-3">
                      작성자 : ${dto.memberId}
                    </td>
                    <td class="text-end text-muted p-3">
                      접수일 : ${dto.createdAt} | 
                      상태 : 
                      <c:choose>
                        <c:when test="${dto.status == 1 || not empty answerDto}">
                          <span class="badge bg-success">답변완료</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-secondary">대기중</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </tbody>
              </table>

              <!-- 문의 내용 -->
              <table class="table board-article table-bordered mb-4">
                <thead>
                  <tr class="table-light">
                    <th class="p-3 text-start">문의 내용</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="p-4 align-top" height="200">
                      <div class="lh-base"><c:out value="${dto.content}"/></div>
                    </td>
                  </tr>
                </tbody>
              </table>

              <!-- 관리자 답변 -->
              <c:if test="${not empty answerDto}">
                <div class="reply mb-4 p-3 bg-light border rounded">
                  <div class="form-header mb-2 pb-2 border-bottom d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-primary">관리자 답변</span>
                    <span class="text-muted small">답변일 : ${answerDto.createdAt}</span>
                  </div>
                  <div class="p-2 lh-base">
                    <c:out value="${answerDto.content}"/>
                  </div>
                </div>
              </c:if>

              <!-- 하단 동작 버튼 -->
              <table class="table table-borderless mt-3">
                <tr>
                  <td class="w-50">
                    <c:if test="${dto.status == 0 && empty answerDto}">
                      <button type="button" class="btn btn-light border me-1" onclick="deleteOk();">삭제</button>
                    </c:if>
                  </td>
                  <td class="text-end">
                    <button type="button" class="btn btn-light border" onclick="location.href='${ctx}/customer/inquiry/list?${query}';">목록으로</button>
                  </td>
                </tr>
              </table>

            </div>
          </section>
        </div>
      </div>
    </div>
  </main>

  <script type="text/javascript">
    function deleteOk() {
        if(confirm("등록하신 문의글을 삭제하시겠습니까?")) {
            location.href = '${ctx}/customer/inquiry/delete?inquiryId=${dto.inquiryId}&${query}';
        }
    }
  </script>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
  <div class="abc-cs-toast" id="abcCsToast" role="status" aria-live="polite"></div>

  <script src="${ctx}/dist/js/vendor/modernizr-3.5.0.min.js"></script>
  <script src="https://code.jquery.com/jquery-4.0.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
  <script src="${ctx}/dist/js/vendor/owl.carousel.min.js"></script>
  <script src="${ctx}/dist/js/vendor/slick.min.js"></script>
  <script src="${ctx}/dist/js/vendor/wow.min.js"></script>
  <script src="${ctx}/dist/js/vendor/jquery.scrollUp.min.js"></script>
  <script src="${ctx}/dist/js/vendor/jquery.nice-select.min.js"></script>
  <script src="${ctx}/dist/js/vendor/jquery.magnific-popup.js"></script>
  <script src="${ctx}/dist/js/common/plugins.js"></script>

  <script src="${ctx}/dist/js/pages/customer/inquiry.js?v=20260812-jsp"></script>
  <script src="${ctx}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>