<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="isMember" value="${not empty sessionScope.sessionInfo or param.preview eq 'member'}" />
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>구매 동의 | Yongsinsa</title>
    <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
    
    
  
    

    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/order/checkout.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/order/checkout-form.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/layout.css?v=20260806-0140" />
</head>
  <body
    class="pay-body has-site-layout"
    data-logged-in="${isMember}"
    data-preview-member="${param.preview eq 'member'}"
  >
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <section class="pay-subheader">
      <a class="pay-logo" href="${ctx}/index.jsp">Yongsinsa</a>
      <nav>
        <a href="${ctx}/mypage#cart">장바구니</a><span>›</span
        ><strong>구매 동의</strong><span>›</span><span>결제</span>
      </nav>
    </section>

    <main class="pay-shell pay-two-column">
      <section class="pay-main">
        <div class="pay-step" aria-label="결제 단계">
          <span class="active">1</span><i></i><span>2</span><i></i><span>3</span>
        </div>
        <p class="pay-eyebrow">STEP 01</p>
        <h1>주문 내용을 확인해 주세요</h1>
        <p class="pay-lead">상품 옵션과 구매 유형에 맞는 필수 약관을 확인합니다.</p>

        <div class="product-summary">
          <img
            src="${ctx}/dist/images/product-detail/main-shoe.png"
            alt="주문 상품"
          />
          <div>
            <span class="brand">ADIDAS</span>
            <h2 id="agreementProductName">아디다스 ZX 8000 그레이 투 퍼플</h2>
            <p>
              <span id="agreementColor">그레이 투 퍼플</span>
              <span class="summary-dot">·</span>
              <span id="agreementSize">260mm</span>
              <span class="summary-dot">·</span> 1개
            </p>
          </div>
        </div>

        <div class="agreement-context">
          <span class="agreement-type-tag">
            <c:choose>
              <c:when test="${isMember}">회원 구매</c:when>
              <c:otherwise>비회원 구매</c:otherwise>
            </c:choose>
          </span>
          <div>
            <strong>
              <c:choose>
                <c:when test="${isMember}">회원 주문으로 진행합니다.</c:when>
                <c:otherwise>비회원 주문으로 진행합니다.</c:otherwise>
              </c:choose>
            </strong>
            <p>
              <c:choose>
                <c:when test="${isMember}">주문 내역과 적립 내역은 마이페이지에서 확인할 수 있습니다.</c:when>
                <c:otherwise>주문 조회를 위해 주문번호와 주문 비밀번호가 필요합니다.</c:otherwise>
              </c:choose>
            </p>
          </div>
        </div>

        <section class="pay-card agreement-card">
          <label class="agree-all">
            <span>
              <strong>전체 동의</strong>
              <small>현재 구매에 필요한 필수 및 선택 항목에 모두 동의합니다.</small>
            </span>
            <input id="agreeAll" type="checkbox" />
          </label>
          <div class="line"></div>

          <p class="agreement-group-title">공통 구매 약관</p>
          <label>
            <span>
              <strong>[필수] 상품 및 옵션 확인</strong>
              <small>상품명, 색상, 사이즈, 수량과 결제 금액을 확인했습니다.</small>
            </span>
            <input class="required-agree" type="checkbox" />
          </label>
          <label>
            <span>
              <strong>[필수] 주문 및 배송 안내 확인</strong>
              <small>결제 완료 후 순차 배송되며, 재고 상황에 따라 출고가 지연될 수 있습니다.</small>
            </span>
            <input class="required-agree" type="checkbox" />
          </label>
          <label>
            <span>
              <strong>[필수] 교환·반품 정책 동의</strong>
              <small>수령 후 7일 이내 신청할 수 있으며 상품 훼손 시 제한될 수 있습니다.</small>
            </span>
            <input class="required-agree" type="checkbox" />
          </label>

          <c:choose>
            <c:when test="${isMember}">
              <p class="agreement-group-title">회원 구매 약관</p>
              <label>
                <span>
                  <strong>[필수] 회원 주문 및 적립 안내</strong>
                  <small>주문 내역은 회원 계정에 저장되며 구매 확정 후 포인트가 적립됩니다.</small>
                </span>
                <input class="required-agree" type="checkbox" />
              </label>
              <label>
                <span>
                  <strong>[선택] 상품·혜택 정보 수신 동의</strong>
                  <small>이벤트와 쿠폰 소식을 받을 수 있으며 동의하지 않아도 구매할 수 있습니다.</small>
                </span>
                <input class="optional-agree" type="checkbox" />
              </label>
            </c:when>
            <c:otherwise>
              <p class="agreement-group-title">비회원 구매 약관</p>
              <label>
                <span>
                  <strong>[필수] 비회원 구매 이용 동의</strong>
                  <small>회원 가입 없이 주문하며 회원 전용 적립과 일부 혜택은 제공되지 않습니다.</small>
                </span>
                <input class="required-agree" type="checkbox" />
              </label>
              <label>
                <span>
                  <strong>[필수] 개인정보 수집·이용 동의</strong>
                  <small>주문 처리와 배송, 고객 응대를 위해 이름·연락처·이메일·주소를 이용합니다.</small>
                </span>
                <input class="required-agree" type="checkbox" />
              </label>
              <label>
                <span>
                  <strong>[필수] 비회원 주문조회 안내 확인</strong>
                  <small>결제 단계에서 설정한 주문 비밀번호와 주문번호로 주문을 조회합니다.</small>
                </span>
                <input class="required-agree" type="checkbox" />
              </label>
              <label>
                <span>
                  <strong>[선택] 이벤트·상품 정보 수신 동의</strong>
                  <small>할인, 재입고, 이벤트 소식을 받을 수 있으며 동의하지 않아도 구매할 수 있습니다.</small>
                </span>
                <input class="optional-agree" type="checkbox" />
              </label>
            </c:otherwise>
          </c:choose>
        </section>

        <p id="agreementMessage" class="form-message" aria-live="polite"></p>
        <button id="agreementNext" class="pay-primary" type="button">
          동의하고 배송·결제 정보 입력하기
        </button>
      </section>

      <aside class="order-panel">
        <h2>최종 주문 정보</h2>
        <dl>
          <div>
            <dt>상품 금액</dt>
            <dd id="agreementProductPrice">130,000원</dd>
          </div>
          <div>
            <dt>배송비</dt>
            <dd>무료</dd>
          </div>
          <div>
            <dt>할인</dt>
            <dd>- 0원</dd>
          </div>
        </dl>
        <div class="order-total">
          <span>총 결제금액</span><strong id="agreementTotal">130,000원</strong>
        </div>
        <p class="member-reward-note">
          <c:choose>
            <c:when test="${isMember}">구매 확정 시 <b>1,300P</b> 적립 예정</c:when>
            <c:otherwise>비회원 주문은 포인트가 적립되지 않습니다.</c:otherwise>
          </c:choose>
        </p>
      </aside>
    </main>

    <script>
      window.paymentContextPath = "${ctx}";
    </script>
    
  
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    

    <script src="${pageContext.request.contextPath}/dist/js/pages/order/checkout.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
