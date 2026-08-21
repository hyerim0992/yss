<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="isMember" value="${not empty sessionScope.member or param.preview eq 'member'}" />
<c:set var="isAdmin" value="${not empty sessionScope.member and sessionScope.member.role == 5}" />

<jsp:include page="/WEB-INF/views/common/page-loader.jsp" />

<!-- 원래 index.jsp의 헤더 UI를 유지하면서 로그인 상태 메뉴만 추가 -->
<header class="ys-global-header" data-global-header
	data-context-path="${ctx}" data-server-authenticated="${isMember}"
	data-login-url="${ctx}/member/login" data-mypage-url="${ctx}/mypage"
	data-logout-url="${ctx}/member/logout">
	<div class="header-area">
		<div class="main-header">
			<div class="header-bottom header-sticky">
				<div class="container-fluid">
					<div class="row align-items-center">
						<div class="col-xl-1 col-lg-1 col-md-1 col-sm-3 ys-header-logo-column">
							<div class="logo ys-header-logo">
								<a href="${ctx}/index.jsp" class="ys-header-logo-link"
									aria-label="용신사 홈으로 이동"><img
									src="${ctx}/dist/images/logo/logo.png" alt="YONGSINSA"></a>
							</div>
						</div>

						<div class="${isAdmin ? 'col-xl-5' : 'col-xl-6'} col-lg-8 col-md-7 col-sm-5">
							<div class="main-menu f-right d-none d-lg-block">
								<nav>
									<ul id="navigation">
										<li><a href="${ctx}/product/category?sort=new">NEW</a>
											<ul class="submenu">
												<li><a href="${ctx}/product/category?type=sneakers&sort=new">스니커즈</a></li>
												<li><a href="${ctx}/product/category?type=sports&sort=new">스포츠</a></li>
												<li><a href="${ctx}/product/category?type=dress&sort=new">구두</a></li>
												<li><a href="${ctx}/product/category?type=casual&sort=new">캐주얼</a></li>
												<li><a href="${ctx}/product/category?type=sandals&sort=new">샌들</a></li>
												<li><a href="${ctx}/product/category?type=boots&sort=new">부츠</a></li>
											</ul></li>
										<li><a href="${ctx}/product/category?audience=man">MEN</a>
											<ul class="submenu">
												<li><a href="${ctx}/product/category?type=sneakers&audience=man">스니커즈</a></li>
												<li><a href="${ctx}/product/category?type=sports&audience=man">스포츠</a></li>
												<li><a href="${ctx}/product/category?type=dress&audience=man">구두</a></li>
												<li><a href="${ctx}/product/category?type=casual&audience=man">캐주얼</a></li>
												<li><a href="${ctx}/product/category?type=sandals&audience=man">샌들</a></li>
												<li><a href="${ctx}/product/category?type=boots&audience=man">부츠</a></li>
											</ul></li>
										<li><a href="${ctx}/product/category?audience=woman">WOMEN</a>
											<ul class="submenu">
												<li><a href="${ctx}/product/category?type=sneakers&audience=woman">스니커즈</a></li>
												<li><a href="${ctx}/product/category?type=sports&audience=woman">스포츠</a></li>
												<li><a href="${ctx}/product/category?type=dress&audience=woman">구두</a></li>
												<li><a href="${ctx}/product/category?type=casual&audience=woman">캐주얼</a></li>
												<li><a href="${ctx}/product/category?type=sandals&audience=woman">샌들</a></li>
												<li><a href="${ctx}/product/category?type=boots&audience=woman">부츠</a></li>
											</ul></li>
										<li><a href="${ctx}/product/category?audience=kids">KIDS</a>
											<ul class="submenu">
												<li><a href="${ctx}/product/category?type=sneakers&audience=kids">스니커즈</a></li>
												<li><a href="${ctx}/product/category?type=sports&audience=kids">스포츠</a></li>
												<li><a href="${ctx}/product/category?type=dress&audience=kids">구두</a></li>
												<li><a href="${ctx}/product/category?type=casual&audience=kids">캐주얼</a></li>
												<li><a href="${ctx}/product/category?type=sandals&audience=kids">샌들</a></li>
												<li><a href="${ctx}/product/category?type=boots&audience=kids">부츠</a></li>
											</ul></li>
										<li class="header-help-menu"><a href="${ctx}/customer/faq/list" aria-haspopup="true">HELP</a>
											<ul class="submenu header-help-submenu" aria-label="고객센터 하위 메뉴">
												<li><a href="${ctx}/customer/faq/list">자주 묻는 질문</a></li>
												<li><a href="${ctx}/customer/notice/list">공지사항</a></li>
												<li><a href="${ctx}/customer/inquiry/list">1:1 문의</a></li>
												<li><a href="${ctx}/customer/qna/list">상품문의</a></li>
											</ul></li>
										<li class="d-lg-none"><a href="${ctx}/mypage"
											data-mypage-link>MY PAGE</a></li>
										<li class="d-lg-none ${isMember ? 'is-hidden' : ''}"
											data-mobile-login-item><a href="${ctx}/member/login"
											data-login-link>로그인</a>
										</li>
										<li class="d-lg-none ${isMember ? '' : 'is-hidden'}"
											data-mobile-logout-item><a href="${ctx}/member/logout"
											data-logout-link>로그아웃</a>
										</li>	
										<c:if
											test="${not empty sessionScope.member && sessionScope.member.role == 5}">
											<li class="d-lg-none"><a href="${ctx}/admin">관리자페이지</a>
											</li>
										</c:if>
									</ul>
								</nav>
							</div>
						</div>

						<div class="${isAdmin ? 'col-xl-6' : 'col-xl-5'} col-lg-3 col-md-3 col-sm-3 fix-card">
							<ul
								class="header-right f-right d-none d-lg-block d-flex justify-content-between">
								<li class="d-none d-xl-block header-search-item">
									<div class="form-box f-right">
										<input type="text" name="Search" placeholder="Search products"
											readonly autocomplete="off" data-open-search
											aria-label="상품 검색 열기">
										<div class="search-icon" data-open-search role="button"
											tabindex="0" aria-label="상품 검색 열기">
											<i class="fas fa-search special-tag"></i>
										</div>
									</div>
								</li>
								<li class="d-none d-xl-block">
									<div class="favorit-items">
										<a href="${ctx}/mypage#wishlist" aria-label="위시리스트"
											data-mypage-section-link="wishlist"><i
											class="far fa-heart"></i></a>
									</div>
								</li>
								<li>
									<div class="shopping-card">
										<a href="${ctx}/mypage#cart" aria-label="장바구니"
											data-mypage-section-link="cart"><i
											class="fas fa-shopping-cart"></i></a>
									</div>
								</li>
								<li class="d-none d-xl-block header-mypage-item"><a
									href="${ctx}/mypage" class="header-auth-link" data-mypage-link>MYPAGE</a>
								</li>
								<li class="d-none d-lg-block ${isMember ? 'is-hidden' : ''}"
									data-desktop-login-item><a href="${ctx}/member/login"
									class="btn header-btn" data-login-link>로그인</a>
								</li>

								<li class="d-none d-lg-block ${isMember ? '' : 'is-hidden'}"
									data-desktop-logout-item><a href="${ctx}/member/logout"
									class="btn header-btn" data-logout-link>로그아웃</a>
								</li>
								<c:if
									test="${not empty sessionScope.member && sessionScope.member.role == 5}">
									<li class="d-none d-lg-block"><a href="${ctx}/admin"
										class="btn header-btn"> 관리자페이지 </a>
									</li>
								</c:if>
							</ul>
						</div>

						<div class="col-12">
							<div class="mobile_menu d-block d-lg-none"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>

<jsp:include page="/WEB-INF/views/common/search-modal.jsp" />
<script
	src="${ctx}/dist/js/pages/product/search.js?v=20260813-jsp-template"
	defer></script>
<script src="${ctx}/dist/js/common/auth-header.js?v=20260806-1420" defer></script>
