<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div id="ysPageLoader"
     class="ys-page-loader is-visible"
     role="status"
     aria-live="polite"
     aria-label="페이지를 불러오는 중">
  <div class="ys-page-loader__panel">
    <div class="ys-page-loader__logo" aria-hidden="true">
      <img class="ys-page-loader__logo-base"
           src="${pageContext.request.contextPath}/dist/images/logo/logo.png"
           alt=""
           width="144"
           height="28"
           decoding="sync" />
      <span class="ys-page-loader__logo-fill">
        <img src="${pageContext.request.contextPath}/dist/images/logo/logo.png"
             alt=""
             width="144"
             height="28"
             decoding="sync" />
      </span>
    </div>

    <div class="ys-page-loader__track" aria-hidden="true">
      <span class="ys-page-loader__bar"></span>
    </div>

    <p class="ys-page-loader__text">
      <span data-page-loader-label>페이지를 불러오는 중</span><span class="ys-page-loader__dots" aria-hidden="true">...</span>
    </p>
  </div>
</div>
<script src="${pageContext.request.contextPath}/dist/js/common/page-loader.js?v=20260806-1325"></script>
