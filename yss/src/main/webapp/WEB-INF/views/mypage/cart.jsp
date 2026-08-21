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
      
        <section class="page-view is-active" data-page="cart">
          <div class="page-title cart-page-title">
            <div>
              <span class="eyebrow blue">SHOPPING CART</span>
              <h1>장바구니</h1>
              <p>상품 옵션과 수량을 확인하고 쿠폰·포인트 적용 금액을 미리 계산할 수 있어요.</p>
            </div>
          </div>

          <div class="cart-toolbar" style="border-top:none;">
            <label class="cart-select-all">
              <input type="checkbox" id="cartAll" checked />
              <span>전체 선택</span>
            </label>
            <span class="cart-toolbar-guide">선택한 상품만 주문할 수 있습니다.</span>
          </div>

          <div class="cart-list cart-list-v2" id="cartList">
            <article
              class="cart-item cart-item-v2"
              data-price="149000"
              data-list-price="169000"
              data-product-name="Samba OG Core Black"
              data-brand="Adidas"
              data-color="블랙"
              data-size="255"
            >
              <input type="checkbox" class="cart-check" checked aria-label="Samba OG 선택" />
              <div class="shoe-thumb dark">AD</div>
              <div class="cart-product">
                <small>Adidas</small>
                <h3>Samba OG Core Black</h3>
                <p class="cart-option-text">블랙 · 255mm</p>
                <button type="button" class="cart-option-button">옵션 변경</button>
              </div>
              <div class="cart-quantity-control" aria-label="수량 변경">
                <span>수량</span>
                <div>
                  <button type="button" class="cart-quantity-minus" aria-label="수량 줄이기">−</button>
                  <input type="number" min="1" max="10" value="1" readonly />
                  <button type="button" class="cart-quantity-plus" aria-label="수량 늘리기">+</button>
                </div>
              </div>
              <div class="cart-item-price">
                <del class="cart-list-price">169,000원</del>
                <strong class="cart-price">149,000원</strong>
                <small class="cart-discount-rate">12% 할인</small>
              </div>
              <button type="button" class="cart-remove" data-action="remove-cart">삭제</button>
            </article>

            <article
              class="cart-item cart-item-v2"
              data-price="139000"
              data-list-price="159000"
              data-product-name="Air Force 1 '07 White"
              data-brand="Nike"
              data-color="화이트"
              data-size="265"
            >
              <input type="checkbox" class="cart-check" checked aria-label="Air Force 1 선택" />
              <div class="shoe-thumb cream">NK</div>
              <div class="cart-product">
                <small>Nike</small>
                <h3>Air Force 1 '07 White</h3>
                <p class="cart-option-text">화이트 · 265mm</p>
                <button type="button" class="cart-option-button">옵션 변경</button>
              </div>
              <div class="cart-quantity-control" aria-label="수량 변경">
                <span>수량</span>
                <div>
                  <button type="button" class="cart-quantity-minus" aria-label="수량 줄이기">−</button>
                  <input type="number" min="1" max="10" value="1" readonly />
                  <button type="button" class="cart-quantity-plus" aria-label="수량 늘리기">+</button>
                </div>
              </div>
              <div class="cart-item-price">
                <del class="cart-list-price">159,000원</del>
                <strong class="cart-price">139,000원</strong>
                <small class="cart-discount-rate">13% 할인</small>
              </div>
              <button type="button" class="cart-remove" data-action="remove-cart">삭제</button>
            </article>
          </div>

          <div class="cart-selection-actions">
          </div>

          <section class="cart-payment-box" aria-labelledby="cartPaymentTitle">
            <div class="cart-payment-head">
              <div>
                <h2 id="cartPaymentTitle">결제 금액</h2>
                <p id="cartSelectedSummary">선택 상품 2개 · 총 수량 2개</p>
              </div>
              <button type="button" class="cart-benefit-button" id="cartCouponOpen">
                쿠폰·포인트 적용
              </button>
            </div>

            <div class="cart-payment-equation">
              <div>
                <span>주문금액</span>
                <strong id="cartProductTotal">288,000원</strong>
              </div>
              <i aria-hidden="true">−</i>
              <div>
                <span>할인금액</span>
                <strong id="cartDiscountTotal">0원</strong>
              </div>
              <i aria-hidden="true">=</i>
              <div class="is-final">
                <span>결제예정금액</span>
                <strong id="cartGrandTotal">288,000원</strong>
              </div>
            </div>

            <div class="cart-payment-details">
              <div><span>상품금액</span><b id="cartDetailProduct">288,000원</b></div>
              <div><span>쿠폰 할인</span><b id="cartCouponDiscount">0원</b></div>
              <div><span>포인트 사용</span><b id="cartPointDiscount">0P</b></div>
              <div><span>배송비</span><b id="cartShippingFee">무료</b></div>
              <div><span>예상 적립 포인트</span><b id="cartExpectedPoint">2,880P</b></div>
            </div>
          </section>
          
          <div class="cart-bottom-actions">
            <button type="button" class="cart-continue-button" id="cartContinueShopping">
              계속 쇼핑하기
            </button>
            <button type="button" class="cart-order-button" id="cartCheckout">
              선택상품 주문하기
            </button>
            <button type="button" id="cartDeleteSelected">선택 삭제</button>
          </div>          
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
