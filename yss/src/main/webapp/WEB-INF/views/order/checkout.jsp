<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="isMember" value="${not empty sessionScope.sessionInfo or param.preview eq 'member'}" />
<c:set var="agreementQuery" value="${param.preview eq 'member' ? '?preview=member' : ''}" />
<c:set var="memberName" value="${not empty requestScope.memberName ? requestScope.memberName : (not empty sessionScope.memberName ? sessionScope.memberName : (param.preview eq 'member' ? '김용신' : ''))}" />
<c:set var="memberPhone" value="${not empty requestScope.memberPhone ? requestScope.memberPhone : (not empty sessionScope.memberPhone ? sessionScope.memberPhone : (param.preview eq 'member' ? '010-1234-5678' : ''))}" />
<c:set var="memberEmail" value="${not empty requestScope.memberEmail ? requestScope.memberEmail : (not empty sessionScope.memberEmail ? sessionScope.memberEmail : (param.preview eq 'member' ? 'member@yongsinsa.com' : ''))}" />
<c:set var="memberPostcode" value="${not empty requestScope.memberPostcode ? requestScope.memberPostcode : (not empty sessionScope.memberPostcode ? sessionScope.memberPostcode : (param.preview eq 'member' ? '06236' : ''))}" />
<c:set var="memberAddress" value="${not empty requestScope.memberAddress ? requestScope.memberAddress : (not empty sessionScope.memberAddress ? sessionScope.memberAddress : (param.preview eq 'member' ? '서울특별시 강남구 테헤란로 123' : ''))}" />
<c:set var="memberAddressDetail" value="${not empty requestScope.memberAddressDetail ? requestScope.memberAddressDetail : (not empty sessionScope.memberAddressDetail ? sessionScope.memberAddressDetail : (param.preview eq 'member' ? '101동 1001호' : ''))}" />
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>배송 및 결제 | Yongsinsa</title>
    <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
    
    
  
    

    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/order/checkout.css?v=20260806-0112" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/order/checkout-form.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/layout.css?v=20260806-0140" />
</head>
  <%--
    실제 로그인 연결 시 Controller에서 아래 값을 request 또는 session에 담습니다.
    주문자 정보는 자동 입력되고, 배송지는 사용자가 '기본배송지'를 누를 때 입력됩니다.
    memberName, memberPhone, memberEmail, memberPostcode, memberAddress, memberAddressDetail
  --%>
  <body
    class="pay-body has-site-layout"
    data-logged-in="${isMember}"
    data-preview-member="${param.preview eq 'member'}"
  >
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <section class="pay-subheader">
      <a class="pay-logo" href="${ctx}/index.jsp">Yongsinsa</a>
      <nav>
        <a href="${ctx}/order/agreement${agreementQuery}">구매 동의</a
        ><span>›</span><strong>배송 및 결제</strong><span>›</span><span>완료</span>
      </nav>
    </section>

    <main class="pay-shell pay-two-column">
      <form id="checkoutForm" class="pay-main" novalidate>
        <div class="pay-step" aria-label="결제 단계">
          <span class="done">✓</span><i></i><span class="active">2</span><i></i><span>3</span>
        </div>
        <p class="pay-eyebrow">STEP 02</p>
        <h1>배송 및 결제</h1>
        <p class="pay-lead">받는 분 정보와 결제 수단을 확인해 주세요.</p>

        <section class="pay-card">
          <div class="section-title">
            <h2>주문자 정보</h2>
            <span><b class="required-mark">*</b> 필수 입력</span>
          </div>
          <input type="hidden" name="orderType" value="${isMember ? 'member' : 'guest'}" />
          <div class="order-account-row">
            <div>
              <span id="orderTypeBadge" class="order-type-badge"></span>
              <p id="orderTypeGuide" class="field-guide"></p>
            </div>
            <span class="member-only account-prefill-label">회원 정보 자동 입력</span>
          </div>

          <div class="form-grid">
            <label>
              <span class="field-label">이름<b class="required-mark">*</b></span>
              <input
                name="buyerName"
                autocomplete="name"
                required
                value="<c:out value='${isMember ? memberName : ""}'/>"
                placeholder="이름 입력"
              />
            </label>
            <label>
              <span class="field-label">휴대폰 번호<b class="required-mark">*</b></span>
              <input
                name="buyerPhone"
                type="tel"
                autocomplete="tel"
                required
                value="<c:out value='${isMember ? memberPhone : ""}'/>"
                placeholder="010-0000-0000"
              />
            </label>
            <label class="wide">
              <span class="field-label">이메일<b class="required-mark">*</b></span>
              <input
                name="buyerEmail"
                type="email"
                autocomplete="email"
                required
                value="<c:out value='${isMember ? memberEmail : ""}'/>"
                placeholder="example@email.com"
              />
            </label>
            <label class="guest-only">
              <span class="field-label">주문 비밀번호<b class="required-mark">*</b></span>
              <input
                name="orderPassword"
                type="password"
                minlength="6"
                autocomplete="new-password"
                placeholder="영문/숫자 6자 이상"
              />
            </label>
            <label class="guest-only">
              <span class="field-label">주문 비밀번호 확인<b class="required-mark">*</b></span>
              <input
                name="orderPasswordConfirm"
                type="password"
                minlength="6"
                autocomplete="new-password"
                placeholder="비밀번호 다시 입력"
              />
            </label>
          </div>
        </section>

        <section class="pay-card">
          <div class="section-title address-section-title">
            <h2>배송지 정보</h2>
            <button
              class="default-address-link member-only"
              type="button"
              id="useDefaultAddress"
              data-name="<c:out value='${memberName}'/>"
              data-phone="<c:out value='${memberPhone}'/>"
              data-postcode="<c:out value='${memberPostcode}'/>"
              data-address="<c:out value='${memberAddress}'/>"
              data-address-detail="<c:out value='${memberAddressDetail}'/>"
            >기본배송지</button>
          </div>
          <p id="defaultAddressMessage" class="default-address-message member-only" aria-live="polite"></p>

          <div class="form-grid">
            <label>
              <span class="field-label">받는 분<b class="required-mark">*</b></span>
              <input
                name="receiverName"
                autocomplete="name"
                required
                value="<c:out value='${isMember ? memberName : ""}'/>"
                placeholder="이름 입력"
              />
            </label>
            <label>
              <span class="field-label">연락처<b class="required-mark">*</b></span>
              <input
                name="receiverPhone"
                type="tel"
                autocomplete="tel"
                required
                value="<c:out value='${isMember ? memberPhone : ""}'/>"
                placeholder="010-0000-0000"
              />
            </label>
            <label>
              <span class="field-label">우편번호<b class="required-mark">*</b></span>
              <div class="inline-field">
                <input
                  name="postcode"
                  required
                  readonly
                  value=""
                  placeholder="주소 찾기를 눌러주세요"
                />
                <button type="button" id="postcodeButton">주소 찾기</button>
              </div>
            </label>
            <label class="wide">
              <span class="field-label">기본 주소<b class="required-mark">*</b></span>
              <input
                name="address"
                required
                readonly
                value=""
                placeholder="주소 검색 결과가 입력됩니다"
              />
            </label>
            <label class="wide">
              <span class="field-label">상세 주소<b class="required-mark">*</b></span>
              <input
                name="addressDetail"
                required
                autocomplete="address-line2"
                value=""
                placeholder="동·호수 등 상세 주소"
              />
            </label>
            <label class="wide">
              <span class="field-label">배송 요청사항<span class="optional-mark">선택</span></span>
              <select name="request">
                <option value="">배송 요청사항 없음</option>
                <option>문 앞에 놓아주세요</option>
                <option>경비실에 맡겨주세요</option>
                <option>배송 전 연락해주세요</option>
              </select>
            </label>
          </div>
        </section>

        <section class="pay-card member-only">
          <div class="section-title">
            <h2>포인트 및 쿠폰</h2>
            <span>보유 12,400P</span>
          </div>
          <div class="discount-row">
            <input
              id="pointInput"
              type="number"
              min="0"
              max="12400"
              step="100"
              value="0"
              aria-label="사용 포인트"
            />
            <button id="maxPoint" type="button">최대 사용</button>
          </div>
          <small class="field-guide">포인트는 100P 단위로 사용할 수 있습니다.</small>
          <div class="discount-row">
            <input id="couponInput" placeholder="쿠폰 코드를 입력하세요" />
            <button id="applyCoupon" type="button">쿠폰 적용</button>
          </div>
          <p id="discountMessage" class="form-message" aria-live="polite"></p>
        </section>

        <section class="pay-card guest-only-card">
          <div class="section-title">
            <h2>쿠폰</h2>
            <span>비회원 주문</span>
          </div>
          <div class="discount-row">
            <input id="guestCouponInput" placeholder="쿠폰 코드를 입력하세요" />
            <button id="guestApplyCoupon" type="button">쿠폰 적용</button>
          </div>
          <small class="field-guide">비회원 주문은 포인트 사용과 적립이 제공되지 않습니다.</small>
          <p id="guestDiscountMessage" class="form-message" aria-live="polite"></p>
        </section>

        <section class="pay-card">
          <h2>결제 수단</h2>
          <div class="payment-options">
            <label>
              <input type="radio" name="paymentMethod" value="신용카드" checked />
              <span><b>신용카드</b><small>일시불·할부</small></span>
            </label>
            <label>
              <input type="radio" name="paymentMethod" value="무통장입금" />
              <span><b>무통장입금</b><small>입금 확인 후 진행</small></span>
            </label>
            <label>
              <input type="radio" name="paymentMethod" value="간편결제" />
              <span><b>간편결제</b><small>회원 등록 카드</small></span>
            </label>
          </div>

          <div id="cardFields" class="payment-detail form-grid card-fields">
            <p class="payment-detail-title wide">카드 정보를 입력해 주세요.</p>
            <label class="wide">
              <span class="field-label">카드번호<b class="required-mark">*</b></span>
              <input
                name="cardNumber"
                type="text"
                inputmode="numeric"
                maxlength="25"
                pattern="[0-9]{4} - [0-9]{4} - [0-9]{4} - [0-9]{4}"
                required
                placeholder="0000 - 0000 - 0000 - 0000"
              />
            </label>
            <label>
              <span class="field-label">유효기간<b class="required-mark">*</b></span>
              <input
                name="cardExpiry"
                type="text"
                inputmode="numeric"
                maxlength="7"
                pattern="[0-9]{2} / [0-9]{2}"
                required
                placeholder="MM / YY"
              />
            </label>
            <label>
              <span class="field-label">생년월일<b class="required-mark">*</b></span>
              <input
                name="cardBirth"
                type="text"
                inputmode="numeric"
                maxlength="6"
                pattern="[0-9]{6}"
                required
                placeholder="YYMMDD"
              />
            </label>
          </div>

          <div id="bankFields" class="payment-detail" hidden>
            <p class="payment-detail-title">입금할 은행을 하나 선택해 주세요.<b class="required-mark">*</b></p>
            <div class="bank-options">
              <label><input type="radio" name="depositBank" value="KB국민은행" /><span>KB국민은행<small>123-456-789012</small></span></label>
              <label><input type="radio" name="depositBank" value="신한은행" /><span>신한은행<small>110-123-456789</small></span></label>
              <label><input type="radio" name="depositBank" value="우리은행" /><span>우리은행<small>1002-123-456789</small></span></label>
              <label><input type="radio" name="depositBank" value="하나은행" /><span>하나은행<small>123-910012-34567</small></span></label>
              <label><input type="radio" name="depositBank" value="NH농협은행" /><span>NH농협은행<small>301-1234-5678-91</small></span></label>
            </div>
            <p class="payment-tip">주문 후 24시간 안에 입금해 주세요. 입금자명은 주문자 이름과 같아야 합니다.</p>
          </div>

          <div id="easyPayFields" class="payment-detail" hidden>
            <div class="member-easy-pay">
              <p class="payment-detail-title">등록된 결제카드</p>
              <div class="saved-card-options">
                <label><input type="radio" name="savedCard" value="신한카드 4821" /><span><b>신한카드</b><small>•••• 4821 · 개인카드</small></span></label>
                <label><input type="radio" name="savedCard" value="KB국민카드 1937" /><span><b>KB국민카드</b><small>•••• 1937 · 개인카드</small></span></label>
              </div>
              <a class="manage-card-link" href="${ctx}/mypage">+ 마이페이지에서 결제카드 관리</a>
            </div>
            <div class="guest-easy-pay">
              <b>간편결제는 회원만 사용할 수 있습니다.</b>
              <p>신용카드 또는 무통장입금을 선택해 주세요.</p>
            </div>
          </div>
        </section>

        <p id="checkoutMessage" class="form-message" aria-live="polite"></p>
        <button class="pay-primary" type="submit">
          <span id="payButtonPrice">130,000원</span> 결제하기
        </button>
      </form>

      <aside class="order-panel">
        <h2>주문 상품</h2>
        <div class="mini-product">
          <img src="${ctx}/dist/images/product-detail/main-shoe.png" alt="주문 상품" />
          <div>
            <b id="checkoutProductName">아디다스 ZX 8000 그레이 투 퍼플</b>
            <span id="checkoutProductOption">그레이 투 퍼플 · 260mm · 1개</span>
          </div>
        </div>
        <dl>
          <div>
            <dt>상품 금액</dt>
            <dd id="checkoutProductPrice">130,000원</dd>
          </div>
          <div>
            <dt>배송비</dt>
            <dd id="shippingAmount">무료</dd>
          </div>
          <div>
            <dt>할인</dt>
            <dd id="discountAmount">- 0원</dd>
          </div>
        </dl>
        <div class="order-total">
          <span>총 결제금액</span><strong id="finalPrice">130,000원</strong>
        </div>
        <p class="member-only">구매 확정 시 <b id="expectedPoint">1,300P</b> 적립 예정</p>
        <p class="guest-only-card">비회원 주문은 포인트가 적립되지 않습니다.</p>
      </aside>
    </main>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
      window.paymentContextPath = "${ctx}";
    </script>
    
  
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    

    <script src="${pageContext.request.contextPath}/dist/js/pages/order/checkout.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
