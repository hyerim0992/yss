<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- 공통 헤더/검색 모달 CSS: 각 페이지 전용 CSS보다 먼저 불러와야 합니다. -->
<!-- 페이지가 그려지기 전 로더를 먼저 활성화합니다. -->
<script>
(function (document) {
  document.documentElement.classList.add("ys-page-loading");
  window.__ysPageLoaderStart = Date.now();
  window.__ysPageLoaderSafetyTimer = window.setTimeout(function () {
    document.documentElement.classList.remove("ys-page-loading");
  }, 15000);
})(document);
</script>
<link rel="preload" as="image" href="${pageContext.request.contextPath}/dist/images/logo/logo.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/page-loader.css?v=20260806-1205" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/vendor/owl.carousel.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/vendor/animate.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/vendor/magnific-popup.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/vendor/fontawesome-all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/vendor/themify-icons.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/vendor/slick.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/vendor/nice-select.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/style.css?v=20260806-1420" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/product/search.css?v=20260806-0140" data-global-search-style="true" />
