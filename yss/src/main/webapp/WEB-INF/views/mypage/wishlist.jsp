<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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

    <!-- 🔴 위시리스트 디자인 강제 스타일 적용 (디자인 깨짐 방지) -->
    <style>
      .wishlist-toolbar { display: flex; justify-content: space-between; align-items: center; padding: 15px 0; border-bottom: 2px solid #111; margin-bottom: 20px; }
      .wishlist-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 20px; }
      .wish-card { border: 1px solid #eee; border-radius: 12px; overflow: hidden; background: #fff; display: flex; flex-direction: column; position: relative; transition: transform 0.2s ease, box-shadow 0.2s ease; }
      .wish-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.08); }
      .wish-card-head { position: absolute; top: 12px; left: 12px; right: 12px; display: flex; justify-content: space-between; align-items: center; z-index: 2; }
      .wish-remove-btn { background: rgba(255,255,255,0.8); border: none; width: 28px; height: 28px; border-radius: 50%; cursor: pointer; font-size: 16px; font-weight: bold; display: flex; align-items: center; justify-content: center; }
      .wish-card-body { text-decoration: none; color: inherit; display: block; }
      .wish-thumb-wrap { width: 100%; height: 220px; background: #f5f5f5; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; }
      .wish-thumb-img { width: 100%; height: 100%; object-fit: cover; }
      .wish-thumb-fallback { font-size: 20px; font-weight: bold; color: #aaa; text-transform: uppercase; }
      .wish-info { padding: 16px; }
      .wish-brand { font-size: 12px; color: #888; font-weight: 600; text-transform: uppercase; display: block; margin-bottom: 4px; }
      .wish-name { font-size: 15px; font-weight: 700; color: #111; margin: 0 0 10px 0; line-height: 1.4; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
      .wish-price-wrap { display: flex; align-items: center; gap: 8px; flex-wrap: wrap; }
      .wish-disc-rate { color: #ff3b30; font-size: 14px; font-weight: 800; }
      .wish-price { font-size: 16px; font-weight: 800; color: #111; }
      .wish-list-price { font-size: 13px; color: #aaa; text-decoration: line-through; }
      .wish-card-foot { padding: 12px 16px; border-top: 1px solid #fafafa; }
      .wish-cart-btn { width: 100%; padding: 10px; background: #111; color: #fff; border: none; border-radius: 6px; font-weight: 600; font-size: 13px; cursor: pointer; transition: background 0.2s; }
      .wish-cart-btn:hover { background: #333; }
      .empty-state { text-align: center; padding: 60px 20px; }
      .empty-icon { font-size: 48px; color: #ccc; margin-bottom: 12px; }
      .primary-button { display: inline-block; margin-top: 16px; padding: 12px 24px; background: #111; color: #fff; text-decoration: none; border-radius: 6px; font-weight: 600; }
    </style>
</head>
  <body class="has-site-layout" data-context-path="${ctx}">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <jsp:include page="/WEB-INF/views/mypage/left.jsp"/>

      <div class="my-content">
        <section class="page-view is-active" data-page="wishlist">
          <div class="page-title">
            <div>
              <span class="eyebrow blue">WISHLIST</span>
              <h1>위시리스트</h1>
              <p>마음에 드는 관심 상품을 모아보고 빠르게 장바구니에 담아보세요.</p>
            </div>
          </div>

          <c:choose>
            <c:when test="${empty list}">
              <div class="empty-state">
                <div class="empty-icon">♡</div>
                <h2>위시리스트에 담긴 상품이 없습니다.</h2>
                <p>마음에 드는 상품을 찾아 하트(♡)를 눌러 위시리스트에 추가해 보세요!</p>
                <a href="${ctx}/product/list" class="primary-button">상품 구경하러 가기</a>
              </div>
            </c:when>

            <c:otherwise>
              <div class="wishlist-toolbar">
                <div class="left">
                  <label class="custom-checkbox" style="cursor:pointer; font-weight:600;">
                    <input type="checkbox" id="wishAll" checked />
                    <span>전체 선택 (<strong id="wishCount">${totalCount}</strong>)</span>
                  </label>
                </div>
                <div class="right">
                  <button type="button" id="deleteSelectedWish" class="text-button" style="background:none; border:none; cursor:pointer; color:#666;">선택 삭제</button>
                </div>
              </div>

              <div class="wishlist-grid" id="wishlistGrid">
                <c:forEach var="dto" items="${list}">
                  <article class="wish-card" data-wish-id="${dto.wishListId}" data-product-id="${dto.productId}">
                    <div class="wish-card-head">
                      <label class="custom-checkbox">
                        <input type="checkbox" class="wish-check" value="${dto.wishListId}" checked />
                      </label>
                      <form action="${ctx}/mypage/wishlist/delete" method="post" style="display:inline;">
                        <input type="hidden" name="wishListId" value="${dto.wishListId}" />
                        <button type="submit" class="wish-remove-btn" title="삭제" onclick="return confirm('이 상품을 위시리스트에서 삭제하시겠습니까?');">×</button>
                      </form>
                    </div>

                    <a href="${ctx}/product/detail?productId=${dto.productId}" class="wish-card-body">
                      <div class="wish-thumb-wrap">
                        <c:choose>
                          <c:when test="${not empty dto.product.thumbnail}">
                            <img src="${ctx}/uploads/product/${dto.product.thumbnail}" alt="${dto.product.prodName}" class="wish-thumb-img" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                            <div class="wish-thumb-fallback" style="display:none;">${dto.product.brand}</div>
                          </c:when>
                          <c:otherwise>
                            <div class="wish-thumb-fallback">${dto.product.brand}</div>
                          </c:otherwise>
                        </c:choose>
                      </div>

                      <div class="wish-info">
                        <span class="wish-brand">${dto.product.brand}</span>
                        <h3 class="wish-name">${dto.product.prodName}</h3>
                        
                        <div class="wish-price-wrap">
                          <c:choose>
                            <c:when test="${not empty dto.product.discRate and dto.product.discRate > 0}">
                              <span class="wish-disc-rate">${dto.product.discRate}%</span>
                              <strong class="wish-price">
                                <c:set var="finalPrice" value="${dto.product.price - (dto.product.price * dto.product.discRate / 100)}" />
                                <fmt:formatNumber value="${finalPrice}" pattern="#,###"/>원
                              </strong>
                              <del class="wish-list-price">
                                <fmt:formatNumber value="${dto.product.price}" pattern="#,###"/>원
                              </del>
                            </c:when>
                            <c:otherwise>
                              <strong class="wish-price">
                                <fmt:formatNumber value="${dto.product.price}" pattern="#,###"/>원
                              </strong>
                            </c:otherwise>
                          </c:choose>
                        </div>
                      </div>
                    </a>

                    <div class="wish-card-foot">
                      <button type="button" class="wish-cart-btn" onclick="location.href='${ctx}/product/detail?productId=${dto.productId}'">
                        상품 보기
                      </button>
                    </div>
                  </article>
                </c:forEach>
              </div>
            </c:otherwise>
          </c:choose>
        </section>
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