<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String ctx = request.getContextPath(); %>
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>통합 검색 | Yongsinsa</title>
    <link rel="shortcut icon" href="<%=ctx%>/dist/images/favicon.ico" />
    <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/layout.css?v=20260806-0140" />
</head>
  <body class="yp-page has-site-layout" data-context-path="<%=ctx%>">
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

            <div class="search-product-grid" id="searchProductGrid"></div>

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
    

    <script src="${pageContext.request.contextPath}/dist/js/pages/product/search.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
