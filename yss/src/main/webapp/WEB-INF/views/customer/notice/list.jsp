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
  <title>공지사항 | Yongsinsa</title>
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
              <a href="${ctx}/customer/notice/list" class="is-active">공지사항</a>
              <a href="${ctx}/customer/inquiry/list">1:1 문의</a>
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
            <section class="abc-cs-view is-active" aria-labelledby="abcNoticeTitle">
              <header class="abc-cs-section-head"><div><h2 id="abcNoticeTitle">공지사항</h2><p>서비스 운영과 이벤트 관련 주요 안내를 확인하세요.</p></div></header>

              <form class="abc-cs-search" id="abcNoticeSearchForm" method="get" action="${pageContext.request.contextPath}/customer/notice/list">
                <i class="fas fa-search" aria-hidden="true"></i>
                <input type="hidden" name="schType" value="title">
                <input id="abcNoticeSearchInput" name="kwd" type="search" placeholder="공지사항 제목을 검색해 주세요." autocomplete="off" />
                <button type="submit">검색</button>
              </form>
				
			  <br>

              <div class="abc-cs-table-head abc-cs-notice-columns"><span>번호</span><span>제목</span><span>작성일</span></div>
              <!-- ★ 연습 포인트: 아래 샘플 버튼들을 나중에 직접 반복 출력 구조로 바꿔보세요. -->
              <div class="abc-cs-notice-list">
              	<c:forEach var="dto" items="${list}" varStatus="status">
              		<div class="abc-cs-notice-row">
              			<div class="notice-number">
              				${dataCount - (page - 1) * size - status.index}
              			</div>
              			
              			<div class="notice-title">
              				<a href="${articleUrl}&noticeId=${dto.noticeId}">
              					<c:out value="${dto.title}"/>
              				</a>
              			</div>
              			
              			<div class="notice-date">
              				<c:out value="${dto.createDate}"/>
              			</div>
              		</div>
              	</c:forEach>
              </div>
              
              <div class="page-navigation" style="text-align: center;">
              	<c:choose>
              		<c:when test="${dataCount == 0}">
              			<strong>검색 결과가 없습니다.</strong>
              			<p>다른 검색어 또는 분류를 선택해 보세요.</p>
              		</c:when>
              		
              		<c:otherwise>
              			${paging}
              		</c:otherwise>
              	</c:choose>
              </div>

              <!-- 상세 화면의 모양도 JSP에 미리 둡니다. JS는 글자만 채우고 숨김/표시만 합니다. -->
              <article class="abc-cs-notice-detail" id="abcNoticeDetail" hidden>
                <button type="button" class="abc-cs-text-button" id="abcNoticeBack">목록으로</button>
                <div class="abc-cs-notice-detail-head"><span id="abcNoticeDetailType">공지</span><h3 id="abcNoticeDetailTitle">공지사항 제목</h3><time id="abcNoticeDetailDate">2026.08.04</time></div>
                <div class="abc-cs-notice-detail-body"><p id="abcNoticeDetailBody">공지사항 내용이 표시되는 자리입니다.</p><p>관련 문의는 고객센터 1:1 문의를 이용해 주세요.</p></div>
              </article>
            </section>
          </div>
        </div>
      </div>
    </main>

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
  <script src="${ctx}/dist/js/common/main.js"></script>
  <script src="${ctx}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
