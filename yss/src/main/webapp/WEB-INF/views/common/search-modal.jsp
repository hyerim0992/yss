<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- 공통 검색 모달: 검색 버튼이 있는 화면에서 재사용 -->
<div class="global-search" id="globalSearch" aria-hidden="true">
  <button class="global-search__backdrop" type="button" data-search-close aria-label="검색창 닫기"></button>

  <section class="global-search__panel" role="dialog" aria-modal="true" aria-labelledby="globalSearchTitle">
    <div class="global-search__topbar">
      <div>
        <p class="global-search__eyebrow">SEARCH</p>
        <h2 id="globalSearchTitle">무엇을 찾고 계신가요?</h2>
      </div>
      <button class="global-search__close" type="button" data-search-close aria-label="검색창 닫기">
        <span></span><span></span>
      </button>
    </div>

    <form class="global-search__form" data-global-search-form action="${pageContext.request.contextPath}/product/search" method="get">
      <i class="fas fa-search" aria-hidden="true"></i>
      <input
        id="globalSearchInput"
        name="q"
        type="search"
        autocomplete="off"
        placeholder="브랜드, 상품명, 모델번호, 태그를 검색하세요"
        aria-label="통합 검색어"
      />
      <button type="submit">검색</button>
    </form>

    <div class="global-search__content">
      <section class="search-summary-card search-summary-card--wide">
        <div class="search-summary-card__head">
          <h3>최근 검색어</h3>
          <button type="button" data-clear-recent>전체 지우기</button>
        </div>
        <div class="recent-search-list" data-recent-search-list></div>
        <p class="recent-search-empty" data-recent-search-empty>최근 검색한 내역이 없습니다.</p>
      </section>

      <section class="search-summary-card">
        <div class="search-summary-card__head">
          <h3>인기 검색어</h3>
          <span>실시간</span>
        </div>
        <ol class="keyword-ranking">
          <li><button type="button" data-search-keyword="나이키"><b>01</b><span>나이키</span><em class="up">▲</em></button></li>
          <li><button type="button" data-search-keyword="아디다스"><b>02</b><span>아디다스</span><em class="up">▲</em></button></li>
          <li><button type="button" data-search-keyword="뉴발란스"><b>03</b><span>뉴발란스</span><em class="up">▲</em></button></li>
          <li><button type="button" data-search-keyword="푸마"><b>04</b><span>푸마</span><em>-</em></button></li>
          <li><button type="button" data-search-keyword="반스"><b>05</b><span>반스</span><em class="down">▼</em></button></li>
          <li><button type="button" data-search-keyword="아식스"><b>06</b><span>아식스</span><em class="up">▲</em></button></li>
          <li><button type="button" data-search-keyword="컨버스"><b>07</b><span>컨버스</span><em>-</em></button></li>
          <li><button type="button" data-search-keyword="러닝화"><b>08</b><span>러닝화</span><em class="up">▲</em></button></li>
        </ol>
      </section>

      <section class="search-summary-card">
        <div class="search-summary-card__head">
          <h3>추천 검색어</h3>
          <span>지금 주목받는 키워드</span>
        </div>
        <div class="recommended-keywords">
          <button type="button" data-search-keyword="아디다스 이클립테인">아디다스 이클립테인</button>
          <button type="button" data-search-keyword="뉴발란스 530">뉴발란스 530</button>
          <button type="button" data-search-keyword="크록스 크록밴드">크록스 크록밴드</button>
          <button type="button" data-search-keyword="조던">조던</button>
          <button type="button" data-search-keyword="러닝화">러닝화</button>
          <button type="button" data-search-keyword="스니커즈">스니커즈</button>
          <button type="button" data-search-keyword="캐치티니핑">캐치티니핑</button>
        </div>
      </section>

      <section class="search-summary-card search-summary-card--ranking">
        <div class="search-summary-card__head">
          <h3>주간 판매 랭킹</h3>
          <a href="${pageContext.request.contextPath}/product/category">전체보기</a>
        </div>
        <div class="weekly-ranking">
          <a href="${pageContext.request.contextPath}/product/detail" class="weekly-ranking__item">
            <b>1</b><img src="${pageContext.request.contextPath}/dist/images/product/product_list_1.png" alt="크록스 듀엣 맥스 II 클로그" />
            <span><strong>크록스</strong><small>듀엣 맥스 II 클로그</small><em>49,000원</em></span>
          </a>
          <a href="${pageContext.request.contextPath}/product/detail" class="weekly-ranking__item">
            <b>2</b><img src="${pageContext.request.contextPath}/dist/images/product/product_list_2.png" alt="반스 스탠스 그린 화이트" />
            <span><strong>반스</strong><small>스탠스 그린/화이트</small><em>69,000원</em></span>
          </a>
          <a href="${pageContext.request.contextPath}/product/detail" class="weekly-ranking__item">
            <b>3</b><img src="${pageContext.request.contextPath}/dist/images/product/product_list_4.png" alt="아디다스 이클립테인" />
            <span><strong>아디다스</strong><small>이클립테인</small><em>79,000원</em></span>
          </a>
        </div>
      </section>
    </div>
  </section>
</div>
