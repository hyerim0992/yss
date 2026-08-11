<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>주문 완료 | Yongsinsa</title>
    <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
    
    
  
    

    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/order/checkout.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/order/checkout-form.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/layout.css?v=20260806-0140" />
</head>
  <body class="pay-body has-site-layout">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <section class="pay-subheader">
      <a class="pay-logo" href="${ctx}/index.jsp">Yongsinsa</a>
      <nav>
        <span>구매 동의</span><span>›</span><span>배송 및 결제</span><span>›</span><strong>완료</strong>
      </nav>
    </section>

    <main class="complete-shell complete-shell-refined">
      <div class="pay-step" aria-label="결제 단계">
        <span class="done">✓</span><i></i><span class="done">✓</span><i></i><span class="done">✓</span>
      </div>

      <section class="complete-heading">
        <div class="complete-icon compact">✓</div>
        <div>
          <p class="pay-eyebrow">주문 완료</p>
          <h1>주문이 완료되었습니다.</h1>
          <p id="completeGuide" class="pay-lead">결제와 주문 접수가 정상적으로 처리되었습니다.</p>
        </div>
      </section>

      <section class="order-number-bar" aria-label="주문번호">
        <span>주문번호</span>
        <strong id="orderNumber">A0000001</strong>
        <button id="copyOrderNumber" type="button">복사</button>
      </section>

      <section class="pay-card complete-card refined-card">
        <div class="mini-product complete-product">
          <img src="${ctx}/dist/images/product-detail/main-shoe.png" alt="주문 상품" />
          <div>
            <span class="brand">ADIDAS</span>
            <b id="completeProductName">아디다스 ZX 8000 그레이 투 퍼플</b>
            <span id="completeProductOption">그레이 투 퍼플 · 260mm · 1개</span>
          </div>
          <strong id="completeProductPrice">130,000원</strong>
        </div>

        <dl class="complete-info-grid">
          <div>
            <dt>결제 수단</dt>
            <dd id="completeMethod">신용카드</dd>
          </div>
          <div>
            <dt>받는 분</dt>
            <dd id="completeReceiver">주문자</dd>
          </div>
          <div class="wide">
            <dt>배송지</dt>
            <dd id="completeAddress">입력한 배송지</dd>
          </div>
        </dl>

        <div class="order-total complete-total">
          <span>총 결제금액</span><strong id="completePrice">130,000원</strong>
        </div>
      </section>

      <div id="guestOrderNotice" class="order-lookup-note" hidden>
        <div>
          <b>비회원 주문조회</b>
          <p>주문번호와 결제할 때 설정한 주문 비밀번호를 사용합니다.</p>
        </div>
        <a href="${ctx}/member/login#guest-order">주문 조회</a>
      </div>

      <div class="complete-actions refined-actions">
        <a class="pay-secondary" href="${ctx}/index.jsp">쇼핑 계속하기</a>
        <a id="orderHistoryLink" class="pay-primary link-button" href="${ctx}/mypage">주문 내역 보기</a>
      </div>

      <p class="complete-help">주문 관련 문의는 고객센터의 1:1 문의에서 접수할 수 있습니다.</p>
    </main>

    <script>
      window.paymentContextPath = "${ctx}";
    </script>
    
  
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    

    <script src="${pageContext.request.contextPath}/dist/js/pages/order/checkout.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
