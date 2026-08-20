<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
      <button class="chip is-active" data-filter="all">전체 11</button>
      <button class="chip" data-filter="paid">결제 완료 2</button>
      <button class="chip" data-filter="shipping">배송 중 1</button>
      <button class="chip" data-filter="complete">구매 완료 8</button>
    </div>
    <div class="period-row">
      <button class="period is-active">최근 1개월</button>
      <button class="period">3개월</button>
      <button class="period">6개월</button>
      <input type="date" value="2026-07-04" /><span>~</span>
      <input type="date" value="2026-08-04" />
      <button class="dark-button" data-action="filter">조회</button>
    </div>
  </div>
  <div class="list-head">
    <span>상품 정보</span><span>구매 금액</span><span>진행 상태</span><span>관리</span>
  </div>
  <div class="transaction-list">
    <article class="transaction-item" data-status="shipping">
      <div class="shoe-thumb">NB</div>
      <div>
        <small>2026.08.01 · YS260801-0148</small>
        <h3>New Balance 993 Made in USA Grey</h3>
        <p>260mm · 일반 주문</p>
      </div>
      <strong>289,000원</strong><span class="state blue-state">배송 중</span>
      <div class="row-actions">
        <button data-action="detail">상세보기</button>
        <button data-view="shipping">배송조회</button>
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
        <button data-action="detail">상세보기</button>
        <button data-action="review">리뷰 작성</button>
      </div>
    </article>
  </div>
</section>