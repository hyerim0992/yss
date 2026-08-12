<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>

<%!
    public static class Product {
        int id;
        String type;
        String brandKey;
        String brand;
        String name;
        int price;
        int originPrice;
        String colorKey;
        String image;
        String[] sizes;
        boolean delivery;
        boolean pickup;
        boolean recommend;
        int popularity;

        public Product(int id, String type, String brandKey, String brand, String name,
                       int price, int originPrice, String colorKey, String image,
                       String[] sizes, boolean delivery, boolean pickup,
                       boolean recommend, int popularity) {
            this.id = id;
            this.type = type;
            this.brandKey = brandKey;
            this.brand = brand;
            this.name = name;
            this.price = price;
            this.originPrice = originPrice;
            this.colorKey = colorKey;
            this.image = image;
            this.sizes = sizes;
            this.delivery = delivery;
            this.pickup = pickup;
            this.recommend = recommend;
            this.popularity = popularity;
        }
    }

    public boolean hasParam(String[] arr) {
        return arr != null && arr.length > 0;
    }

    public boolean containsParam(String[] arr, String value) {
        if (arr == null || value == null) return false;

        for (String s : arr) {
            if (value.equals(s)) return true;
        }

        return false;
    }

    public boolean productHasAnySize(Product p, String[] selectedSizes) {
        if (selectedSizes == null || selectedSizes.length == 0) return true;

        for (String selected : selectedSizes) {
            for (String size : p.sizes) {
                if (selected.equals(size)) return true;
            }
        }

        return false;
    }

    public String formatPrice(int price) {
        return String.format("%,d", price);
    }

    public String esc(String value) {
        if (value == null) return "";

        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;");
    }
%>

<%
    String ctx = request.getContextPath();
    String type = request.getParameter("type");

    if (type == null || type.trim().equals("")) {
        type = "all";
    }

    String typeTitle = "";

    if (type.equals("all")) {
        typeTitle = "전체";
    } else if (type.equals("sneakers")) {
        typeTitle = "스니커즈";
    } else if (type.equals("sports")) {
        typeTitle = "스포츠";
    } else if (type.equals("dress")) {
        typeTitle = "구두";
    } else if (type.equals("casual")) {
        typeTitle = "캐주얼";
    } else if (type.equals("sandals")) {
        typeTitle = "샌들";
    } else if (type.equals("boots")) {
        typeTitle = "부츠";
    } else {
        type = "all";
        typeTitle = "전체";
    }

    String audience = request.getParameter("audience");
    String sort = request.getParameter("sort");

    if (sort == null || sort.trim().equals("")) sort = "best";

    boolean isNewCategory = "new".equals(sort)
            && (audience == null || audience.trim().equals(""));

    String audienceTitle;
    String collectionTitle;
    String audienceMenuLabel;
    String categoryContextQuery;
    String categoryRootHref;

    if (isNewCategory) {
        audienceTitle = "New";
        collectionTitle = "NEW COLLECTION";
        audienceMenuLabel = "NEW";
        categoryContextQuery = "&sort=new";
        categoryRootHref = ctx + "/product/category?sort=new";
    } else if ("woman".equals(audience)) {
        audienceTitle = "Woman";
        collectionTitle = "WOMEN'S COLLECTION";
        audienceMenuLabel = "WOMAN";
        categoryContextQuery = "&audience=woman";
        categoryRootHref = ctx + "/product/category?audience=woman";
    } else if ("kids".equals(audience)) {
        audienceTitle = "Kids";
        collectionTitle = "KIDS' COLLECTION";
        audienceMenuLabel = "KIDS";
        categoryContextQuery = "&audience=kids";
        categoryRootHref = ctx + "/product/category?audience=kids";
    } else {
        audience = "man";
        audienceTitle = "Man";
        collectionTitle = "MEN'S COLLECTION";
        audienceMenuLabel = "MAN";
        categoryContextQuery = "&audience=man";
        categoryRootHref = ctx + "/product/category?audience=man";
    }

    String[] brandParams = request.getParameterValues("brand");
    String[] sizeParams = request.getParameterValues("size");
    String[] colorParams = request.getParameterValues("color");

    String priceParam = request.getParameter("price");
    String keywordParam = request.getParameter("keyword");

    if (keywordParam == null) keywordParam = "";

    ArrayList<Product> allProducts = new ArrayList<Product>();

    allProducts.add(new Product(
            1, "sneakers", "converse", "CONVERSE",
            "척테일러 올스타 클래식 베이지",
            69000, 79000, "beige",
            ctx + "/dist/images/categori/product1.png",
            new String[]{"250", "260", "270", "280"},
            true, true, true, 98
    ));

    allProducts.add(new Product(
            2, "sneakers", "vans", "VANS",
            "클래식 체커보드 슬립온 핑크",
            59000, 79000, "red",
            ctx + "/dist/images/categori/product2.png",
            new String[]{"230", "240", "250", "260"},
            true, false, true, 92
    ));

    allProducts.add(new Product(
            3, "sports", "fila", "FILA",
            "휠라 남성 어글리 러닝 슈즈",
            89000, 119000, "white",
            ctx + "/dist/images/categori/product3.png",
            new String[]{"250", "260", "270", "280"},
            true, true, true, 95
    ));

    allProducts.add(new Product(
            4, "casual", "vans", "VANS",
            "클래식 슬립온 블랙 화이트",
            65000, 79000, "black",
            ctx + "/dist/images/categori/product4.png",
            new String[]{"250", "260", "270", "280"},
            false, true, true, 91
    ));

    allProducts.add(new Product(
            5, "dress", "hawkins", "HAWKINS",
            "남성 클래식 로퍼 구두 블랙",
            119000, 149000, "black",
            ctx + "/dist/images/categori/product5.png",
            new String[]{"250", "260", "270", "280"},
            true, true, true, 87
    ));

    allProducts.add(new Product(
            6, "sandals", "crocs", "CROCS",
            "남성 쿠션 스포츠 샌들",
            59000, 79000, "gray",
            ctx + "/dist/images/categori/product6.png",
            new String[]{"250", "260", "270", "280"},
            true, false, true, 89
    ));

    allProducts.add(new Product(
            7, "boots", "timberland", "TIMBERLAND",
            "남성 워커 스타일 부츠 브라운",
            159000, 199000, "beige",
            ctx + "/dist/images/categori/product1.png",
            new String[]{"255", "265", "275", "285"},
            false, true, true, 85
    ));

    allProducts.add(new Product(
            8, "sports", "puma", "PUMA",
            "남성 트레이닝 스포츠 슈즈",
            79000, 99000, "black",
            ctx + "/dist/images/categori/product2.png",
            new String[]{"255", "265", "275", "285"},
            true, true, true, 90
    ));

    allProducts.add(new Product(
            9, "sneakers", "nike", "NIKE",
            "나이키 남성 데일리 스니커즈 화이트",
            99000, 129000, "white",
            ctx + "/dist/images/categori/product3.png",
            new String[]{"250", "260", "270", "280", "290"},
            true, true, true, 99
    ));

    allProducts.add(new Product(
            10, "sports", "adidas", "ADIDAS",
            "아디다스 남성 러닝 스포츠화",
            109000, 139000, "gray",
            ctx + "/dist/images/categori/product4.png",
            new String[]{"250", "260", "270", "280"},
            true, false, false, 94
    ));

    allProducts.add(new Product(
            11, "casual", "converse", "CONVERSE",
            "컨버스 남성 캔버스 스니커즈 블랙",
            65000, 79000, "black",
            ctx + "/dist/images/categori/product5.png",
            new String[]{"250", "260", "270", "280"},
            false, true, false, 88
    ));

    allProducts.add(new Product(
            12, "boots", "timberland", "TIMBERLAND",
            "프리미엄 워커 부츠 옐로우",
            179000, 219000, "beige",
            ctx + "/dist/images/categori/product6.png",
            new String[]{"255", "265", "275", "285"},
            true, true, true, 93
    ));

    int minPrice = 0;
    int maxPrice = Integer.MAX_VALUE;

    if (priceParam != null && !priceParam.equals("")) {
        String[] priceSplit = priceParam.split("-");

        if (priceSplit.length == 2) {
            try {
                minPrice = Integer.parseInt(priceSplit[0]);
                maxPrice = Integer.parseInt(priceSplit[1]);
            } catch (Exception e) {
                minPrice = 0;
                maxPrice = Integer.MAX_VALUE;
            }
        }
    }

    ArrayList<Product> products = new ArrayList<Product>();

    for (Product p : allProducts) {
        if (!type.equals("all") && !p.type.equals(type)) {
            continue;
        }

        if (hasParam(brandParams) && !containsParam(brandParams, p.brandKey)) {
            continue;
        }

        if (hasParam(colorParams) && !containsParam(colorParams, p.colorKey)) {
            continue;
        }

        if (!productHasAnySize(p, sizeParams)) {
            continue;
        }

        if (p.price < minPrice || p.price > maxPrice) {
            continue;
        }

        if (keywordParam != null && !keywordParam.trim().equals("")) {
            String keyword = keywordParam.toLowerCase();
            String target = (p.brand + " " + p.name).toLowerCase();

            if (!target.contains(keyword)) {
                continue;
            }
        }

        products.add(p);
    }

    if (sort.equals("low")) {
        Collections.sort(products, new Comparator<Product>() {
            public int compare(Product a, Product b) {
                return a.price - b.price;
            }
        });
    } else if (sort.equals("high")) {
        Collections.sort(products, new Comparator<Product>() {
            public int compare(Product a, Product b) {
                return b.price - a.price;
            }
        });
    } else if (sort.equals("new")) {
        Collections.sort(products, new Comparator<Product>() {
            public int compare(Product a, Product b) {
                return b.id - a.id;
            }
        });
    } else {
        Collections.sort(products, new Comparator<Product>() {
            public int compare(Product a, Product b) {
                return b.popularity - a.popularity;
            }
        });
    }
%>

<!doctype html>
<html class="no-js" lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>카테고리 | Yongsinsa</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS here -->
    <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/product/category.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/layout.css?v=20260806-0140" />
</head>

<body class="has-site-layout">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />


<!-- Preloader Start -->
<div id="preloader-active">
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="preloader-inner position-relative">
            <div class="preloader-circle"></div>
            <div class="preloader-img pere-text">
                <img src="${pageContext.request.contextPath}/dist/images/logo/logo.png" alt="">
            </div>
        </div>
    </div>
</div>
<!-- Preloader End -->



<main>

    <!-- Category Hero Start -->
    <section class="slider-area ys-category-hero-wrap">
        <div class="single-slider slider-height2 ys-category-hero d-flex align-items-center"
             data-background="${pageContext.request.contextPath}/dist/images/hero/category.jpg">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="hero-cap text-center">
                            <p><%= collectionTitle %></p>
                            <h2><%= audienceTitle %></h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Category Hero End -->

    <!-- Current Path Start -->
    <section class="ys-category-path">
        <div class="ys-page-inner">
            <nav class="ys-breadcrumb" aria-label="현재 위치">
                <a href="<%= ctx %>/index.jsp"><i class="fas fa-home" aria-hidden="true"></i><span>HOME</span></a>
                <span class="ys-breadcrumb-separator" aria-hidden="true">›</span>
                <a href="<%= categoryRootHref %>"><%= audienceMenuLabel %></a>
                <span class="ys-breadcrumb-separator" aria-hidden="true">›</span>
                <span>신발</span>
                <span class="ys-breadcrumb-separator" aria-hidden="true">›</span>
                <strong><%= typeTitle %></strong>
            </nav>
        </div>
    </section>
    <!-- Current Path End -->

    <!-- Latest Products Start -->
    <section class="latest-product-area latest-padding">
        <div class="container-fluid ys-category-container">

            <div class="ys-product-wrap">

                <!-- Filter Start -->
                <aside class="ys-filter-area">
                    <form action="${pageContext.request.contextPath}/product/category" method="get" id="filterForm">
                        <input type="hidden" name="type" value="<%= esc(type) %>">
                        <% if (!isNewCategory) { %>
                        <input type="hidden" name="audience" value="<%= esc(audience) %>">
                        <% } %>

                        <div class="ys-filter-top">
                            <i class="fas fa-filter ys-filter-main-icon" aria-hidden="true"></i>
                            <h3 class="ys-filter-title">FILTER</h3>
                            <button type="button" class="ys-filter-toggle" id="ysFilterToggle"
                                    aria-label="필터 접기" aria-expanded="true">
                                <i class="ti-angle-left" aria-hidden="true"></i>
                            </button>
                        </div>

                        <div class="ys-filter-panel">
                        <div class="ys-filter-group open">
                            <button type="button" class="ys-filter-head">
                                <span>브랜드</span>
                                <i class="ti-angle-down"></i>
                            </button>
                            <div class="ys-filter-body">
                                <label><input type="checkbox" name="brand" value="nike" <%= containsParam(brandParams, "nike") ? "checked" : "" %>> NIKE</label>
                                <label><input type="checkbox" name="brand" value="adidas" <%= containsParam(brandParams, "adidas") ? "checked" : "" %>> ADIDAS</label>
                                <label><input type="checkbox" name="brand" value="vans" <%= containsParam(brandParams, "vans") ? "checked" : "" %>> VANS</label>
                                <label><input type="checkbox" name="brand" value="converse" <%= containsParam(brandParams, "converse") ? "checked" : "" %>> CONVERSE</label>
                                <label><input type="checkbox" name="brand" value="fila" <%= containsParam(brandParams, "fila") ? "checked" : "" %>> FILA</label>
                                <label><input type="checkbox" name="brand" value="puma" <%= containsParam(brandParams, "puma") ? "checked" : "" %>> PUMA</label>
                                <label><input type="checkbox" name="brand" value="crocs" <%= containsParam(brandParams, "crocs") ? "checked" : "" %>> CROCS</label>
                                <label><input type="checkbox" name="brand" value="timberland" <%= containsParam(brandParams, "timberland") ? "checked" : "" %>> TIMBERLAND</label>
                                <label><input type="checkbox" name="brand" value="hawkins" <%= containsParam(brandParams, "hawkins") ? "checked" : "" %>> HAWKINS</label>
                            </div>
                        </div>

                        <div class="ys-filter-group">
                            <button type="button" class="ys-filter-head">
                                <span>사이즈</span>
                                <i class="ti-angle-down"></i>
                            </button>
                            <div class="ys-filter-body">
                                <label><input type="checkbox" name="size" value="230" <%= containsParam(sizeParams, "230") ? "checked" : "" %>> 230</label>
                                <label><input type="checkbox" name="size" value="240" <%= containsParam(sizeParams, "240") ? "checked" : "" %>> 240</label>
                                <label><input type="checkbox" name="size" value="250" <%= containsParam(sizeParams, "250") ? "checked" : "" %>> 250</label>
                                <label><input type="checkbox" name="size" value="255" <%= containsParam(sizeParams, "255") ? "checked" : "" %>> 255</label>
                                <label><input type="checkbox" name="size" value="260" <%= containsParam(sizeParams, "260") ? "checked" : "" %>> 260</label>
                                <label><input type="checkbox" name="size" value="265" <%= containsParam(sizeParams, "265") ? "checked" : "" %>> 265</label>
                                <label><input type="checkbox" name="size" value="270" <%= containsParam(sizeParams, "270") ? "checked" : "" %>> 270</label>
                                <label><input type="checkbox" name="size" value="275" <%= containsParam(sizeParams, "275") ? "checked" : "" %>> 275</label>
                                <label><input type="checkbox" name="size" value="280" <%= containsParam(sizeParams, "280") ? "checked" : "" %>> 280</label>
                                <label><input type="checkbox" name="size" value="285" <%= containsParam(sizeParams, "285") ? "checked" : "" %>> 285</label>
                                <label><input type="checkbox" name="size" value="290" <%= containsParam(sizeParams, "290") ? "checked" : "" %>> 290</label>
                            </div>
                        </div>

                        <div class="ys-filter-group">
                            <button type="button" class="ys-filter-head">
                                <span>색상</span>
                                <i class="ti-angle-down"></i>
                            </button>
                            <div class="ys-filter-body">
                                <label><input type="checkbox" name="color" value="black" <%= containsParam(colorParams, "black") ? "checked" : "" %>> 블랙</label>
                                <label><input type="checkbox" name="color" value="white" <%= containsParam(colorParams, "white") ? "checked" : "" %>> 화이트</label>
                                <label><input type="checkbox" name="color" value="gray" <%= containsParam(colorParams, "gray") ? "checked" : "" %>> 그레이</label>
                                <label><input type="checkbox" name="color" value="beige" <%= containsParam(colorParams, "beige") ? "checked" : "" %>> 베이지</label>
                                <label><input type="checkbox" name="color" value="red" <%= containsParam(colorParams, "red") ? "checked" : "" %>> 레드/핑크</label>
                            </div>
                        </div>

                        <div class="ys-filter-group">
                            <button type="button" class="ys-filter-head">
                                <span>가격</span>
                                <i class="ti-angle-down"></i>
                            </button>
                            <div class="ys-filter-body">
                                <label><input type="radio" name="price" value="0-50000" <%= "0-50000".equals(priceParam) ? "checked" : "" %>> 5만원 이하</label>
                                <label><input type="radio" name="price" value="50000-100000" <%= "50000-100000".equals(priceParam) ? "checked" : "" %>> 5만원 ~ 10만원</label>
                                <label><input type="radio" name="price" value="100000-150000" <%= "100000-150000".equals(priceParam) ? "checked" : "" %>> 10만원 ~ 15만원</label>
                                <label><input type="radio" name="price" value="150000-999999" <%= "150000-999999".equals(priceParam) ? "checked" : "" %>> 15만원 이상</label>
                            </div>
                        </div>

                        <div class="ys-filter-group">
                            <button type="button" class="ys-filter-head">
                                <span>검색어</span>
                                <i class="ti-angle-down"></i>
                            </button>
                            <div class="ys-filter-body">
                                <input type="text" name="keyword" class="ys-filter-search"
                                       placeholder="검색어 입력" value="<%= esc(keywordParam) %>">
                            </div>
                        </div>

                        <div class="ys-filter-btns">
                            <a href="<%= ctx %>/product/category?type=<%= esc(type) %><%= categoryContextQuery %>" class="ys-filter-reset">초기화</a>
                            <button type="submit" class="ys-filter-submit">검색</button>
                        </div>
                        </div>
                    </form>
                </aside>
                <!-- Filter End -->

                <!-- Product Content Start -->
                <div class="ys-product-content">

                    <div class="ys-list-heading">
                        <div>
                            <h2 class="ys-list-title"><%= typeTitle %></h2>
                            <span class="ys-result-count">총 <strong><%= products.size() %></strong>개 상품</span>
                        </div>
                    </div>

                    <div class="row product-btn d-flex justify-content-between align-items-center">

                        <div class="properties__button">
                            <nav>
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                    <a class="nav-item nav-link <%= type.equals("all") ? "active" : "" %>" href="<%= ctx %>/product/category?type=all<%= categoryContextQuery %>">모두</a>
                                    <a class="nav-item nav-link <%= type.equals("sneakers") ? "active" : "" %>" href="<%= ctx %>/product/category?type=sneakers<%= categoryContextQuery %>">스니커즈</a>
                                    <a class="nav-item nav-link <%= type.equals("sports") ? "active" : "" %>" href="<%= ctx %>/product/category?type=sports<%= categoryContextQuery %>">스포츠</a>
                                    <a class="nav-item nav-link <%= type.equals("dress") ? "active" : "" %>" href="<%= ctx %>/product/category?type=dress<%= categoryContextQuery %>">구두</a>
                                    <a class="nav-item nav-link <%= type.equals("casual") ? "active" : "" %>" href="<%= ctx %>/product/category?type=casual<%= categoryContextQuery %>">캐주얼</a>
                                    <a class="nav-item nav-link <%= type.equals("sandals") ? "active" : "" %>" href="<%= ctx %>/product/category?type=sandals<%= categoryContextQuery %>">샌들</a>
                                    <a class="nav-item nav-link <%= type.equals("boots") ? "active" : "" %>" href="<%= ctx %>/product/category?type=boots<%= categoryContextQuery %>">부츠</a>
                                </div>
                            </nav>
                        </div>

                        <div class="ys-sort-box">
                            <span>요약:</span>
                            <select name="sort" form="filterForm" onchange="document.getElementById('filterForm').submit();">
                                <option value="best" <%= sort.equals("best") ? "selected" : "" %>>추천</option>
                                <option value="new" <%= sort.equals("new") ? "selected" : "" %>>신상품순</option>
                                <option value="low" <%= sort.equals("low") ? "selected" : "" %>>낮은가격순</option>
                                <option value="high" <%= sort.equals("high") ? "selected" : "" %>>높은가격순</option>
                            </select>
                        </div>

                    </div>

                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-home" role="tabpanel">
                            <div class="row">

                                <% if (products.size() == 0) { %>
                                <div class="col-12">
                                    <div class="ys-empty">
                                        조건에 맞는 상품이 없습니다.
                                    </div>
                                </div>
                                <% } %>

                                <% for (Product p : products) { %>
                                <div class="col-xl-3 col-lg-4 col-md-6">
                                    <div class="single-product mb-60">

                                        <div class="product-img">
                                            <a href="<%= ctx %>/product/detail?id=<%= p.id %>">
                                                <img src="<%= p.image %>" alt="<%= esc(p.name) %>">
                                            </a>

                                            <% if (p.recommend) { %>
                                            <div class="new-product">
                                                <span>New</span>
                                            </div>
                                            <% } %>

                                            <div class="ys-product-action">
                                                <button type="button" class="ys-action-btn ys-wish-btn" aria-label="좋아요">
                                                    <i class="far fa-heart"></i>
                                                </button>
                                                <button type="button"
                                                        class="ys-action-btn ys-cart-btn"
                                                        aria-label="장바구니에 담기"
                                                        data-product-id="<%= p.id %>"
                                                        data-product-name="<%= esc(p.name) %>"
                                                        data-product-brand="<%= esc(p.brand) %>"
                                                        data-product-price="<%= p.price %>"
                                                        data-product-image="<%= p.image %>"
                                                        data-product-size="<%= p.sizes.length > 0 ? p.sizes[0] : "" %>">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </div>
                                        </div>

                                        <div class="product-caption">

                                            <div class="product-ratting">
                                                <i class="far fa-star"></i>
                                                <i class="far fa-star"></i>
                                                <i class="far fa-star"></i>
                                                <i class="far fa-star"></i>
                                                <i class="far fa-star low-star"></i>
                                            </div>

                                            <div class="ys-brand"><%= p.brand %></div>

                                            <h4>
                                                <a href="<%= ctx %>/product/detail?id=<%= p.id %>">
                                                    <%= p.name %>
                                                </a>
                                            </h4>

                                            <div class="price">
                                                <ul>
                                                    <li><%= formatPrice(p.price) %>원</li>

                                                    <% if (p.originPrice > p.price) { %>
                                                    <li class="discount"><%= formatPrice(p.originPrice) %>원</li>
                                                    <li class="ys-discount">
                                                        <%= Math.round((p.originPrice - p.price) * 100.0 / p.originPrice) %>%
                                                    </li>
                                                    <% } %>
                                                </ul>
                                            </div>

                                            <div class="ys-size">
                                                <% for (int i = 0; i < p.sizes.length; i++) { %>
                                                <%= p.sizes[i] %><%= i < p.sizes.length - 1 ? " / " : "" %>
                                                <% } %>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                                <% } %>

                            </div>
                        </div>
                    </div>

                </div>
                <!-- Product Content End -->

            </div>

        </div>
    </section>
    <!-- Latest Products End -->

</main>



<div class="ys-cart-toast" id="ysCartToast" role="status" aria-live="polite" aria-hidden="true">
    <i class="fas fa-check-circle" aria-hidden="true"></i>
    <span>장바구니에 상품을 담았습니다.</span>
    <a href="<%= ctx %>/mypage#cart">장바구니 보기</a>
</div>

<!-- JS here -->
<script src="${pageContext.request.contextPath}/dist/js/vendor/modernizr-3.5.0.min.js"></script>
<script src="https://code.jquery.com/jquery-4.0.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/dist/js/vendor/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/vendor/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/vendor/wow.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/vendor/jquery.magnific-popup.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/vendor/jquery.scrollUp.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/vendor/jquery.nice-select.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/common/plugins.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/common/main.js"></script>



    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    

    <script src="${pageContext.request.contextPath}/dist/js/pages/product/category.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>