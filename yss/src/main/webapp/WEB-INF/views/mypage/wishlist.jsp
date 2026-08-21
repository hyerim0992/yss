<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- 위시리스트 전용 조각 섹션 -->
<section class="page-view" data-page="wishlist">
  <div class="page-title">
    <div>
      <span class="eyebrow">MY FAVORITES</span>
      <h1>위시리스트</h1>
      <p>관심 상품을 구매하거나 선택한 상품을 삭제할 수 있어요.</p>
    </div>
    
    <!-- JS 에러 방지: c:if를 제거하여 wishAll 아이디를 가진 요소를 항상 노출 (데이터 없으면 disabled) -->
    <label class="select-all">
      <input type="checkbox" id="wishAll" ${empty list ? 'disabled' : ''} /> 전체 선택
    </label>
  </div>

  <!-- 1. 위시리스트에 담긴 상품이 없을 때 -->
  <c:if test="${empty list}">
    <div style="text-align: center; padding: 80px 0; color: #888;">
      <p style="font-size: 16px; margin-bottom: 16px;">위시리스트에 담긴 관심 상품이 없습니다.</p>
      <a href="${ctx}/" class="outline-button" style="display: inline-block; padding: 10px 20px; text-decoration: none;">쇼핑하러 가기</a>
    </div>
    
    <!-- JS 에러 방지: 데이터가 없을 때도 deleteSelectedWish 버튼을 숨김 처리 상태로 배치 -->
    <div style="display: none;">
      <button type="button" id="deleteSelectedWish"></button>
    </div>
  </c:if>

  <!-- 2. 위시리스트 목록이 존재할 때 -->
  <c:if test="${not empty list}">
    <form id="wishlistDeleteListForm" action="${ctx}/mypage/wishlist/deleteList" method="post">
      <div class="wish-grid" id="wishGrid">
        <c:forEach var="item" items="${list}">
          <article data-wishlist-id="${item.wishListId}">
            <!-- 선택 삭제용 체크박스 -->
            <label>
              <input type="checkbox" class="wish-check" name="wishListIds" value="${item.wishListId}" />
            </label>
            <button type="button" class="heart is-on" data-action="heart" onclick="deleteSingleWish('${item.wishListId}');">♥</button>
            
            <!-- 상품 썸네일 이미지 -->
            <div class="wish-image">
              <c:choose>
                <c:when test="${not empty item.product.thumbnail}">
                  <img src="${ctx}/${item.product.thumbnail}" alt="${item.product.prodName}" style="width:100%; height:100%; object-fit:cover; border-radius:inherit;" />
                </c:when>
                <c:otherwise>
                  ${item.product.brand}
                </c:otherwise>
              </c:choose>
            </div>

            <!-- 상품 정보 -->
            <small>${item.product.brand}</small>
            <h3>${item.product.prodName}</h3>
            <p>구매가 <strong>${item.product.salePrice}원</strong></p>
            
            <!-- 버튼 영역 -->
            <div>
              <a href="${ctx}/product/detail?productId=${item.product.productId}">구매하기</a>
              <button type="button" data-action="remove-wish" onclick="deleteSingleWish('${item.wishListId}');">삭제</button>
            </div>
          </article>
        </c:forEach>
      </div>

      <!-- 관리 버튼 -->
      <div style="margin-top: 24px; display: flex; gap: 12px;">
        <button type="submit" class="outline-button danger-text" id="deleteSelectedWish" onclick="return confirm('선택한 상품을 삭제하시겠습니까?');">
          선택 상품 삭제
        </button>
        <button type="button" class="outline-button" onclick="clearAllWishlist();">
          전체 비우기
        </button>
      </div>
    </form>
  </c:if>
</section>

<!-- 위시리스트 전용 삭제 스크립트 -->
<script>
  // 단일 상품 삭제
  function deleteSingleWish(wishListId) {
      if (!confirm("해당 상품을 위시리스트에서 삭제하시겠습니까?")) return;
      
      let form = document.createElement("form");
      form.method = "POST";
      form.action = "${ctx}/mypage/wishlist/delete";
      
      let input = document.createElement("input");
      input.type = "hidden";
      input.name = "wishListId";
      input.value = wishListId;
      
      form.appendChild(input);
      document.body.appendChild(form);
      form.submit();
  }

  // 전체 상품 비우기
  function clearAllWishlist() {
      if (!confirm("위시리스트를 전체 비우시겠습니까?")) return;
      
      let form = document.createElement("form");
      form.method = "POST";
      form.action = "${ctx}/mypage/wishlist/clear";
      
      document.body.appendChild(form);
      form.submit();
  }
</script>