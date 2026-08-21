<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>마이페이지 | Yongsinsa</title>
		<link rel="shortcut icon" type="image/x-icon" href="${ctx}/dist/images/favicon.ico">
    <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />

            <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/mypage/mypage.css?v=20260806-cart-coupon-custom-5" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/layout.css?v=20260806-modal-layer-2" />
</head>
  <body class="has-site-layout" data-context-path="${ctx}">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

	<jsp:include page="/WEB-INF/views/mypage/left.jsp"/>

      <div class="my-content">
        <!-- 마이페이지 홈 -->
        <section class="page-view is-active" data-page="home">
          <div class="welcome-card">
            <div class="avatar" aria-hidden="true">Y</div>
            <div class="welcome-user">
              <span class="eyebrow">WELCOME BACK</span>
              <h1>김민혁님, 반가워요!</h1>
              <p>kcco100@kakao.com</p>
            </div>
            <a class="compact-stat" href="#point" data-view="point">
              <span>보유 포인트</span><strong>12,500 P</strong
              ><small>사용 내역 보기 →</small>
            </a>
            <a class="compact-stat" href="#coupon" data-view="coupon">
              <span>사용 가능 쿠폰</span><strong>3장</strong
              ><small>쿠폰함 보기 →</small>
            </a>
          </div>

          <div class="home-grid">
            <section class="dashboard-card order-summary">
              <div class="section-heading">
                <div>
                  <span class="eyebrow blue">BUYING</span>
                  <h2>구매 현황</h2>
                </div>
                <a href="#purchase" data-view="purchase">전체 내역 →</a>
              </div>
              <div class="status-flow">
                <button data-view="purchase">
                  <b>1</b><span>주문 접수</span>
                </button>
                <i>›</i
                ><button data-view="purchase">
                  <b>2</b><span>결제 완료</span>
                </button>
                <i>›</i
                ><button data-view="shipping">
                  <b>1</b><span>배송 중</span>
                </button>
                <i>›</i
                ><button data-view="purchase">
                  <b>8</b><span>구매 완료</span>
                </button>
              </div>
            </section>

            <section class="dashboard-card order-summary">
              <div class="section-heading">
                <div>
                  <span class="eyebrow blue">MY SHOPPING</span>
                  <h2>쇼핑 활동</h2>
                </div>
                <a href="#cart" data-view="cart">장바구니 보기 →</a>
              </div>
              <div class="status-flow">
                <button data-view="wishlist"><b>3</b><span>위시리스트</span></button>
                <i>›</i>
                <button data-view="cart"><b>2</b><span>장바구니</span></button>
                <i>›</i>
                <button data-view="reviews"><b>2</b><span>작성 리뷰</span></button>
                <i>›</i>
                <button data-view="inquiry"><b>1</b><span>문의내역</span></button>
              </div>
            </section>
          </div>

          <section class="dashboard-card recent-card">
            <div class="section-heading">
              <div>
                <span class="eyebrow">RECENT ORDER</span>
                <h2>최근 구매내역</h2>
              </div>
              <a href="#purchase" data-view="purchase">더보기 →</a>
            </div>
            <article class="order-row">
              <div class="shoe-thumb">SHOE</div>
              <div class="order-info">
                <span>2026.08.01 · 주문번호 YS260801-0148</span
                ><strong>New Balance 993 Made in USA Grey</strong>
                <p>그레이 · 260mm</p>
              </div>
              <div class="order-price">
                <strong>289,000원</strong
                ><span class="shipping-badge">배송 중</span>
              </div>
              <button class="outline-button" data-view="shipping">
                배송 조회
              </button>
            </article>
          </section>

    <div class="toast" id="toast" role="status"></div>
        <script src="${ctx}/dist/js/vendor/modernizr-3.5.0.min.js"></script>
		<script src="https://code.jquery.com/jquery-4.0.0.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

        <script src="${ctx}/dist/js/vendor/owl.carousel.min.js"></script>
        <script src="${ctx}/dist/js/vendor/slick.min.js"></script>

        <script src="${ctx}/dist/js/vendor/wow.min.js"></script>
        <script src="${ctx}/dist/js/vendor/jquery.magnific-popup.js"></script>

        <script src="${ctx}/dist/js/vendor/jquery.scrollUp.min.js"></script>
        <script src="${ctx}/dist/js/vendor/jquery.nice-select.min.js"></script>
        
        <script src="${ctx}/dist/js/vendor/jquery.ajaxchimp.min.js"></script>
        
        <script src="${ctx}/dist/js/common/plugins.js"></script>
        <script src="${ctx}/dist/js/common/main.js"></script>
        
    
  
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    

    <script src="https://t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/pages/mypage/mypage.js?v=20260806-cart-coupon-custom-5"></script>
    <script src="${pageContext.request.contextPath}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
