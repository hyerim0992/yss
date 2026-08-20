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



    <div class="mobile-my-nav">
      <button type="button" id="sidebarToggle">☰ 마이페이지 메뉴</button>
    </div>

    <main class="my-layout">
      <aside class="my-sidebar" id="mySidebar">
        <a class="sidebar-title" href="#home" data-view="home">마이페이지</a>

        <section class="sidebar-group">
          <h2>쇼핑 관리</h2>
          <a href="#purchase" data-view="purchase">구매내역</a>
          <a href="#wishlist" data-view="wishlist">위시리스트</a>
          <a href="#cart" data-view="cart">장바구니</a>
          <a href="#shipping" data-view="shipping">배송 조회</a>
          <a href="#reviews" data-view="reviews">내가 쓴 리뷰</a>
        </section>

        <section class="sidebar-group">
          <h2>혜택 관리</h2>
          <a href="#point" data-view="point">포인트</a>
          <a href="#coupon" data-view="coupon">쿠폰</a>
        </section>

        <section class="sidebar-group">
          <h2>내 정보</h2>
          <a href="#profile" data-view="profile" data-protected="true"
            >회원정보 관리</a
          >
          <a href="#password" data-view="password" data-protected="true"
            >비밀번호 변경</a
          >
          <a href="#address" data-view="address">배송지 관리</a>
          <a href="#account" data-view="account">환불 입금 계좌</a>
        </section>

        <section class="sidebar-group">
          <h2>고객지원</h2>
          <a href="#inquiry" data-view="inquiry">1:1 문의 / 문의내역</a>
          <a href="#faq" data-view="faq">자주하는 질문</a>
        </section>
      </aside>

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

          <div class="quick-grid">
            <button data-view="wishlist">
              <span class="quick-icon">♡</span>
              <span class="quick-copy"><b>위시리스트</b><small>관심 상품 4개</small></span>
              <span class="quick-arrow">›</span>
            </button>
            <button data-view="address">
              <span class="quick-icon">⌂</span>
              <span class="quick-copy"><b>배송지 관리</b><small>기본 배송지 확인</small></span>
              <span class="quick-arrow">›</span>
            </button>
            <button data-view="cart">
              <span class="quick-icon">▣</span>
              <span class="quick-copy"><b>장바구니</b><small>선택 상품과 결제금액 확인</small></span>
              <span class="quick-arrow">›</span>
            </button>
            <button data-view="inquiry">
              <span class="quick-icon">?</span>
              <span class="quick-copy"><b>1:1 문의</b><small>빠른 상담 접수</small></span>
              <span class="quick-arrow">›</span>
            </button>
          </div>
        </section>

        <!-- 구매내역 -->
        <section class="page-view" data-page="purchase">
          <div class="page-title">
            <div>
              <span class="eyebrow blue">BUYING</span>
              <h1>구매내역</h1>
              <p>주문부터 배송 완료까지 구매 진행 상황을 확인해 보세요.</p>
            </div>
          </div>
          <div class="filter-card">
            <div class="chip-row" data-filter-group="purchaseStatus">
              <button class="chip is-active" data-filter="all">전체 11</button
              ><button class="chip" data-filter="paid">결제 완료 2</button
              ><button class="chip" data-filter="shipping">배송 중 1</button
              ><button class="chip" data-filter="complete">구매 완료 8</button>
            </div>
            <div class="period-row">
              <button class="period is-active">최근 1개월</button
              ><button class="period">3개월</button
              ><button class="period">6개월</button
              ><input type="date" value="2026-07-04" /><span>~</span
              ><input type="date" value="2026-08-04" /><button
                class="dark-button"
                data-action="filter"
              >
                조회
              </button>
            </div>
          </div>
          <div class="list-head">
            <span>상품 정보</span><span>구매 금액</span><span>진행 상태</span
            ><span>관리</span>
          </div>
          <div class="transaction-list">
            <article class="transaction-item" data-status="shipping">
              <div class="shoe-thumb">NB</div>
              <div>
                <small>2026.08.01 · YS260801-0148</small>
                <h3>New Balance 993 Made in USA Grey</h3>
                <p>260mm · 일반 주문</p>
              </div>
              <strong>289,000원</strong
              ><span class="state blue-state">배송 중</span>
              <div class="row-actions">
                <button data-action="detail">상세보기</button
                ><button data-view="shipping">배송조회</button>
              </div>
            </article>
            <article class="transaction-item" data-status="complete">
              <div class="shoe-thumb cream">NK</div>
              <div>
                <small>2026.07.18 · YS260718-0092</small>
                <h3>Nike Air Force 1 '07 White</h3>
                <p>265mm · 일반 주문</p>
              </div>
              <strong>139,000원</strong><span class="state">구매 완료</span>
              <div class="row-actions">
                <button data-action="detail">상세보기</button
                ><button data-action="review">리뷰 작성</button>
              </div>
            </article>
            <article class="transaction-item" data-status="paid">
              <div class="shoe-thumb dark">AD</div>
              <div>
                <small>2026.08.03 · YS260803-0214</small>
                <h3>Adidas Samba OG Core Black</h3>
                <p>255mm · 일반 주문</p>
              </div>
              <strong>149,000원</strong
              ><span class="state coral-state">결제 완료</span>
              <div class="row-actions">
                <button data-action="detail">상세보기</button>
                <button data-action="order-cancel">주문 취소</button>
              </div>
            </article>
          </div>
          <div class="after-service">
            <h2>구매 후 서비스</h2>
            <button data-action="purchase-confirm">구매 확정</button
            ><button data-action="exchange">교환 신청</button
            ><button data-action="return">반품 신청</button
            ><button data-action="refund">환불 신청</button
            ><button data-action="review">리뷰 작성</button>
          </div>
        </section>

        <!-- 위시리스트 -->        <!-- 위시리스트 -->
        <jsp:include page="/WEB-INF/views/mypage/wishlist.jsp" />

        <!-- 장바구니 -->
        <section class="page-view" data-page="cart">
          <div class="page-title cart-page-title">
            <div>
              <span class="eyebrow blue">SHOPPING CART</span>
              <h1>장바구니</h1>
              <p>상품 옵션과 수량을 확인하고 쿠폰·포인트 적용 금액을 미리 계산할 수 있어요.</p>
            </div>
          </div>

          <div class="cart-toolbar">
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
            <button type="button" id="cartDeleteSelected">선택 삭제</button>
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
          </div>
        </section>

        <!-- 내가 쓴 리뷰 -->
        <section class="page-view" data-page="reviews">
          <div class="page-title">
            <div>
              <span class="eyebrow blue">MY REVIEWS</span>
              <h1>내가 쓴 리뷰 관리</h1>
              <p>작성한 리뷰를 확인하고 수정하거나 삭제할 수 있어요.</p>
            </div>
          </div>
          <div class="review-list">
            <article class="review-item">
              <div class="shoe-thumb cream">NK</div>
              <div class="review-content">
                <small>Nike Air Force 1 '07 White · 2026.07.22</small>
                <h3>★★★★★ <span>착화감이 편하고 사이즈도 잘 맞아요.</span></h3>
                <p>배송이 빨랐고 실제 색상이 사진과 같아서 만족합니다.</p>
              </div>
              <div class="row-actions">
                <button type="button" data-action="review-edit">수정</button>
                <button type="button" data-action="remove-review">삭제</button>
              </div>
            </article>
            <article class="review-item">
              <div class="shoe-thumb">NB</div>
              <div class="review-content">
                <small>New Balance 993 Made in USA Grey · 2026.07.05</small>
                <h3>★★★★☆ <span>오래 걸어도 편안합니다.</span></h3>
                <p>정사이즈로 주문했고 쿠션감이 좋습니다.</p>
              </div>
              <div class="row-actions">
                <button type="button" data-action="review-edit">수정</button>
                <button type="button" data-action="remove-review">삭제</button>
              </div>
            </article>
          </div>
        </section>

        <!-- 포인트 -->
        <section class="page-view" data-page="point">
          <div class="page-title">
            <div>
              <span class="eyebrow blue">BENEFIT</span>
              <h1>포인트</h1>
            </div>
          </div>
          <div class="benefit-hero">
            <span>사용 가능한 포인트</span><strong>12,500 P</strong
            ><small>30일 이내 소멸 예정 1,000 P</small>
          </div>
          <div class="tab-bar" data-tab-group="point">
            <button class="is-active" data-tab="earn">적립내역</button
            ><button data-tab="use">사용내역</button>
          </div>
          <div class="history-list" data-tab-panel="earn">
            <div>
              <span
                ><b>구매 확정 적립</b
                ><small>2026.07.20 · Nike Air Force 1</small></span
              ><strong class="plus">+2,780 P</strong>
            </div>
            <div>
              <span
                ><b>신규 회원 웰컴 포인트</b
                ><small>2026.07.01 · 유효기간 90일</small></span
              ><strong class="plus">+10,000 P</strong>
            </div>
          </div>
          <div class="history-list is-hidden" data-tab-panel="use">
            <div>
              <span
                ><b>상품 구매 사용</b
                ><small>2026.07.18 · YS260718-0092</small></span
              ><strong>-280 P</strong>
            </div>
          </div>
        </section>

        <!-- 쿠폰 -->
        <section class="page-view" data-page="coupon">
          <div class="page-title">
            <div>
              <span class="eyebrow blue">BENEFIT</span>
              <h1>쿠폰</h1>
              <p>보유 쿠폰을 확인하고 상품 구매 시 사용해 보세요.</p>
            </div>
            <button class="outline-button" data-action="coupon-register">
              + 쿠폰 등록
            </button>
          </div>
          <div class="coupon-grid">
            <article>
              <span>WELCOME</span><strong>10,000원</strong
              ><b>신규 회원 첫 구매 쿠폰</b
              ><small>100,000원 이상 구매 시 · 2026.08.31까지</small>
            </article>
            <article>
              <span>SHIPPING</span><strong>무료배송</strong
              ><b>8월 배송비 지원 쿠폰</b
              ><small>50,000원 이상 구매 시 · 2026.08.20까지</small>
            </article>
            <article>
              <span>BRAND</span><strong>5%</strong><b>New Balance 브랜드 쿠폰</b
              ><small>최대 20,000원 할인 · 2026.09.10까지</small>
            </article>
          </div>
        </section>

        <!-- 개인정보 -->
        <section class="page-view" data-page="profile">
          <div class="page-title">
            <div>
              <span class="eyebrow">SECURE AREA</span>
              <h1>회원정보 관리</h1>
              <p>비밀번호, 연락처, 주소, 이메일과 관심사를 수정할 수 있어요.</p>
            </div>
          </div>
          <form class="profile-form demo-form" id="profileForm">
            <div class="profile-avatar">
              <div class="avatar">Y</div>
              <button type="button" data-action="photo">사진 변경</button>
            </div>
            <div class="form-grid">
              <label>아이디<input value="kcco100" disabled /></label
              ><label>이름<input value="김민혁" /></label
              ><label
                >이메일<input type="email" value="kcco100@kakao.com" /></label
              ><label>연락처<input value="010-1234-5678" /></label>
              <fieldset class="full profile-address-fields">
                <legend>주소</legend>
                <div class="profile-postcode-row">
                  <label
                    >우편번호<input
                      id="profilePostcode"
                      name="postcode"
                      value="04048"
                      placeholder="우편번호"
                      readonly
                      required
                  /></label>
                  <button
                    type="button"
                    class="profile-address-search"
                    data-action="postcode"
                    data-postcode-target="profilePostcode"
                    data-address-target="profileAddress"
                    data-detail-target="profileAddressDetail"
                  >
                    주소 검색
                  </button>
                </div>
                <label
                  >기본 주소<input
                    id="profileAddress"
                    name="address"
                    value="서울 마포구 서교동 447-5"
                    placeholder="주소 검색 버튼을 눌러 주세요"
                    readonly
                    required
                /></label>
                <label
                  >상세 주소<input
                    id="profileAddressDetail"
                    name="addressDetail"
                    value="301호"
                    placeholder="상세 주소를 입력해 주세요"
                    required
                /></label>
                <small class="profile-address-help"
                  >주소 검색 후 상세 주소를 입력하고 회원정보 저장을 눌러 주세요.</small
                >
              </fieldset>
              <fieldset class="full">
                <legend>관심사</legend>
                <label><input type="checkbox" checked /> 한정판 스니커즈</label
                ><label><input type="checkbox" checked /> 러닝화</label
                ><label><input type="checkbox" /> 스트릿 패션</label
                ><label><input type="checkbox" /> 키즈</label>
              </fieldset>
            </div>
            <div class="form-submit">
              <button class="primary-button" type="submit">
                회원정보 저장
              </button>
            </div>
          </form>
        </section>

        <!-- 비밀번호 -->
        <section class="page-view" data-page="password">
          <div class="page-title">
            <div>
              <span class="eyebrow">SECURE AREA</span>
              <h1>비밀번호 변경</h1>
              <p>
                다른 사이트에서 사용하지 않는 안전한 비밀번호를 사용해 주세요.
              </p>
            </div>
          </div>
          <form class="narrow-form demo-form">
            <label>현재 비밀번호<input type="password" required /></label
            ><label
              >새 비밀번호<input
                type="password"
                minlength="8"
                required
                placeholder="영문·숫자·특수문자 포함 8자 이상" /></label
            ><label
              >새 비밀번호 확인<input
                type="password"
                minlength="8"
                required /></label
            ><button class="primary-button" type="submit">비밀번호 변경</button>
          </form>
        </section>

        <!-- 배송지 -->
        <section class="page-view" data-page="address">
          <div class="page-title">
            <div>
              <span class="eyebrow">DELIVERY</span>
              <h1>배송지 관리</h1>
              <p>
                기본주소와 우편번호를 확인하고 배송지를 추가·수정·삭제할 수
                있어요.
              </p>
            </div>
            <button class="primary-button" data-modal="addressModal">
              + 배송지 추가
            </button>
          </div>
          <div class="address-list">
            <article>
              <span class="default-badge">기본 배송지</span>
              <h3>우리집</h3>
              <b>김민혁 · 010-1234-5678</b>
              <p>(04048) 서울 마포구 서교동 447-5, 301호</p>
              <div>
                <button data-modal="addressModal">수정</button
                ><button data-action="delete">삭제</button>
              </div>
            </article>
            <article>
              <h3>학원</h3>
              <b>김민혁 · 010-1234-5678</b>
              <p>(06134) 서울 강남구 테헤란로 123, 5층</p>
              <div>
                <button data-action="default-address">기본 배송지 설정</button
                ><button data-modal="addressModal">수정</button
                ><button data-action="delete">삭제</button>
              </div>
            </article>
          </div>
        </section>

        <!-- 계좌 -->
        <section class="page-view" data-page="account">
          <div class="page-title">
            <div>
              <span class="eyebrow">REFUND ACCOUNT</span>
              <h1>환불 입금 계좌 관리</h1>
              <p>반품·취소 환불금을 받을 본인 명의 계좌를 관리해 주세요.</p>
            </div>
            <button class="primary-button" data-modal="accountModal">
              + 계좌 등록
            </button>
          </div>
          <div class="account-card">
            <div class="bank-logo">KB</div>
            <div>
              <span class="default-badge">기본 환불 입금 계좌</span>
              <h3>KB국민은행 123456-78-******</h3>
              <p>예금주 김민혁</p>
            </div>
            <div>
              <button data-modal="accountModal">수정</button
              ><button data-action="delete">삭제</button>
            </div>
          </div>
          <div class="notice-box">
            본인 명의 계좌만 등록할 수 있으며, 환불 처리 중에는 계좌를 삭제할 수 없습니다.
          </div>
        </section>

        <!-- 문의 -->
        <section class="page-view" data-page="inquiry">
          <div class="page-title">
            <div>
              <span class="eyebrow">HELP CENTER</span>
              <h1>1:1 문의</h1>
              <p>궁금한 점을 남기면 담당자가 확인 후 답변해 드려요.</p>
            </div>
            <button class="primary-button" data-modal="inquiryModal">
              + 문의하기
            </button>
          </div>
          <div class="tab-bar" data-tab-group="inquiry">
            <button class="is-active" data-tab="all">문의내역 전체</button
            ><button data-tab="waiting">답변 대기</button
            ><button data-tab="done">답변 완료</button>
          </div>
          <div class="inquiry-list">
            <button class="accordion">
              <span
                ><b class="state blue-state">답변 완료</b
                ><strong>배송 완료로 표시되는데 상품을 받지 못했어요.</strong
                ><small>배송 · 2026.08.02</small></span
              ><i>⌄</i>
            </button>
            <div class="accordion-panel">
              <p>
                <b>문의:</b> 배송조회에는 완료라고 나오는데 현관 앞에 상품이
                없습니다.
              </p>
              <p><b>답변:</b> 택배사 확인 후 등록된 연락처로 안내드렸습니다.</p>
            </div>
            <button class="accordion">
              <span
                ><b class="state coral-state">답변 대기</b
                ><strong>반품 접수 후 환불은 언제 완료되나요?</strong
                ><small>교환·반품 · 2026.08.04</small></span
              ><i>⌄</i>
            </button>
            <div class="accordion-panel">
              <p>회수 상품 확인이 끝나면 결제수단 또는 등록된 환불 계좌로 순차 환불됩니다.</p>
            </div>
          </div>
        </section>

        <!-- FAQ -->
        <section class="page-view" data-page="faq">
          <div class="page-title">
            <div>
              <span class="eyebrow">FAQ</span>
              <h1>자주하는 질문</h1>
            </div>
          </div>
          <div class="faq-search">
            <input id="mypageFaqSearchInput" type="search" placeholder="궁금한 내용을 검색하세요" />
            <button id="mypageFaqSearchButton" type="button">검색</button>
          </div>
          <div class="category-pills" id="mypageFaqCategories" aria-label="자주하는 질문 분류">
            <button type="button" class="is-active" data-faq-category="전체">전체</button><button type="button" data-faq-category="주문">주문</button><button type="button" data-faq-category="배송">배송</button><button type="button" data-faq-category="교환·반품">교환·반품</button><button type="button" data-faq-category="환불">환불</button>
          </div>
          <div class="inquiry-list faq-list" id="mypageFaqList">
            <button class="accordion" type="button" data-faq-item data-category="배송">
              <span><em>Q</em><strong>주문한 상품의 배송 현황은 어디에서 확인하나요?</strong></span><i>⌄</i>
            </button>
            <div class="accordion-panel" data-faq-panel>구매내역의 배송조회 버튼에서 운송장번호와 현재 배송 단계를 확인할 수 있습니다.</div>
            <button class="accordion" type="button" data-faq-item data-category="주문">
              <span><em>Q</em><strong>구매 확정 후 리뷰는 어떻게 작성하나요?</strong></span><i>⌄</i>
            </button>
            <div class="accordion-panel" data-faq-panel>배송 완료된 구매내역에서 구매 확정 후 리뷰 작성 버튼을 이용할 수 있습니다.</div>
            <button class="accordion" type="button" data-faq-item data-category="배송">
              <span><em>Q</em><strong>배송지를 변경할 수 있나요?</strong></span><i>⌄</i>
            </button>
            <div class="accordion-panel" data-faq-panel>배송 준비 전에는 변경할 수 있지만 배송이 시작된 뒤에는 변경이 어렵습니다.</div>
            <p class="faq-empty-message" id="mypageFaqEmptyMessage" hidden>해당 조건에 맞는 질문이 없습니다.</p>
          </div>
        </section>

        <!-- 배송조회 -->        <!-- 배송조회 -->
        <section class="page-view" data-page="shipping">
          <div class="page-title">
            <div>
              <span class="eyebrow blue">DELIVERY</span>
              <h1>배송 조회</h1>
              <p>상품의 현재 배송 단계와 배송 상세를 확인해 보세요.</p>
            </div>
          </div>
          <div class="shipping-summary">
            <div class="shoe-thumb">NB</div>
            <div>
              <small>주문번호 YS260801-0148</small>
              <h3>New Balance 993 Made in USA Grey</h3>
              <p>
                CJ대한통운 · 5890-1234-5678
                <button data-action="copy">복사</button>
              </p>
            </div>
            <span class="state blue-state">배송 중</span>
          </div>
          <ol class="delivery-timeline">
            <li class="is-done">
              <b>1</b>
              <div>
                <strong>결제 완료</strong><small>2026.08.01 10:24</small>
              </div>
            </li>
            <li class="is-done">
              <b>2</b>
              <div>
                <strong>상품 준비 완료</strong><small>2026.08.02 16:40</small>
              </div>
            </li>
            <li class="is-done">
              <b>3</b>
              <div>
                <strong>배송 시작</strong
                ><small>2026.08.03 09:15 · 마포Sub</small>
              </div>
            </li>
            <li class="is-current">
              <b>4</b>
              <div>
                <strong>배송 중</strong
                ><small>2026.08.04 07:32 · 고객님의 지역으로 이동 중</small>
              </div>
            </li>
            <li>
              <b>5</b>
              <div>
                <strong>배송 완료</strong><small>도착 예정 2026.08.04</small>
              </div>
            </li>
          </ol>
          <div class="shipping-address">
            <span>받는 주소</span><b>김민혁 · 010-1234-5678</b>
            <p>서울 마포구 서교동 447-5, 301호</p>
          </div>
        </section>
      </div>
    </main>



    <!-- 장바구니 옵션 변경 -->
    <div class="modal cart-option-modal" id="cartOptionModal" aria-hidden="true">
      <div class="modal-backdrop" data-close-modal></div>
      <div class="modal-dialog cart-option-dialog" role="dialog" aria-modal="true" aria-labelledby="cartOptionTitle">
        <button type="button" class="modal-close" data-close-modal aria-label="닫기">×</button>
        <span class="eyebrow blue">OPTION</span>
        <h2 id="cartOptionTitle">옵션 변경</h2>
        <div class="cart-modal-product">
          <div class="shoe-thumb" id="cartOptionThumb">AD</div>
          <div>
            <small id="cartOptionBrand">Adidas</small>
            <strong id="cartOptionProductName">Samba OG Core Black</strong>
            <p id="cartOptionCurrent">블랙 · 255mm</p>
          </div>
        </div>
        <label class="cart-modal-field">
          <span>사이즈</span>
          <select id="cartOptionSize">
            <option value="230">230mm</option>
            <option value="235">235mm</option>
            <option value="240">240mm</option>
            <option value="245">245mm</option>
            <option value="250">250mm</option>
            <option value="255">255mm</option>
            <option value="260">260mm</option>
            <option value="265">265mm</option>
            <option value="270">270mm</option>
            <option value="275">275mm</option>
            <option value="280">280mm</option>
          </select>
        </label>
        <button type="button" class="primary-button cart-modal-submit" id="cartOptionApply">변경하기</button>
      </div>
    </div>

    <!-- 장바구니 쿠폰·포인트 적용 -->
    <div class="modal cart-benefit-modal" id="cartBenefitModal" aria-hidden="true">
      <div class="modal-backdrop" data-close-modal></div>
      <div class="modal-dialog cart-benefit-dialog" role="dialog" aria-modal="true" aria-labelledby="cartBenefitTitle">
        <button type="button" class="modal-close" data-close-modal aria-label="닫기">×</button>
        <span class="eyebrow blue">BENEFIT</span>
        <h2 id="cartBenefitTitle">쿠폰·포인트 적용</h2>
        <p>선택한 상품의 결제 예정 금액에 적용됩니다.</p>

        <div class="cart-benefit-section">
          <div class="cart-modal-field cart-coupon-field">
            <span>보유 쿠폰</span>

            <!-- 공통 nice-select 플러그인과 충돌하지 않는 장바구니 전용 드롭다운 -->
            <div class="cart-coupon-dropdown" id="cartCouponDropdown">
              <input type="hidden" id="cartCouponSelect" value="none" />
              <button
                type="button"
                class="cart-coupon-dropdown-toggle"
                id="cartCouponDropdownToggle"
                aria-haspopup="listbox"
                aria-expanded="false"
                aria-controls="cartCouponDropdownMenu"
              >
                <span id="cartCouponCurrentText">쿠폰을 적용하지 않음</span>
                <span class="cart-coupon-dropdown-arrow" aria-hidden="true"></span>
              </button>

              <div
                class="cart-coupon-dropdown-menu"
                id="cartCouponDropdownMenu"
                role="listbox"
                aria-label="보유 쿠폰"
                hidden
              >
                <button type="button" role="option" class="cart-coupon-option is-selected" data-coupon-code="none" aria-selected="true">
                  <strong>쿠폰을 적용하지 않음</strong>
                  <small>쿠폰 할인 없이 결제합니다.</small>
                </button>
                <button type="button" role="option" class="cart-coupon-option" data-coupon-code="welcome5" aria-selected="false">
                  <strong>신규 회원 5,000원 할인 쿠폰</strong>
                  <small>선택 상품 금액에서 5,000원 할인</small>
                </button>
                <button type="button" role="option" class="cart-coupon-option" data-coupon-code="rate10" aria-selected="false">
                  <strong>전 상품 10% 할인 쿠폰</strong>
                  <small>최대 20,000원 할인</small>
                </button>
                <button type="button" role="option" class="cart-coupon-option" data-coupon-code="fixed15" aria-selected="false">
                  <strong>10만원 이상 구매 15,000원 할인 쿠폰</strong>
                  <small>선택 상품 금액 100,000원 이상 사용 가능</small>
                </button>
                <button type="button" role="option" class="cart-coupon-option" data-coupon-code="season7" aria-selected="false">
                  <strong>시즌 감사 7% 할인 쿠폰</strong>
                  <small>최대 10,000원 할인</small>
                </button>
              </div>
            </div>

            <small class="cart-coupon-test-note">기능 확인용 테스트 쿠폰 4장이 등록되어 있습니다.</small>
          </div>
        </div>

        <div class="cart-benefit-section">
          <div class="cart-point-head">
            <div>
              <b>포인트</b>
              <small>보유 12,500P · 1,000P 단위로 사용</small>
            </div>
            <button type="button" id="cartPointAll">전액 사용</button>
          </div>
          <div class="cart-point-input">
            <input type="number" id="cartPointInput" min="0" step="1000" value="0" inputmode="numeric" aria-describedby="cartPointHelp cartPointError" />
            <span>P</span>
          </div>
          <small class="cart-point-help" id="cartPointHelp">1,000P 이상부터 1,000P 단위로 입력해 주세요. 최대 12,000P까지 사용할 수 있어요.</small>
          <small class="cart-point-error" id="cartPointError" role="alert" aria-live="polite"></small>
        </div>

        <div class="cart-benefit-preview">
          <div><span>선택 상품 금액</span><b id="cartBenefitProductTotal">288,000원</b></div>
          <div><span>쿠폰 할인</span><b id="cartBenefitCouponDiscount">0원</b></div>
          <div><span>포인트 사용</span><b id="cartBenefitPointDiscount">0P</b></div>
          <div class="is-final"><span>결제 예정 금액</span><strong id="cartBenefitFinalTotal">288,000원</strong></div>
        </div>

        <button type="button" class="primary-button cart-modal-submit" id="cartBenefitApply">적용하기</button>
      </div>
    </div>

    <!-- 비밀번호 확인: 추후 로그인 회원의 비밀번호를 Controller에서 검증하도록 연결 -->
    <div class="modal password-gate-modal" id="passwordGate" aria-hidden="true">
      <div class="modal-dialog secure-dialog" role="dialog" aria-modal="true" aria-labelledby="passwordGateTitle">
        <button class="modal-close" data-close-modal>×</button>
        <span class="eyebrow">본인 확인</span>
        <h2 id="passwordGateTitle">비밀번호를 확인해 주세요</h2>
        <p>
          회원님의 정보를 안전하게 보호하기 위해<br />현재 비밀번호를 한 번 더
          입력해 주세요.
        </p>
        <form id="passwordGateForm" autocomplete="off">
          <input
            type="password"
            id="gatePassword"
            name="currentPassword"
            placeholder="현재 비밀번호"
            autocomplete="current-password"
            inputmode="numeric"
            required
          /><small id="gateHelp">UI 확인용 비밀번호는 <b>1234</b>입니다.</small
          ><button class="primary-button" id="passwordGateSubmit" type="submit">확인</button>
        </form>
      </div>
    </div>

    <div class="modal" id="addressModal" aria-hidden="true">
      <div class="modal-backdrop" data-close-modal></div>
      <div class="modal-dialog">
        <button class="modal-close" data-close-modal>×</button
        ><span class="eyebrow">DELIVERY</span>
        <h2>배송지 등록</h2>
        <form class="modal-form demo-form">
          <label>배송지명<input value="우리집" required /></label>
          <div class="two-column">
            <label>받는 분<input value="김민혁" required /></label
            ><label>연락처<input value="010-1234-5678" required /></label>
          </div>
          <label
            >우편번호<span class="inline-input"
              ><input id="modalPostcode" name="postcode" value="04048" readonly /><button
                type="button"
                data-action="postcode"
                data-postcode-target="modalPostcode"
                data-address-target="modalAddress"
                data-detail-target="modalAddressDetail"
              >
                주소 검색
              </button></span
            ></label
          ><label>주소<input id="modalAddress" name="address" value="서울 마포구 서교동 447-5" readonly /></label
          ><label>상세주소<input id="modalAddressDetail" name="addressDetail" value="301호" /></label
          ><label class="check-line"
            ><input type="checkbox" checked /> 기본 배송지로 설정</label
          ><button class="primary-button" type="submit">저장</button>
        </form>
      </div>
    </div>

    <div class="modal" id="accountModal" aria-hidden="true">
      <div class="modal-backdrop" data-close-modal></div>
      <div class="modal-dialog">
        <button class="modal-close" data-close-modal>×</button
        ><span class="eyebrow">SETTLEMENT</span>
        <h2>환불 입금 계좌 등록</h2>
        <form class="modal-form demo-form">
          <label
            >은행<select>
              <option>KB국민은행</option>
              <option>신한은행</option>
              <option>카카오뱅크</option>
            </select></label
          ><label>계좌번호<input placeholder="- 없이 입력" required /></label
          ><label>예금주<input value="김민혁" required /></label
          ><button class="primary-button" type="submit">계좌 등록</button>
        </form>
      </div>
    </div>

    <div class="modal" id="inquiryModal" aria-hidden="true">
      <div class="modal-backdrop" data-close-modal></div>
      <div class="modal-dialog">
        <button class="modal-close" data-close-modal>×</button
        ><span class="eyebrow">1:1 SUPPORT</span>
        <h2>문의하기</h2>
        <form class="modal-form demo-form">
          <label
            >문의 유형<select>
              <option>구매/결제</option>
              <option>배송</option>
              <option>교환/반품</option>
              <option>회원정보</option>
            </select></label
          ><label
            >제목<input required placeholder="문의 제목을 입력하세요" /></label
          ><label
            >문의 내용<textarea
              rows="5"
              required
              placeholder="문의 내용을 자세히 입력해 주세요"
            ></textarea></label
          ><button class="primary-button" type="submit">문의 등록</button>
        </form>
      </div>
    </div>

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
