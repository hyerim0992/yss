<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>통합 검색 | Yongsinsa</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/dist/images/favicon.ico" />
    <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/layout.css?v=20260806-0140" />
</head>
  <body class="yp-page has-site-layout" data-context-path="${pageContext.request.contextPath}">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    

    <main class="search-page-main">
      <div class="yp-page-shell">
        <section class="search-page-heading">
          <p class="search-page-heading__eyebrow">PRODUCT SEARCH</p>
          <h1 id="searchResultTitle">검색 결과</h1>
          <p>브랜드, 상품명, 모델번호와 태그를 기준으로 상품을 찾아보세요.</p>
        </section>

        <form class="search-page-query" id="searchPageForm">
          <input id="searchPageQuery" type="search" placeholder="브랜드, 상품명, 모델번호, 태그 등" aria-label="검색어" />
          <button type="submit">검색</button>
        </form>

        <div class="search-layout">
          <aside class="search-filter" aria-label="검색 필터">
            <div class="search-filter__head">
              <h2>필터</h2>
              <button class="search-filter__reset" id="searchFilterReset" type="button">초기화</button>
            </div>

            <form id="searchFilterForm">
              <section class="filter-group">
                <h3>배송 종류</h3>
                <div class="filter-options">
                  <label class="filter-check"><input type="checkbox" name="delivery" value="fast" />빠른배송</label>
                  <label class="filter-check"><input type="checkbox" name="delivery" value="overseas" />해외배송</label>
                  <label class="filter-check"><input type="checkbox" name="delivery" value="normal" />일반배송</label>
                  <label class="filter-check"><input type="checkbox" name="delivery" value="warehouse" />창고보관 가능</label>
                </div>
              </section>

              <section class="filter-group">
                <h3>카테고리</h3>
                <div class="filter-options">
                  <label class="filter-check"><input type="checkbox" name="category" value="sneakers" />스니커즈</label>
                  <label class="filter-check"><input type="checkbox" name="category" value="running" />러닝화</label>
                  <label class="filter-check"><input type="checkbox" name="category" value="slipon" />슬립온</label>
                  <label class="filter-check"><input type="checkbox" name="category" value="sandal" />샌들</label>
                </div>
              </section>

              <section class="filter-group">
                <h3>성별</h3>
                <div class="filter-options filter-options--inline">
                  <label class="filter-check"><input type="checkbox" name="gender" value="men" />남성</label>
                  <label class="filter-check"><input type="checkbox" name="gender" value="women" />여성</label>
                  <label class="filter-check"><input type="checkbox" name="gender" value="unisex" />공용</label>
                </div>
              </section>

              <section class="filter-group">
                <h3>색상</h3>
                <div class="filter-options filter-options--inline">
                  <label class="filter-check"><input type="checkbox" name="color" value="black" />블랙</label>
                  <label class="filter-check"><input type="checkbox" name="color" value="white" />화이트</label>
                  <label class="filter-check"><input type="checkbox" name="color" value="gray" />그레이</label>
                  <label class="filter-check"><input type="checkbox" name="color" value="beige" />베이지</label>
                </div>
              </section>

              <section class="filter-group">
                <h3>브랜드</h3>
                <div class="filter-options">
                  <label class="filter-check"><input type="checkbox" name="brand" value="Nike" />나이키</label>
                  <label class="filter-check"><input type="checkbox" name="brand" value="Adidas" />아디다스</label>
                  <label class="filter-check"><input type="checkbox" name="brand" value="New Balance" />뉴발란스</label>
                  <label class="filter-check"><input type="checkbox" name="brand" value="Asics" />아식스</label>
                  <label class="filter-check"><input type="checkbox" name="brand" value="Converse" />컨버스</label>
                </div>
              </section>

              <section class="filter-group">
                <h3>사이즈</h3>
                <div class="filter-options filter-options--inline">
                  <label class="filter-check"><input type="checkbox" name="size" value="230" />230</label>
                  <label class="filter-check"><input type="checkbox" name="size" value="235" />235</label>
                  <label class="filter-check"><input type="checkbox" name="size" value="240" />240</label>
                  <label class="filter-check"><input type="checkbox" name="size" value="245" />245</label>
                  <label class="filter-check"><input type="checkbox" name="size" value="250" />250</label>
                  <label class="filter-check"><input type="checkbox" name="size" value="255" />255</label>
                  <label class="filter-check"><input type="checkbox" name="size" value="260" />260</label>
                  <label class="filter-check"><input type="checkbox" name="size" value="265" />265</label>
                  <label class="filter-check"><input type="checkbox" name="size" value="270" />270</label>
                  <label class="filter-check"><input type="checkbox" name="size" value="275" />275</label>
                </div>
              </section>

              <section class="filter-group">
                <h3>가격대</h3>
                <div class="filter-options">
                  <label class="filter-check"><input type="checkbox" name="price" value="under100" />10만원 미만</label>
                  <label class="filter-check"><input type="checkbox" name="price" value="100to150" />10만원~15만원</label>
                  <label class="filter-check"><input type="checkbox" name="price" value="over150" />15만원 이상</label>
                </div>
              </section>

              <section class="filter-group">
                <label class="filter-check"><input id="excludeSoldout" type="checkbox" checked />품절 상품 제외</label>
              </section>
            </form>
          </aside>

          <section class="search-results" aria-live="polite">
            <div class="search-toolbar">
              <p>검색 결과 <strong id="searchResultCount">0</strong>개</p>
              <select class="search-sort" id="searchSort" aria-label="검색 결과 정렬">
                <option value="recommend">추천순</option>
                <option value="popular">인기순</option>
                <option value="male">남성 인기순</option>
                <option value="female">여성 인기순</option>
                <option value="priceLow">낮은 가격순</option>
                <option value="priceHigh">높은 가격순</option>
                <option value="wish">관심 많은순</option>
                <option value="review">리뷰 많은순</option>
                <option value="release">발매일순</option>
              </select>
            </div>

            <div class="search-product-grid" id="searchProductGrid">
              <!--
                ★ 연습 포인트
                아래 상품 카드가 반복되는 부분입니다.
                나중에 Controller에서 List를 넘겨받은 뒤 직접 c:forEach / DTO 값 출력 형태로 바꿔보세요.
                현재는 화면 확인과 필터 동작 연습을 위해 샘플 HTML을 JSP에 직접 둡니다.
              -->
              <article class="search-product-card" data-search-product
                data-brand="Adidas" data-name="Samba OG Core Black" data-keywords="아디다스 삼바 블랙 스니커즈"
                data-price="149000" data-popularity="98" data-male="94" data-female="87"
                data-wish="1230" data-review="421" data-release="20260801"
                data-category="sneakers" data-gender="unisex" data-color="black" data-size="255"
                data-delivery="fast" data-soldout="false">
                <a href="${pageContext.request.contextPath}/product/detail">
                  <div class="search-product-card__image">
                    <span class="search-product-card__badge">빠른배송</span>
                    <img src="${pageContext.request.contextPath}/dist/images/product/product_list_1.png" alt="Adidas Samba OG Core Black">
                  </div>
                  <div class="search-product-card__body">
                    <p class="search-product-card__brand">Adidas</p>
                    <h2 class="search-product-card__name">Samba OG Core Black</h2>
                    <p class="search-product-card__meta">관심 1,230 · 리뷰 421</p>
                    <div class="search-product-card__price"><strong>149,000원</strong><span>255mm</span></div>
                  </div>
                </a>
              </article>

              <article class="search-product-card" data-search-product
                data-brand="Nike" data-name="Air Force 1 &#x27;07 White" data-keywords="나이키 에어포스 화이트 스니커즈"
                data-price="139000" data-popularity="96" data-male="91" data-female="92"
                data-wish="1580" data-review="612" data-release="20260720"
                data-category="sneakers" data-gender="unisex" data-color="white" data-size="260"
                data-delivery="normal" data-soldout="false">
                <a href="${pageContext.request.contextPath}/product/detail">
                  <div class="search-product-card__image">
                    <span class="search-product-card__badge">일반배송</span>
                    <img src="${pageContext.request.contextPath}/dist/images/product/product_list_2.png" alt="Nike Air Force 1 &#x27;07 White">
                  </div>
                  <div class="search-product-card__body">
                    <p class="search-product-card__brand">Nike</p>
                    <h2 class="search-product-card__name">Air Force 1 &#x27;07 White</h2>
                    <p class="search-product-card__meta">관심 1,580 · 리뷰 612</p>
                    <div class="search-product-card__price"><strong>139,000원</strong><span>260mm</span></div>
                  </div>
                </a>
              </article>

              <article class="search-product-card" data-search-product
                data-brand="New Balance" data-name="530 Steel Grey" data-keywords="뉴발란스 530 스틸그레이 러닝화"
                data-price="119000" data-popularity="95" data-male="84" data-female="96"
                data-wish="2110" data-review="886" data-release="20260711"
                data-category="running" data-gender="unisex" data-color="gray" data-size="240"
                data-delivery="warehouse" data-soldout="false">
                <a href="${pageContext.request.contextPath}/product/detail">
                  <div class="search-product-card__image">
                    <span class="search-product-card__badge">창고보관</span>
                    <img src="${pageContext.request.contextPath}/dist/images/product/product_list_3.png" alt="New Balance 530 Steel Grey">
                  </div>
                  <div class="search-product-card__body">
                    <p class="search-product-card__brand">New Balance</p>
                    <h2 class="search-product-card__name">530 Steel Grey</h2>
                    <p class="search-product-card__meta">관심 2,110 · 리뷰 886</p>
                    <div class="search-product-card__price"><strong>119,000원</strong><span>240mm</span></div>
                  </div>
                </a>
              </article>

              <article class="search-product-card" data-search-product
                data-brand="Asics" data-name="Gel-Kayano 14 Cream Black" data-keywords="아식스 젤카야노 크림 블랙 러닝화"
                data-price="189000" data-popularity="91" data-male="95" data-female="80"
                data-wish="970" data-review="302" data-release="20260618"
                data-category="running" data-gender="men" data-color="beige" data-size="270"
                data-delivery="overseas" data-soldout="false">
                <a href="${pageContext.request.contextPath}/product/detail">
                  <div class="search-product-card__image">
                    <span class="search-product-card__badge">해외배송</span>
                    <img src="${pageContext.request.contextPath}/dist/images/product/product_list_4.png" alt="Asics Gel-Kayano 14 Cream Black">
                  </div>
                  <div class="search-product-card__body">
                    <p class="search-product-card__brand">Asics</p>
                    <h2 class="search-product-card__name">Gel-Kayano 14 Cream Black</h2>
                    <p class="search-product-card__meta">관심 970 · 리뷰 302</p>
                    <div class="search-product-card__price"><strong>189,000원</strong><span>270mm</span></div>
                  </div>
                </a>
              </article>

              <article class="search-product-card" data-search-product
                data-brand="Converse" data-name="Chuck 70 Classic Black" data-keywords="컨버스 척70 클래식 블랙 스니커즈"
                data-price="95000" data-popularity="89" data-male="85" data-female="91"
                data-wish="760" data-review="234" data-release="20260529"
                data-category="sneakers" data-gender="unisex" data-color="black" data-size="250"
                data-delivery="fast" data-soldout="false">
                <a href="${pageContext.request.contextPath}/product/detail">
                  <div class="search-product-card__image">
                    <span class="search-product-card__badge">빠른배송</span>
                    <img src="${pageContext.request.contextPath}/dist/images/product/product_list_5.png" alt="Converse Chuck 70 Classic Black">
                  </div>
                  <div class="search-product-card__body">
                    <p class="search-product-card__brand">Converse</p>
                    <h2 class="search-product-card__name">Chuck 70 Classic Black</h2>
                    <p class="search-product-card__meta">관심 760 · 리뷰 234</p>
                    <div class="search-product-card__price"><strong>95,000원</strong><span>250mm</span></div>
                  </div>
                </a>
              </article>

              <article class="search-product-card" data-search-product
                data-brand="Adidas" data-name="Ecliptain Cloud White" data-keywords="아디다스 이클립테인 클라우드 화이트"
                data-price="79000" data-popularity="82" data-male="78" data-female="86"
                data-wish="660" data-review="199" data-release="20260510"
                data-category="slipon" data-gender="women" data-color="white" data-size="235"
                data-delivery="normal" data-soldout="false">
                <a href="${pageContext.request.contextPath}/product/detail">
                  <div class="search-product-card__image">
                    <span class="search-product-card__badge">일반배송</span>
                    <img src="${pageContext.request.contextPath}/dist/images/product/product_list_6.png" alt="Adidas Ecliptain Cloud White">
                  </div>
                  <div class="search-product-card__body">
                    <p class="search-product-card__brand">Adidas</p>
                    <h2 class="search-product-card__name">Ecliptain Cloud White</h2>
                    <p class="search-product-card__meta">관심 660 · 리뷰 199</p>
                    <div class="search-product-card__price"><strong>79,000원</strong><span>235mm</span></div>
                  </div>
                </a>
              </article>

              <article class="search-product-card" data-search-product
                data-brand="Nike" data-name="Pegasus 41 Black" data-keywords="나이키 페가수스 러닝화 블랙"
                data-price="159000" data-popularity="87" data-male="90" data-female="82"
                data-wish="540" data-review="167" data-release="20260424"
                data-category="running" data-gender="men" data-color="black" data-size="275"
                data-delivery="fast" data-soldout="true">
                <a href="${pageContext.request.contextPath}/product/detail">
                  <div class="search-product-card__image">
                    <span class="search-product-card__badge">품절</span>
                    <img src="${pageContext.request.contextPath}/dist/images/product/product_list_7.png" alt="Nike Pegasus 41 Black">
                  </div>
                  <div class="search-product-card__body">
                    <p class="search-product-card__brand">Nike</p>
                    <h2 class="search-product-card__name">Pegasus 41 Black</h2>
                    <p class="search-product-card__meta">관심 540 · 리뷰 167</p>
                    <div class="search-product-card__price"><strong>159,000원</strong><span>275mm</span></div>
                  </div>
                </a>
              </article>

              <article class="search-product-card" data-search-product
                data-brand="New Balance" data-name="574 Legacy Beige" data-keywords="뉴발란스 574 레거시 베이지"
                data-price="129000" data-popularity="85" data-male="79" data-female="90"
                data-wish="820" data-review="275" data-release="20260412"
                data-category="sneakers" data-gender="women" data-color="beige" data-size="245"
                data-delivery="warehouse" data-soldout="false">
                <a href="${pageContext.request.contextPath}/product/detail">
                  <div class="search-product-card__image">
                    <span class="search-product-card__badge">창고보관</span>
                    <img src="${pageContext.request.contextPath}/dist/images/product/product_list_8.png" alt="New Balance 574 Legacy Beige">
                  </div>
                  <div class="search-product-card__body">
                    <p class="search-product-card__brand">New Balance</p>
                    <h2 class="search-product-card__name">574 Legacy Beige</h2>
                    <p class="search-product-card__meta">관심 820 · 리뷰 275</p>
                    <div class="search-product-card__price"><strong>129,000원</strong><span>245mm</span></div>
                  </div>
                </a>
              </article>

              <article class="search-product-card" data-search-product
                data-brand="Asics" data-name="Gel-Nimbus 26 White" data-keywords="아식스 젤님버스 화이트 러닝화"
                data-price="179000" data-popularity="80" data-male="82" data-female="77"
                data-wish="430" data-review="143" data-release="20260330"
                data-category="running" data-gender="unisex" data-color="white" data-size="265"
                data-delivery="overseas" data-soldout="false">
                <a href="${pageContext.request.contextPath}/product/detail">
                  <div class="search-product-card__image">
                    <span class="search-product-card__badge">해외배송</span>
                    <img src="${pageContext.request.contextPath}/dist/images/product/product_list_9.png" alt="Asics Gel-Nimbus 26 White">
                  </div>
                  <div class="search-product-card__body">
                    <p class="search-product-card__brand">Asics</p>
                    <h2 class="search-product-card__name">Gel-Nimbus 26 White</h2>
                    <p class="search-product-card__meta">관심 430 · 리뷰 143</p>
                    <div class="search-product-card__price"><strong>179,000원</strong><span>265mm</span></div>
                  </div>
                </a>
              </article>

              <article class="search-product-card" data-search-product
                data-brand="Converse" data-name="Run Star Hike Low" data-keywords="컨버스 런스타 하이크 로우"
                data-price="109000" data-popularity="78" data-male="73" data-female="88"
                data-wish="590" data-review="188" data-release="20260302"
                data-category="sneakers" data-gender="women" data-color="black" data-size="230"
                data-delivery="normal" data-soldout="false">
                <a href="${pageContext.request.contextPath}/product/detail">
                  <div class="search-product-card__image">
                    <span class="search-product-card__badge">일반배송</span>
                    <img src="${pageContext.request.contextPath}/dist/images/product/product_list_10.png" alt="Converse Run Star Hike Low">
                  </div>
                  <div class="search-product-card__body">
                    <p class="search-product-card__brand">Converse</p>
                    <h2 class="search-product-card__name">Run Star Hike Low</h2>
                    <p class="search-product-card__meta">관심 590 · 리뷰 188</p>
                    <div class="search-product-card__price"><strong>109,000원</strong><span>230mm</span></div>
                  </div>
                </a>
              </article>
            </div>

            <div class="search-empty" id="searchEmptyState">
              <div>
                <div class="search-empty__icon"><i class="fas fa-search" aria-hidden="true"></i></div>
                <h2>검색 결과가 없습니다.</h2>
                <p>검색어의 철자를 확인하거나<br />필터 조건을 초기화한 뒤 다시 검색해 주세요.</p>
              </div>
            </div>
          </section>
        </div>
      </div>
    </main>

  
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    

    <script src="${pageContext.request.contextPath}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
