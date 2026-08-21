<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div id="stockModal" class="stock-modal" hidden aria-hidden="true">

    <div class="stock-modal-backdrop"></div>

    <div class="stock-modal-content">

        <div class="stock-modal-header">
            <h2 id="stockModalTitle">재고 관리</h2>
            <button type="button" id="stockModalClose" class="stock-modal-close" aria-label="닫기">
                ×
            </button>
        </div>

        <div class="stock-product-info">

            <div class="stock-product-thumbnail">
            	<img id="stockThumbnail" src="" alt="상품 이미지">
            </div>

            <div class="stock-product-item">
                <span class="stock-product-label">상품번호</span>
                	<strong id="stockProductId"></strong>
            </div>

            <div class="stock-product-item stock-product-name">
                <span class="stock-product-label">상품명</span>
                <strong id="stockProdName"></strong>
            </div>

            <div class="stock-product-item">
                <span class="stock-product-label">판매가</span>
                <strong id="stockPrice"></strong>
            </div>
        </div>

        <div class="stock-modal-body">
            <div class="stock-option-top">
                <div>
                    <h3>재고 옵션</h3>
                    <p> 상품의 사이즈, 색상별 재고를 관리합니다. </p>
                </div>
                <button type="button" id="addStockOption" class="primary-btn stock-add-btn"> + 옵션 추가</button>
            </div>

            <div class="stock-option-header">
                <div>수량</div>
                <div>사이즈</div>
                <div>색상</div>
                <div>추가금액</div>
                <div>관리</div>
            </div>

            <div id="stockOptionBody" class="stock-option-body">  
                <div class="stock-option-row">
                
				    <div class="stock-option-cell quantity-cell">
				        <input type="number" class="stock-qty-input" placeholder="수량" min="0">
				    </div>
				
				    <div class="stock-option-cell size-cell">
				        <div class="input-unit-wrap">
				            <input type="number" class="stock-size-input" placeholder="사이즈" min="0">
				            <span class="input-unit">mm</span>
				        </div>
				    </div>

				    <div class="stock-option-cell color-cell">
				        <input type="text" class="stock-color-input" placeholder="색상">
				    </div>
				
				    <div class="stock-option-cell extra-price-cell">
				        <div class="input-unit-wrap">
				            <input type="text" class="stock-extra-price-input" placeholder="0" value="0">
				            <span class="input-unit">원</span>
				        </div>
				    </div>

				    <div class="stock-option-cell stock-action-cell">
				        <button type="button" class="light-btn stock-edit-btn">수정</button>
				        <button type="button" class="light-btn stock-delete-btn">삭제</button>
				    </div>
				</div>
            </div>

            <div id="stockEmptyState" class="stock-empty-state"> 등록된 재고 옵션이 없습니다. </div>
        </div>

        <div class="stock-modal-footer">
            <button type="button" id="stockModalCancel" class="light-btn">닫기</button>
        </div>
    </div>
</div>