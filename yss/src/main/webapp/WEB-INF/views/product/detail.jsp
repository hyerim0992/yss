<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="dto" value="${list[0]}" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>${dto.prodName}| SHOES STORE</title>
<jsp:include page="/WEB-INF/views/common/head-styles.jsp" />


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/pages/product/detail.css?v=20260806-price-coupon-1" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/common/layout.css?v=20260806-0140" />
</head>
<body class="has-site-layout" data-context-path="${ctx}">
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<main class="product-page">
		<section class="product-hero page-width">
			<div class="product-gallery">
				<!-- 대표 상품 사진은 이 파일을 같은 이름으로 교체하면 됩니다. -->
				<img src="${ctx}${dto.thumbnail}" alt="${dto.prodName}" />
			</div>

			<div class="product-summary">
				<div class="summary-heading">
					<div>
						<strong class="brand">${dto.brand}</strong>
						<h1>${dto.prodName}</h1>
						<p>${dto.prodName}</p>
					</div>
					<div class="summary-icons">
						<button type="button"
							class="icon-button bookmark-button js-interest"
							aria-label="관심 상품 저장" aria-pressed="false">♡</button>
						<button type="button" class="icon-button share-button"
							aria-label="상품 공유">↗</button>
					</div>
				</div>

				<div class="product-price product-price-v2">
					<span>상품 가격</span>
					<div class="product-price-main">
						<div class="product-price-stack">
							<div class="product-sale-line">
								<c:if test="${dto.discRate != 0}">
									<del>${dto.price}원</del>
								</c:if>
								<strong class="product-sale-price">${dto.price - (dto.price * (dto.discRate/100))}원</strong>
								<c:if test="${dto.discRate != 0}">
									<span>${dto.discRate}% 할인</span>
								</c:if>
							</div>
							<div class="product-coupon-price-line"
								id="productCouponPriceLine" hidden>
								<small>쿠폰 적용가</small> <strong id="productCouponPrice">130,000원</strong>
								<span id="productCouponRate">쿠폰 적용</span>
							</div>
						</div>
						<div class="product-price-actions">
							<em>무료 배송</em>
							<!-- 무료배송/유료배송 -->
							<button type="button" id="productCouponOpen">쿠폰 적용</button>
						</div>
					</div>
				</div>

				<ul class="benefit-list">
					<li><span>▣ <b>카드 결제 혜택</b></span> <small>최대 6개월 무이자
							할부</small></li>
					<li><span>✺ <b>회원 적립 혜택</b></span> <small>구매 확정 시
							1,300P 적립</small></li>
					<li><span>▤ <b>빠른 배송</b></span> <small>결제 완료 후 순차 배송</small></li>
				</ul>

				<div class="option-select-grid" aria-label="상품 옵션 선택">
					<button type="button" class="option-select js-open-color" id="colorOption">
						<span> <b>색상</b> <small class="selected-color">색상을
								선택하세요</small>
						</span> <span>⌄</span>
					</button>
					<button type="button" class="option-select js-open-size" id="sizeOption">
						<span> <b>사이즈</b> <small class="selected-size">사이즈를
								선택하세요</small>
						</span> <span>⌄</span>
					</button>
				</div>

				<div class="selected-option-card" id="selectedOptionCard">
					<div class="selected-option-visual">
						<div>
							<small>선택한 상품</small> <b class="selected-option-name">옵션을 선택해
								주세요.</b>
						</div>
					</div>
					<span class="stock-badge">옵션 선택 필요</span>
				</div>

				<button type="button" class="purchase-button js-purchase">
					<span> <small>총 상품 금액</small> <b class="js-purchase-price">130,000원</b>
					</span> <strong>구매하기</strong>
				</button>

				<div class="secondary-actions">
					<button type="button" class="secondary-button js-interest"
						aria-pressed="false">
						<span class="interest-icon">♡</span> <span><b>관심상품</b><small><span
								class="interest-count">1,284</span>명이 저장</small></span>
						<!-- 관심상품 횟수 필요 -->
					</button>
					<button type="button" class="secondary-button js-restock"
						aria-pressed="false">
						<span class="restock-icon">♢</span> <span><b
							class="restock-label">재입고 알림 신청</b><small>품절 옵션 입고 시 안내</small></span>
					</button>
				</div>

				<ul class="delivery-list">
					<li><span>▧ <b>무료 배송</b></span> <small>결제 후 2~4일 이내 배송</small>
					</li>
					<li><span>↺ <b>교환·반품 안내</b></span> <small>수령 후 7일 이내
							신청</small></li>
				</ul>

				<section class="basic-info" aria-labelledby="basicInfoTitle">
					<h2 id="basicInfoTitle">기본 정보</h2>
					<dl class="basic-info-grid">
						<div>
							<dt>모델번호</dt>
							<dd>KH6245</dd>
						</div>
						<div>
							<dt>출시일</dt>
							<dd>2025. 03. 14.</dd>
						</div>
						<div>
							<dt>대표 컬러</dt>
							<dd>GREY TWO / PURPLE</dd>
						</div>
						<div>
							<dt>상품 가격</dt>
							<dd>${dto.price}원</dd>
						</div>
						<div>
							<dt>브랜드</dt>
							<dd>${dto.brand}</dd>
						</div>
						<div>
							<dt>카테고리</dt>
							<dd>스니커즈</dd>
							<!-- 카테고리 필요 -->
						</div>
					</dl>
				</section>
			</div>
		</section>

		<%--       <aside class="sticky-trade" aria-label="빠른 구매 메뉴">
        <div class="sticky-inner page-width">
          <div class="sticky-product">
            <img src="${ctx}/dist/images/product-detail/main-shoe.png" alt="상품 미리보기" />
            <span>
              <b>ADIDAS</b>
              <strong>아디다스 ZX 8000 그레이 투 퍼플</strong>
              <small class="js-purchase-price">130,000원</small>
            </span>
          </div>
          <button type="button" class="sticky-option js-open-color">
            <b class="selected-color">색상 선택</b><small>색상</small><span>⌄</span>
          </button>
          <button type="button" class="sticky-option js-open-size">
            <b class="selected-size">사이즈 선택</b><small>사이즈</small><span>⌄</span>
          </button>
          <button type="button" class="purchase-button sticky-purchase js-purchase">
            <span><small>상품 금액</small><b class="js-purchase-price">130,000원</b></span>
            <strong>구매</strong>
          </button>
        </div>
      </aside> --%>

		<section class="detail-section page-width">
			<nav id="detail-navbar"
				class="detail-navbar navbar sticky-top bg-white border-bottom"
				aria-label="상세 정보 탭">
				<ul class="nav nav-pills">
					<li class="nav-item"><a class="nav-link" href="#info">상품정보</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#review">상품리뷰(128)</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#question">Q&amp;A(12)</a>
					</li>
				</ul>
			</nav>
			<div data-bs-spy="scroll" data-bs-target="#detail-navbar">
				<div class="tab-panel" id="info">
					<div class="collapsed" id="infoContent">
						<h2>상품정보</h2>
						<p>
							<b>ADIDAS ZX 8000.</b><br />1980년대 러닝화의 감성을 현대적으로 재해석한 데일리
							스니커즈입니다. 메시와 스웨이드 소재가 조화를 이루며, 그레이와 퍼플 포인트가 다양한 스타일에 자연스럽게 어울립니다.
						</p>
						<c:forEach var="list" items="${list}" varStatus="status">
							<div>
								<img alt="${list.imageId}" src="${ctx}${list.files}">
							</div>
						</c:forEach>
						<p class="info-warning">
							■ 재고 품절 시 상품 수급이 어려울 수 있습니다.<br /> ■ 모니터 해상도와 기기에 따라 실제 색상이 다르게
							보일 수 있습니다.<br /> ■ 등록된 상품 정보는 판매자가 제공한 내용이며 실제 상품과 차이가 있을 수
							있습니다.
						</p>
						<dl class="spec-list">
							<div>
								<dt>컬러</dt>
								<dd>Grey / Purple</dd>
							</div>
							<div>
								<dt>스타일코드</dt>
								<dd>KH6245</dd>
							</div>
							<div>
								<dt>발볼 넓이</dt>
								<dd>D(보통)</dd>
							</div>
							<div>
								<dt>소재</dt>
								<dd>메시 / 스웨이드 / 고무</dd>
							</div>
						</dl>
					</div>
					<button type="button" class="more-button js-more-toggle" data-target="infoContent">더보기</button>
				</div>
				<div class="tab-panel" id="review">
					<div class="tab-heading-row">
						<div>
							<h2>상품리뷰(128)</h2>
							<p>구매 완료 회원만 리뷰를 등록할 수 있습니다.</p>
						</div>
						<button type="button" class="outline-action"
							id="reviewWriteButton">리뷰 등록</button>
					</div>
					<div class="review-summary">
						<strong>★ 4.9</strong>
						<div>
							<b>가볍고 편안한 데일리 운동화</b>
							<p>구매자의 96%가 디자인과 착화감에 만족했어요.</p>
						</div>
					</div>
					<article class="review-card my-review owner-post">
						<div class="review-card-head">
							<div>
								<b>★★★★★</b><span>내가 작성한 리뷰</span>
							</div>
							<!-- 백엔드 연결 시 로그인 회원과 작성자가 같은 글에만 이 메뉴를 출력하세요. -->
							<div class="owner-actions">
								<button type="button" class="owner-menu-button"
									aria-label="리뷰 수정 및 삭제 메뉴" aria-expanded="false">⋮</button>
								<div class="owner-menu" role="menu">
									<button type="button" class="owner-edit" role="menuitem">수정하기</button>
									<button type="button" class="owner-delete" role="menuitem">삭제하기</button>
								</div>
							</div>
						</div>
						<p class="editable-content">색상이 사진과 같고 발을 안정적으로 잡아줘요. 평소 사이즈로
							구매했는데 잘 맞았습니다.</p>
						<small>김**** · 그레이/퍼플 · 255mm · 2026. 7. 28.</small>
					</article>
					<article class="review-card">
						<div class="review-card-head">
							<b>★★★★★</b>
						</div>
						<p>가볍고 코디하기 쉬워서 자주 신게 됩니다. 배송과 포장도 깔끔했어요.</p>
						<small>이**** · 블랙/화이트 · 240mm · 2026. 7. 19.</small>
					</article>

					<div>
						<a> 전체 보기 </a>
					</div>
				</div>

				<div class="tab-panel" id="question">
					<div class="tab-heading-row question-title">
						<div>
							<h2>상품 Q&amp;A(12)</h2>
							<p>문의 내용은 작성자 본인과 관리자만 열람하도록 설정할 수 있습니다.</p>
						</div>
						<button type="button" class="outline-action" id="questionButton">문의
							등록</button>
					</div>
					<ul class="question-list">
						<li class="owner-post my-question"><span
							class="question-content"><b>배송</b><span
								class="editable-content">비공개 문의글입니다. 🔒</span></span>
							<div class="question-side">
								<small>답변완료</small>
								<!-- 백엔드 연결 시 로그인 회원과 작성자가 같은 글에만 이 메뉴를 출력하세요. -->
								<div class="owner-actions">
									<button type="button" class="owner-menu-button"
										aria-label="문의 수정 및 삭제 메뉴" aria-expanded="false">⋮</button>
									<div class="owner-menu" role="menu">
										<button type="button" class="owner-edit" role="menuitem">수정하기</button>
										<button type="button" class="owner-delete" role="menuitem">삭제하기</button>
									</div>
								</div>
							</div></li>
						<li><span class="question-content"><b>사이즈</b><span>키즈
									220과 성인 220의 차이가 있나요?</span></span><small>답변완료</small></li>
						<li><span class="question-content"><b>재입고</b><span>퍼플
									260 사이즈 일정이 궁금합니다. 🔒</span></span><small>답변대기</small></li>
					</ul>

					<div>
						<a> 전체 보기 </a>
					</div>
				</div>

				<div class="guide-list">
					<details>
						<summary>배송 및 반품</summary>
						<p>결제 완료 후 영업일 기준 2~4일 이내 배송됩니다. 단순 변심 반품은 수령 후 7일 이내 신청할 수
							있으며, 상품과 포장 상태가 훼손된 경우 반품이 제한될 수 있습니다.</p>
					</details>
					<details>
						<summary>세탁 및 손질방법</summary>
						<p>물세탁과 세탁기 사용은 피해주세요. 부드러운 솔로 먼지를 제거하고 오염 부위는 중성세제를 묻힌 천으로
							가볍게 닦은 뒤 그늘에서 건조해주세요.</p>
					</details>
					<details>
						<summary>A/S 안내</summary>
						<p>품질보증 기간은 구매일로부터 6개월입니다. 상품 상태에 따라 수선 가능 여부와 비용이 달라질 수 있으므로
							고객센터에 먼저 문의해주세요.</p>
					</details>
				</div>

			</div>
		</section>

		<section class="recommend-section page-width">
			<h2>이런 상품은 어때요</h2>
			<div class="product-grid collapsed" id="recommendGrid">
				<!-- 팀에서 연결할 주소가 정해지면 아래 href만 변경하면 됩니다. -->
				<a class="product-card" href="${ctx}/product/detail?product=1">
					<img src="${ctx}/dist/images/product-detail/shoe-1.png"
					alt="나이키 에어포스 1 로우" /> <b>NIKE</b>
					<p>나이키 에어포스 1 로우</p> <strong>139,000원</strong>
				</a> <a class="product-card" href="${ctx}/product/detail?product=2">
					<img src="${ctx}/dist/images/product-detail/shoe-2.png"
					alt="아디다스 삼바 OG" /> <b>ADIDAS</b>
					<p>아디다스 삼바 OG</p> <strong>149,000원</strong>
				</a> <a class="product-card" href="${ctx}/product/detail?product=3">
					<img src="${ctx}/dist/images/product-detail/shoe-3.png"
					alt="뉴발란스 2002R" /> <b>NEW BALANCE</b>
					<p>뉴발란스 2002R</p> <strong>159,000원</strong>
				</a> <a class="product-card" href="${ctx}/product/detail?product=4">
					<img src="${ctx}/dist/images/product-detail/shoe-4.png"
					alt="아식스 젤 카야노" /> <b>ASICS</b>
					<p>아식스 젤 카야노</p> <strong>169,000원</strong>
				</a> <a class="product-card" href="${ctx}/product/detail?product=5">
					<img src="${ctx}/dist/images/product-detail/shoe-5.png"
					alt="나이키 덩크 로우" /> <b>NIKE</b>
					<p>나이키 덩크 로우</p> <strong>129,000원</strong>
				</a> <a class="product-card extra-card"
					href="${ctx}/product/detail?product=6"> <img
					src="${ctx}/dist/images/product-detail/shoe-6.png" alt="푸마 스피드캣" />
					<b>PUMA</b>
					<p>푸마 스피드캣</p> <strong>119,000원</strong>
				</a> <a class="product-card extra-card"
					href="${ctx}/product/detail?product=7"> <img
					src="${ctx}/dist/images/product-detail/shoe-7.png" alt="컨버스 척 70" />
					<b>CONVERSE</b>
					<p>컨버스 척 70</p> <strong>99,000원</strong>
				</a> <a class="product-card extra-card"
					href="${ctx}/product/detail?product=8"> <img
					src="${ctx}/dist/images/product-detail/shoe-8.png" alt="반스 올드스쿨" />
					<b>VANS</b>
					<p>반스 올드스쿨</p> <strong>89,000원</strong>
				</a>
			</div>
			<button type="button" class="more-button js-more-toggle" data-target="recommendGrid">더보기</button>
		</section>
	</main>

	<div class="modal-backdrop" id="colorModal" aria-hidden="true">
		<section class="modal-card" role="dialog" aria-modal="true"
			aria-labelledby="colorTitle">

			<div class="color-grid" id="colorGrid">
				<button type="button" data-color="그레이 / 퍼플"
					data-color-key="grey-purple">
					<span class="color-chip grey-purple"></span><b>그레이 / 퍼플</b><small>재고
						있음</small>
				</button>
				<button type="button" data-color="블랙 / 화이트"
					data-color-key="black-white">
					<span class="color-chip black-white"></span><b>블랙 / 화이트</b><small>재고
						있음</small>
				</button>
				<button type="button" data-color="크림 / 그린"
					data-color-key="cream-green">
					<span class="color-chip cream-green"></span><b>크림 / 그린</b><small>재고
						적음</small>
				</button>
				<button type="button" data-color="블랙" data-color-key="solid-black">
					<span class="color-chip solid-black"></span><b>블랙</b><small>재고
						있음</small>
				</button>
				<button type="button" data-color="화이트" data-color-key="solid-white">
					<span class="color-chip solid-white"></span><b>화이트</b><small>재고
						있음</small>
				</button>
				<button type="button" data-color="그레이" data-color-key="solid-grey">
					<span class="color-chip solid-grey"></span><b>그레이</b><small>재고
						있음</small>
				</button>
				<button type="button" data-color="퍼플" data-color-key="solid-purple">
					<span class="color-chip solid-purple"></span><b>퍼플</b><small>재고
						적음</small>
				</button>
			</div>
		</section>
	</div>

	<div class="modal-backdrop" id="sizeModal" aria-hidden="true">
		<section class="modal-card size-modal" role="dialog" aria-modal="true"
			aria-labelledby="sizeTitle">
			<header>
				<div>
					<h2 id="sizeTitle">사이즈 선택</h2>
					<p>평소 착용하는 사이즈를 확인해 주세요.</p>
				</div>
				<button type="button" class="modal-close" aria-label="닫기">×</button>
			</header>
			<div class="size-grid" id="sizeGrid">
				<button type="button" data-size="220">
					220<small>재고 3</small>
				</button>
				<button type="button" data-size="225">
					225<small>재고 5</small>
				</button>
				<button type="button" data-size="230">
					230<small>재고 2</small>
				</button>
				<button type="button" data-size="235">
					235<small>재고 6</small>
				</button>
				<button type="button" data-size="240">
					240<small>재고 4</small>
				</button>
				<button type="button" data-size="245">
					245<small>재고 8</small>
				</button>
				<button type="button" data-size="250">
					250<small>재고 5</small>
				</button>
				<button type="button" data-size="255">
					255<small>재고 7</small>
				</button>
				<button type="button" data-size="260">
					260<small>재고 8</small>
				</button>
				<button type="button" data-size="265">
					265<small>재고 3</small>
				</button>
				<button type="button" data-size="270">
					270<small>재고 4</small>
				</button>
				<button type="button" data-size="275" class="soldout" disabled>
					275<small>품절</small>
				</button>
				<button type="button" data-size="280">
					280<small>재고 2</small>
				</button>
				<button type="button" data-size="285" class="soldout" disabled>
					285<small>품절</small>
				</button>
				<button type="button" data-size="290">
					290<small>재고 1</small>
				</button>
			</div>
		</section>
	</div>

	<div class="modal-backdrop" id="productCouponModal" aria-hidden="true">
		<section class="modal-card product-coupon-modal" role="dialog"
			aria-modal="true" aria-labelledby="productCouponTitle">
			<header>
				<div>
					<h2 id="productCouponTitle">쿠폰 적용</h2>
					<p>보유 쿠폰을 선택하거나 발급 가능한 쿠폰을 받은 뒤 할인 금액을 확인하세요.</p>
				</div>
				<button type="button" class="modal-close" aria-label="닫기">×</button>
			</header>

			<div class="product-coupon-product">
				<img src="${ctx}/dist/images/product-detail/main-shoe.png"
					alt="아디다스 ZX 8000" />
				<div>
					<small>ADIDAS</small> <strong>아디다스 ZX 8000 그레이 투 퍼플</strong>
					<p>판매가 130,000원</p>
				</div>
			</div>

			<label class="product-coupon-field"> <span>보유 쿠폰</span> <select
				id="productCouponSelect">
					<option value="none">쿠폰을 적용하지 않음</option>
					<option value="rate10">10% 할인 쿠폰 · 최대 20,000원</option>
					<option value="fixed15">15,000원 할인 쿠폰</option>
					<option value="issued5" id="issuedProductCouponOption" hidden
						disabled>상품 전용 5% 할인 쿠폰</option>
			</select>
			</label>

			<div class="product-issue-coupon">
				<div>
					<b>발급 가능 쿠폰</b> <span>상품 전용 5% 할인 쿠폰</span>
				</div>
				<button type="button" id="productCouponIssue">쿠폰 받기</button>
			</div>

			<div class="product-coupon-preview">
				<div>
					<span>상품 판매가</span><b>130,000원</b>
				</div>
				<div>
					<span>쿠폰 할인</span><b id="productCouponPreviewDiscount">0원</b>
				</div>
				<div class="is-final">
					<span>쿠폰 적용가</span><strong id="productCouponPreviewPrice">130,000원</strong>
				</div>
			</div>

			<button type="button" class="product-coupon-apply"
				id="productCouponApply">적용하기</button>
		</section>
	</div>

	<div class="toast" id="productToast" role="status" aria-live="polite"></div>


	<jsp:include page="/WEB-INF/views/common/footer.jsp" />


	<script
		src="${pageContext.request.contextPath}/dist/js/pages/product/detail.js?v=20260806-price-coupon-1"></script>
	<script
		src="${pageContext.request.contextPath}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
