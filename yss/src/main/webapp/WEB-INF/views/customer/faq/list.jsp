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
  <title>자주 묻는 질문 | Yongsinsa</title>
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
              <a href="${ctx}/customer/faq/list" class="is-active">자주 묻는 질문</a>
              <a href="${ctx}/customer/notice/list">공지사항</a>
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
            <section class="abc-cs-view is-active" aria-labelledby="abcFaqTitle">
              <header class="abc-cs-section-head">
                <div>
                  <h2 id="abcFaqTitle">자주 묻는 질문</h2>
                  <p>궁금한 내용을 검색하거나 카테고리를 선택해 빠르게 확인하세요.</p>
                </div>
              </header>

              <form class="abc-cs-search" id="abcFaqSearchForm" method="get" action="${ctx}/customer/faq/list">
                <i class="fas fa-search" aria-hidden="true"></i>
                <input id="abcFaqSearchInput" name="kwd" type="search" placeholder="궁금한 내용을 입력해 주세요." autocomplete="off" />
                <button type="submit">검색</button>
              </form>

              <div class="abc-cs-category-grid" aria-label="FAQ 카테고리">
                <button type="button" class="is-active" data-abc-faq-category="전체">전체</button>
                <button type="button" data-abc-faq-category="회원">회원</button>
                <button type="button" data-abc-faq-category="주문/결제">주문/결제</button>
                <button type="button" data-abc-faq-category="배송">배송</button>
                <button type="button" data-abc-faq-category="교환/반품">교환/반품</button>
                <button type="button" data-abc-faq-category="상품정보">상품정보</button>
                <button type="button" data-abc-faq-category="심의">심의</button>
                <button type="button" data-abc-faq-category="기타">기타</button>
              </div>

              <div class="abc-cs-list-title">
                <strong>자주 묻는 질문 BEST</strong>
                <span>총 <b id="abcFaqCount">${list.size()}</b>건</span>
              </div>

              <!--
                ★ 연습 포인트
                지금은 샘플 FAQ를 JSP에 직접 적어 두었습니다.
                DB 연동을 시작하면 아래 article 8개를 보고 직접 c:forEach 형태로 바꿔보세요.
                답변 공개 여부 같은 조건이 생기면 조건문도 직접 작성하는 연습용입니다.
              -->
              <div class="abc-cs-faq-list" id="abcFaqList">

	<c:forEach var="dto" items="${list}">
	
		<article class="abc-cs-faq-item"
			data-category="${dto.category}"
			data-search="${dto.category} ${dto.title} ${dto.content}">
			
			<button type="button"
				class="abc-cs-faq-question"
				aria-expanded="false">
				
				<span class="abc-cs-row-category">
					${dto.category}
				</span>
				
				<strong>
					${dto.title}
				</strong>
				
				<span class="abc-cs-arrow"
					aria-hidden="true">
				</span>
				
			</button>
			
			<div class="abc-cs-faq-answer">
				<p>${dto.content}</p>
			</div>
			
		</article>
		
	</c:forEach>

</div>
              <div class="abc-cs-empty" id="abcFaqEmpty" hidden><strong>검색 결과가 없습니다.</strong><p>다른 검색어를 입력하거나 카테고리를 변경해 보세요.</p></div>
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
  <script src="${ctx}/dist/js/pages/customer/faq.js?v=20260812-jsp"></script>
  <script src="${ctx}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
