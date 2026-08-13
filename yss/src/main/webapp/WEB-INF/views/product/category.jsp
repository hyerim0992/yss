<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 카테고리 | Yongsinsa</title>
    <link rel="shortcut icon" href="${ctx}/dist/images/favicon.ico">
    <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
    <link rel="stylesheet" href="${ctx}/dist/css/pages/product/category.css" />
    <link rel="stylesheet" href="${ctx}/dist/css/common/layout.css?v=20260806-0140" />
</head>
<body class="has-site-layout" data-context-path="${ctx}">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main>
      <section class="slider-area ys-category-hero-wrap">
        <div class="single-slider slider-height2 ys-category-hero d-flex align-items-center" data-background="${ctx}/dist/images/hero/category.jpg">
          <div class="container-fluid"><div class="row"><div class="col-12"><div class="hero-cap text-center">
            <p id="categoryCollectionTitle">MEN'S COLLECTION</p><h2 id="categoryAudienceTitle">Man</h2>
          </div></div></div></div>
        </div>
      </section>

      <section class="ys-category-path"><div class="ys-page-inner"><nav class="ys-breadcrumb" aria-label="현재 위치">
        <a href="${ctx}/index.jsp"><i class="fas fa-home" aria-hidden="true"></i><span>HOME</span></a><span class="ys-breadcrumb-separator">›</span>
        <a href="${ctx}/product/category?audience=man" id="categoryAudienceLink">MAN</a><span class="ys-breadcrumb-separator">›</span>
        <span>신발</span><span class="ys-breadcrumb-separator">›</span><strong id="categoryTypeBreadcrumb">전체</strong>
      </nav></div></section>

      <section class="latest-product-area latest-padding">
        <div class="container-fluid ys-category-container"><div class="ys-product-wrap">
          <aside class="ys-filter-area">
            <form action="${ctx}/product/category" method="get" id="filterForm">
              <input type="hidden" name="type" id="categoryTypeInput" value="all">
              <input type="hidden" name="audience" id="categoryAudienceInput" value="man">
              <div class="ys-filter-top"><i class="fas fa-filter ys-filter-main-icon"></i><h3 class="ys-filter-title">FILTER</h3>
                <button type="button" class="ys-filter-toggle" id="ysFilterToggle" aria-label="필터 접기" aria-expanded="true"><i class="ti-angle-left"></i></button>
              </div>
              <div class="ys-filter-panel">
                <div class="ys-filter-group open"><button type="button" class="ys-filter-head"><span>브랜드</span><i class="ti-angle-down"></i></button><div class="ys-filter-body">
                  <label><input type="checkbox" name="brand" value="nike"> NIKE</label><label><input type="checkbox" name="brand" value="adidas"> ADIDAS</label>
                  <label><input type="checkbox" name="brand" value="vans"> VANS</label><label><input type="checkbox" name="brand" value="converse"> CONVERSE</label>
                  <label><input type="checkbox" name="brand" value="fila"> FILA</label><label><input type="checkbox" name="brand" value="puma"> PUMA</label>
                  <label><input type="checkbox" name="brand" value="crocs"> CROCS</label><label><input type="checkbox" name="brand" value="timberland"> TIMBERLAND</label>
                  <label><input type="checkbox" name="brand" value="hawkins"> HAWKINS</label>
                </div></div>
                <div class="ys-filter-group"><button type="button" class="ys-filter-head"><span>사이즈</span><i class="ti-angle-down"></i></button><div class="ys-filter-body">
                  <label><input type="checkbox" name="size" value="230"> 230</label><label><input type="checkbox" name="size" value="240"> 240</label><label><input type="checkbox" name="size" value="250"> 250</label><label><input type="checkbox" name="size" value="255"> 255</label><label><input type="checkbox" name="size" value="260"> 260</label><label><input type="checkbox" name="size" value="265"> 265</label><label><input type="checkbox" name="size" value="270"> 270</label><label><input type="checkbox" name="size" value="275"> 275</label><label><input type="checkbox" name="size" value="280"> 280</label><label><input type="checkbox" name="size" value="285"> 285</label><label><input type="checkbox" name="size" value="290"> 290</label>
                </div></div>
                <div class="ys-filter-group"><button type="button" class="ys-filter-head"><span>색상</span><i class="ti-angle-down"></i></button><div class="ys-filter-body">
                  <label><input type="checkbox" name="color" value="black"> 블랙</label><label><input type="checkbox" name="color" value="white"> 화이트</label>
                  <label><input type="checkbox" name="color" value="gray"> 그레이</label><label><input type="checkbox" name="color" value="beige"> 베이지</label><label><input type="checkbox" name="color" value="red"> 레드/핑크</label>
                </div></div>
                <div class="ys-filter-group"><button type="button" class="ys-filter-head"><span>가격</span><i class="ti-angle-down"></i></button><div class="ys-filter-body">
                  <label><input type="radio" name="price" value="0-50000"> 5만원 이하</label><label><input type="radio" name="price" value="50000-100000"> 5만원 ~ 10만원</label>
                  <label><input type="radio" name="price" value="100000-150000"> 10만원 ~ 15만원</label><label><input type="radio" name="price" value="150000-999999"> 15만원 이상</label>
                </div></div>
                <div class="ys-filter-group"><button type="button" class="ys-filter-head"><span>검색</span><i class="ti-angle-down"></i></button><div class="ys-filter-body">
                  <input type="text" name="keyword" class="ys-filter-search" placeholder="브랜드 또는 상품명">
                </div></div>
                <div class="ys-filter-btns"><a href="${ctx}/product/category" class="ys-filter-reset">초기화</a><button type="submit" class="ys-filter-submit">검색</button></div>
              </div>
            </form>
          </aside>

          <div class="ys-product-content">
            <div class="ys-list-heading"><div><h2 class="ys-list-title" id="categoryTypeTitle">전체</h2><span class="ys-result-count">총 <strong id="categoryResultCount">12</strong>개 상품</span></div></div>
            <div class="row product-btn d-flex justify-content-between align-items-center">
              <div class="properties__button"><nav><div class="nav nav-tabs" id="nav-tab" role="tablist">
                <a class="nav-item nav-link active" href="${ctx}/product/category?type=all" data-category-type="all">모두</a>
                <a class="nav-item nav-link" href="${ctx}/product/category?type=sneakers" data-category-type="sneakers">스니커즈</a>
                <a class="nav-item nav-link" href="${ctx}/product/category?type=sports" data-category-type="sports">스포츠</a>
                <a class="nav-item nav-link" href="${ctx}/product/category?type=dress" data-category-type="dress">구두</a>
                <a class="nav-item nav-link" href="${ctx}/product/category?type=casual" data-category-type="casual">캐주얼</a>
                <a class="nav-item nav-link" href="${ctx}/product/category?type=sandals" data-category-type="sandals">샌들</a>
                <a class="nav-item nav-link" href="${ctx}/product/category?type=boots" data-category-type="boots">부츠</a>
              </div></nav></div>
              <div class="ys-sort-box"><span>요약:</span><select name="sort" id="categorySort" form="filterForm"><option value="best">추천</option><option value="new">신상품순</option><option value="low">낮은가격순</option><option value="high">높은가격순</option></select></div>
            </div>
            <div class="tab-content" id="nav-tabContent"><div class="tab-pane fade show active" id="nav-home" role="tabpanel"><div class="row" id="categoryProductGrid">
              <!-- ★ 연습 포인트: 아래 반복되는 상품 카드를 나중에 직접 c:forEach / DTO 출력으로 바꿔보세요. -->
                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="1" data-type="sneakers" data-brand="converse" data-color="beige"
                                     data-sizes="250,260,270,280" data-price="69000" data-popularity="98"
                                     data-name="척테일러 올스타 클래식 베이지">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=1"><img src="${ctx}/dist/images/categori/product1.png" alt="척테일러 올스타 클래식 베이지"></a>
                                            <div class="new-product"><span>New</span></div>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="1" data-product-name="척테일러 올스타 클래식 베이지" data-product-brand="CONVERSE"
                                                        data-product-price="69000" data-product-image="${ctx}/dist/images/categori/product1.png" data-product-size="250">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">CONVERSE</div>
                                            <h4><a href="${ctx}/product/detail?id=1">척테일러 올스타 클래식 베이지</a></h4>
                                            <div class="price"><ul><li>69,000원</li>
                                                    <li class="discount">79,000원</li>
                                                    <li class="ys-discount">13%</li></ul></div>
                                            <div class="ys-size">250 / 260 / 270 / 280</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="2" data-type="sneakers" data-brand="vans" data-color="red"
                                     data-sizes="230,240,250,260" data-price="59000" data-popularity="92"
                                     data-name="클래식 체커보드 슬립온 핑크">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=2"><img src="${ctx}/dist/images/categori/product2.png" alt="클래식 체커보드 슬립온 핑크"></a>
                                            <div class="new-product"><span>New</span></div>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="2" data-product-name="클래식 체커보드 슬립온 핑크" data-product-brand="VANS"
                                                        data-product-price="59000" data-product-image="${ctx}/dist/images/categori/product2.png" data-product-size="230">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">VANS</div>
                                            <h4><a href="${ctx}/product/detail?id=2">클래식 체커보드 슬립온 핑크</a></h4>
                                            <div class="price"><ul><li>59,000원</li>
                                                    <li class="discount">79,000원</li>
                                                    <li class="ys-discount">25%</li></ul></div>
                                            <div class="ys-size">230 / 240 / 250 / 260</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="3" data-type="sports" data-brand="fila" data-color="white"
                                     data-sizes="250,260,270,280" data-price="89000" data-popularity="95"
                                     data-name="휠라 남성 어글리 러닝 슈즈">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=3"><img src="${ctx}/dist/images/categori/product3.png" alt="휠라 남성 어글리 러닝 슈즈"></a>
                                            <div class="new-product"><span>New</span></div>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="3" data-product-name="휠라 남성 어글리 러닝 슈즈" data-product-brand="FILA"
                                                        data-product-price="89000" data-product-image="${ctx}/dist/images/categori/product3.png" data-product-size="250">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">FILA</div>
                                            <h4><a href="${ctx}/product/detail?id=3">휠라 남성 어글리 러닝 슈즈</a></h4>
                                            <div class="price"><ul><li>89,000원</li>
                                                    <li class="discount">119,000원</li>
                                                    <li class="ys-discount">25%</li></ul></div>
                                            <div class="ys-size">250 / 260 / 270 / 280</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="4" data-type="casual" data-brand="vans" data-color="black"
                                     data-sizes="250,260,270,280" data-price="65000" data-popularity="91"
                                     data-name="클래식 슬립온 블랙 화이트">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=4"><img src="${ctx}/dist/images/categori/product4.png" alt="클래식 슬립온 블랙 화이트"></a>
                                            <div class="new-product"><span>New</span></div>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="4" data-product-name="클래식 슬립온 블랙 화이트" data-product-brand="VANS"
                                                        data-product-price="65000" data-product-image="${ctx}/dist/images/categori/product4.png" data-product-size="250">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">VANS</div>
                                            <h4><a href="${ctx}/product/detail?id=4">클래식 슬립온 블랙 화이트</a></h4>
                                            <div class="price"><ul><li>65,000원</li>
                                                    <li class="discount">79,000원</li>
                                                    <li class="ys-discount">18%</li></ul></div>
                                            <div class="ys-size">250 / 260 / 270 / 280</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="5" data-type="dress" data-brand="hawkins" data-color="black"
                                     data-sizes="250,260,270,280" data-price="119000" data-popularity="87"
                                     data-name="남성 클래식 로퍼 구두 블랙">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=5"><img src="${ctx}/dist/images/categori/product5.png" alt="남성 클래식 로퍼 구두 블랙"></a>
                                            <div class="new-product"><span>New</span></div>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="5" data-product-name="남성 클래식 로퍼 구두 블랙" data-product-brand="HAWKINS"
                                                        data-product-price="119000" data-product-image="${ctx}/dist/images/categori/product5.png" data-product-size="250">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">HAWKINS</div>
                                            <h4><a href="${ctx}/product/detail?id=5">남성 클래식 로퍼 구두 블랙</a></h4>
                                            <div class="price"><ul><li>119,000원</li>
                                                    <li class="discount">149,000원</li>
                                                    <li class="ys-discount">20%</li></ul></div>
                                            <div class="ys-size">250 / 260 / 270 / 280</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="6" data-type="sandals" data-brand="crocs" data-color="gray"
                                     data-sizes="250,260,270,280" data-price="59000" data-popularity="89"
                                     data-name="남성 쿠션 스포츠 샌들">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=6"><img src="${ctx}/dist/images/categori/product6.png" alt="남성 쿠션 스포츠 샌들"></a>
                                            <div class="new-product"><span>New</span></div>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="6" data-product-name="남성 쿠션 스포츠 샌들" data-product-brand="CROCS"
                                                        data-product-price="59000" data-product-image="${ctx}/dist/images/categori/product6.png" data-product-size="250">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">CROCS</div>
                                            <h4><a href="${ctx}/product/detail?id=6">남성 쿠션 스포츠 샌들</a></h4>
                                            <div class="price"><ul><li>59,000원</li>
                                                    <li class="discount">79,000원</li>
                                                    <li class="ys-discount">25%</li></ul></div>
                                            <div class="ys-size">250 / 260 / 270 / 280</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="7" data-type="boots" data-brand="timberland" data-color="beige"
                                     data-sizes="255,265,275,285" data-price="159000" data-popularity="85"
                                     data-name="남성 워커 스타일 부츠 브라운">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=7"><img src="${ctx}/dist/images/categori/product1.png" alt="남성 워커 스타일 부츠 브라운"></a>
                                            <div class="new-product"><span>New</span></div>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="7" data-product-name="남성 워커 스타일 부츠 브라운" data-product-brand="TIMBERLAND"
                                                        data-product-price="159000" data-product-image="${ctx}/dist/images/categori/product1.png" data-product-size="255">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">TIMBERLAND</div>
                                            <h4><a href="${ctx}/product/detail?id=7">남성 워커 스타일 부츠 브라운</a></h4>
                                            <div class="price"><ul><li>159,000원</li>
                                                    <li class="discount">199,000원</li>
                                                    <li class="ys-discount">20%</li></ul></div>
                                            <div class="ys-size">255 / 265 / 275 / 285</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="8" data-type="sports" data-brand="puma" data-color="black"
                                     data-sizes="255,265,275,285" data-price="79000" data-popularity="90"
                                     data-name="남성 트레이닝 스포츠 슈즈">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=8"><img src="${ctx}/dist/images/categori/product2.png" alt="남성 트레이닝 스포츠 슈즈"></a>
                                            <div class="new-product"><span>New</span></div>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="8" data-product-name="남성 트레이닝 스포츠 슈즈" data-product-brand="PUMA"
                                                        data-product-price="79000" data-product-image="${ctx}/dist/images/categori/product2.png" data-product-size="255">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">PUMA</div>
                                            <h4><a href="${ctx}/product/detail?id=8">남성 트레이닝 스포츠 슈즈</a></h4>
                                            <div class="price"><ul><li>79,000원</li>
                                                    <li class="discount">99,000원</li>
                                                    <li class="ys-discount">20%</li></ul></div>
                                            <div class="ys-size">255 / 265 / 275 / 285</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="9" data-type="sneakers" data-brand="nike" data-color="white"
                                     data-sizes="250,260,270,280,290" data-price="99000" data-popularity="99"
                                     data-name="나이키 남성 데일리 스니커즈 화이트">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=9"><img src="${ctx}/dist/images/categori/product3.png" alt="나이키 남성 데일리 스니커즈 화이트"></a>
                                            <div class="new-product"><span>New</span></div>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="9" data-product-name="나이키 남성 데일리 스니커즈 화이트" data-product-brand="NIKE"
                                                        data-product-price="99000" data-product-image="${ctx}/dist/images/categori/product3.png" data-product-size="250">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">NIKE</div>
                                            <h4><a href="${ctx}/product/detail?id=9">나이키 남성 데일리 스니커즈 화이트</a></h4>
                                            <div class="price"><ul><li>99,000원</li>
                                                    <li class="discount">129,000원</li>
                                                    <li class="ys-discount">23%</li></ul></div>
                                            <div class="ys-size">250 / 260 / 270 / 280 / 290</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="10" data-type="sports" data-brand="adidas" data-color="gray"
                                     data-sizes="250,260,270,280" data-price="109000" data-popularity="94"
                                     data-name="아디다스 남성 러닝 스포츠화">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=10"><img src="${ctx}/dist/images/categori/product4.png" alt="아디다스 남성 러닝 스포츠화"></a>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="10" data-product-name="아디다스 남성 러닝 스포츠화" data-product-brand="ADIDAS"
                                                        data-product-price="109000" data-product-image="${ctx}/dist/images/categori/product4.png" data-product-size="250">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">ADIDAS</div>
                                            <h4><a href="${ctx}/product/detail?id=10">아디다스 남성 러닝 스포츠화</a></h4>
                                            <div class="price"><ul><li>109,000원</li>
                                                    <li class="discount">139,000원</li>
                                                    <li class="ys-discount">22%</li></ul></div>
                                            <div class="ys-size">250 / 260 / 270 / 280</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="11" data-type="casual" data-brand="converse" data-color="black"
                                     data-sizes="250,260,270,280" data-price="65000" data-popularity="88"
                                     data-name="컨버스 남성 캔버스 스니커즈 블랙">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=11"><img src="${ctx}/dist/images/categori/product5.png" alt="컨버스 남성 캔버스 스니커즈 블랙"></a>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="11" data-product-name="컨버스 남성 캔버스 스니커즈 블랙" data-product-brand="CONVERSE"
                                                        data-product-price="65000" data-product-image="${ctx}/dist/images/categori/product5.png" data-product-size="250">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">CONVERSE</div>
                                            <h4><a href="${ctx}/product/detail?id=11">컨버스 남성 캔버스 스니커즈 블랙</a></h4>
                                            <div class="price"><ul><li>65,000원</li>
                                                    <li class="discount">79,000원</li>
                                                    <li class="ys-discount">18%</li></ul></div>
                                            <div class="ys-size">250 / 260 / 270 / 280</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-3 col-lg-4 col-md-6 ys-product-card-wrap" data-category-product
                                     data-id="12" data-type="boots" data-brand="timberland" data-color="beige"
                                     data-sizes="255,265,275,285" data-price="179000" data-popularity="93"
                                     data-name="프리미엄 워커 부츠 옐로우">
                                    <div class="single-product mb-60">
                                        <div class="product-img">
                                            <a href="${ctx}/product/detail?id=12"><img src="${ctx}/dist/images/categori/product6.png" alt="프리미엄 워커 부츠 옐로우"></a>
                                            <div class="new-product"><span>New</span></div>
                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요"><i class="far fa-heart"></i></button>
                                                <button type="button" class="ys-action-btn ys-cart-btn" aria-label="장바구니에 담기"
                                                        data-product-id="12" data-product-name="프리미엄 워커 부츠 옐로우" data-product-brand="TIMBERLAND"
                                                        data-product-price="179000" data-product-image="${ctx}/dist/images/categori/product6.png" data-product-size="255">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="product-caption">
                                            <div class="product-ratting"><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star low-star"></i></div>
                                            <div class="ys-brand">TIMBERLAND</div>
                                            <h4><a href="${ctx}/product/detail?id=12">프리미엄 워커 부츠 옐로우</a></h4>
                                            <div class="price"><ul><li>179,000원</li>
                                                    <li class="discount">219,000원</li>
                                                    <li class="ys-discount">18%</li></ul></div>
                                            <div class="ys-size">255 / 265 / 275 / 285</div>
                                        </div>
                                    </div>
                                </div>
              <div class="col-12" id="categoryEmptyState" hidden><div class="ys-empty">조건에 맞는 상품이 없습니다.</div></div>
            </div></div></div>
          </div>
        </div></div>
      </section>
    </main>

    <div class="ys-cart-toast" id="ysCartToast" role="status" aria-live="polite" aria-hidden="true"><i class="fas fa-check-circle"></i><span>장바구니에 상품을 담았습니다.</span><a href="${ctx}/mypage#cart">장바구니 보기</a></div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="${ctx}/dist/js/vendor/modernizr-3.5.0.min.js"></script>
    <script src="https://code.jquery.com/jquery-4.0.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <script src="${ctx}/dist/js/vendor/owl.carousel.min.js"></script><script src="${ctx}/dist/js/vendor/slick.min.js"></script><script src="${ctx}/dist/js/vendor/wow.min.js"></script>
    <script src="${ctx}/dist/js/vendor/jquery.magnific-popup.js"></script><script src="${ctx}/dist/js/vendor/jquery.scrollUp.min.js"></script><script src="${ctx}/dist/js/vendor/jquery.nice-select.min.js"></script>
    <script src="${ctx}/dist/js/common/plugins.js"></script><script src="${ctx}/dist/js/common/main.js"></script>
    <script src="${ctx}/dist/js/pages/product/category.js?v=20260813-jsp-template"></script>
    <script src="${ctx}/dist/js/common/layout.js?v=20260813-jsp-template"></script>
</body>
</html>
