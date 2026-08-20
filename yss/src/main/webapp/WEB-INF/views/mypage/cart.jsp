<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
    <article class="cart-item cart-item-v2" data-price="149000" data-list-price="169000" data-product-name="Samba OG Core Black">
      <input type="checkbox" class="cart-check" checked />
      <div class="shoe-thumb dark">AD</div>
      <div class="cart-product">
        <small>Adidas</small>
        <h3>Samba OG Core Black</h3>
        <p class="cart-option-text">블랙 · 255mm</p>
      </div>
      <div class="cart-item-price">
        <strong class="cart-price">149,000원</strong>
      </div>
      <button type="button" class="cart-remove" data-action="remove-cart">삭제</button>
    </article>
  </div>
</section>