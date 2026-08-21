<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

    <div class="mobile-my-nav">
      <button type="button" id="sidebarToggle">☰ 마이페이지 메뉴</button>
    </div>

    <main class="my-layout">
      <aside class="my-sidebar" id="mySidebar">
        <a class="sidebar-title" href="${pageContext.request.contextPath}/mypage/main" data-view="home">마이페이지</a>

        <section class="sidebar-group">
          <h2>쇼핑 관리</h2>
          <a href="#purchase" data-view="purchase">구매내역</a>
          <a href="${pageContext.request.contextPath}/mypage/wishlist" data-view="wishlist">위시리스트</a>
          <a href="${pageContext.request.contextPath}/mypage/cart" data-view="cart">장바구니</a>
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

