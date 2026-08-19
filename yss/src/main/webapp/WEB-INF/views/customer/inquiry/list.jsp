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
  <title>1:1 문의 | Yongsinsa</title>
</head>
<body class="has-site-layout">
  <jsp:include page="/WEB-INF/views/common/header.jsp" />
  <main class="abc-cs-page" id="abcCsPage" data-context-path="${ctx}">
      <div class="abc-cs-wrap">
        <nav class="abc-cs-breadcrumb" aria-label="현재 위치">
          <a href="${ctx}/index.jsp">HOME</a>
          <span>&gt;</span>
          <strong>고객센터</strong>
        </nav>

        <div class="abc-cs-layout">
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

          <div class="abc-cs-content">
            <section class="abc-cs-view is-active" aria-labelledby="abcInquiryTitle">
              <header class="abc-cs-section-head">
                <div>
                  <h2 id="abcInquiryTitle">1:1 문의</h2>
                  <p>주문, 결제, 배송 등 해결되지 않은 문의를 남겨주세요.</p>
                </div>
              </header>

              <div class="abc-cs-subtabs">
                <button type="button" class="is-active" data-abc-inquiry-tab="history">문의내역 조회</button>
                <button type="button" data-abc-inquiry-tab="write" onclick="changeInquiry()">문의 작성</button>
              </div>

              <div class="abc-cs-history" data-abc-inquiry-panel="history">
                <div class="abc-cs-table-head abc-cs-history-columns">
                  <span>문의유형</span>
                  <span>제목</span>
                  <span>접수일</span>
                  <span>상태</span>
                </div>

                <%-- 1. 등록된 문의글이 없는 경우 --%>
                <c:choose>
                  <c:when test="${dataCount == 0}">
                    <div class="abc-cs-empty" id="abcInquiryHistoryEmpty">
                      <strong>등록된 문의가 없습니다.</strong>
                      <p>문의 작성 탭에서 새로운 문의를 남겨보세요.</p>
                    </div>
                  </c:when>
                  
                  <%-- 2. 등록된 문의글이 있는 경우 (목록 출력) --%>
                  <c:otherwise>
                    <div id="abcInquiryHistoryList">
                      <c:forEach var="dto" items="${list}">
                        <div class="abc-cs-history-row">
                          <span>${dto.inquiryType}</span>
                          <strong>
                            <a href="${articleUrl}&inquiryId=${dto.inquiryId}" style="color: inherit; text-decoration: none;">
                              <c:out value="${dto.title}"/>
                            </a>
                          </strong>
                          <time>${dto.createdAt}</time>
                          <span>${dto.status==0?"대기중":"답변완료"}</span>
                        </div>
                      </c:forEach>
                    </div>

                    <%-- 3. 하단 페이징 영역 --%>
                    <div class="page-navigation" style="margin-top: 20px; text-align: center;">
                      ${paging}
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>

            </section>
          </div>
        </div>
      </div>
    </main>

    <script type="text/javascript">
    function changeInquiry() {
    	location.href = '${pageContext.request.contextPath}/customer/inquiry/write';
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