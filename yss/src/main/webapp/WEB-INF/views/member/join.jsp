<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!doctype html>
<html class="no-js" lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<title>회원가입 | 용신사</title>
	<meta name="description" content="용신사 회원가입">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" type="image/x-icon" href="${ctx}/dist/images/favicon.ico">

	<!-- 기존 공통 스타일 -->
	<!-- join.css가 캐시되거나 기존 테마에 덮여도 회원가입 영역이 보이도록 하는 최소 표시 스타일 -->
    <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
	<style>
		main.ys-join-page,
		.ys-join-page .ys-join-title,
		.ys-join-page .ys-join-section,
		.ys-join-page .ys-join-wrap,
		.ys-join-page #joinForm {
			display: block !important;
			visibility: visible !important;
			opacity: 1 !important;
		}
		.ys-join-page,
		.ys-join-page button,
		.ys-join-page input,
		.ys-join-page select,
		.ys-join-page textarea {
			font-family: "Malgun Gothic", "맑은 고딕", Arial, sans-serif !important;
		}
	</style>




    

    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/member/join.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/layout.css?v=20260806-0140" />
</head>
<body class="has-site-layout">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />




<main class="ys-join-page">
	<section class="ys-join-title">
		<div class="container">
			<h2>JOIN</h2>
			<p>용신사 회원이 되어 다양한 혜택을 만나보세요.</p>
		</div>
	</section>

	<section class="ys-join-section">
		<div class="container">
			<div class="ys-join-wrap">
				<div class="ys-join-heading">
					<h3>회원정보 입력</h3>
					<p><span class="ys-required">*</span> 표시는 필수 입력 항목입니다.</p>
				</div>

				<c:if test="${not empty joinError}">
					<div class="ys-server-message ys-server-message--error" role="alert"><c:out value="${joinError}" /></div>
				</c:if>

				<form id="joinForm" action="${ctx}/members/join" method="post" novalidate
					  data-context-path="${ctx}" data-id-check-url="${ctx}/api/members/check-id">
					<c:if test="${not empty _csrf}">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					</c:if>

					<div class="ys-form-row">
						<label for="memberId">아이디 <span class="ys-required">*</span></label>
						<div class="ys-field-area">
							<div class="ys-input-button">
								<input type="text" id="memberId" name="memberId" minlength="4" maxlength="20"
									   autocomplete="username" placeholder="영문 소문자와 숫자 4~20자" required aria-describedby="memberIdMessage">
								<button type="button" id="checkIdBtn" class="ys-outline-btn">중복확인</button>
							</div>
							<p id="memberIdMessage" class="ys-field-message" aria-live="polite"></p>
						</div>
					</div>

					<div class="ys-form-row">
						<label for="password">비밀번호 <span class="ys-required">*</span></label>
						<div class="ys-field-area">
							<input type="password" id="password" name="password" minlength="8" maxlength="30"
								   autocomplete="new-password" placeholder="영문, 숫자, 특수문자를 포함한 8~30자" required aria-describedby="passwordMessage">
							<p id="passwordMessage" class="ys-field-message">영문, 숫자, 특수문자를 각각 1자 이상 포함해 주세요.</p>
						</div>
					</div>

					<div class="ys-form-row">
						<label for="passwordConfirm">비밀번호 확인 <span class="ys-required">*</span></label>
						<div class="ys-field-area">
							<input type="password" id="passwordConfirm" name="passwordConfirm" maxlength="30"
								   autocomplete="new-password" placeholder="비밀번호를 다시 입력해 주세요." required aria-describedby="passwordConfirmMessage">
							<p id="passwordConfirmMessage" class="ys-field-message" aria-live="polite"></p>
						</div>
					</div>

					<div class="ys-form-row">
						<label for="memberName">이름 <span class="ys-required">*</span></label>
						<div class="ys-field-area">
							<input type="text" id="memberName" name="memberName" maxlength="30" autocomplete="name"
								   placeholder="이름을 입력해 주세요." required aria-describedby="memberNameMessage">
							<p id="memberNameMessage" class="ys-field-message" aria-live="polite"></p>
						</div>
					</div>

					<div class="ys-form-row">
						<label for="email">이메일 <span class="ys-required">*</span></label>
						<div class="ys-field-area">
							<input type="email" id="email" name="email" maxlength="100" autocomplete="email"
								   placeholder="example@yongsinsa.com" required aria-describedby="emailMessage">
							<p id="emailMessage" class="ys-field-message" aria-live="polite"></p>
						</div>
					</div>

					<div class="ys-form-row">
						<label for="phone">휴대폰 <span class="ys-required">*</span></label>
						<div class="ys-field-area">
							<input type="tel" id="phone" name="phone" maxlength="13" inputmode="numeric" autocomplete="tel"
								   placeholder="010-1234-5678" required aria-describedby="phoneMessage">
							<p id="phoneMessage" class="ys-field-message" aria-live="polite"></p>
						</div>
					</div>

					<div class="ys-form-row ys-address-row">
						<label for="postalCode">주소 <span class="ys-required">*</span></label>
						<div class="ys-field-area">
							<div class="ys-input-button ys-postcode-line">
								<input type="text" id="postalCode" name="postalCode" maxlength="5" placeholder="우편번호" readonly required>
								<button type="button" id="findAddressBtn" class="ys-outline-btn">우편번호 찾기</button>
							</div>
							<input type="text" id="address" name="address" maxlength="200" placeholder="기본주소" readonly required>
							<input type="text" id="addressDetail" name="addressDetail" maxlength="100" autocomplete="street-address"
								   placeholder="상세주소를 입력해 주세요." required aria-describedby="addressMessage">
							<p id="addressMessage" class="ys-field-message" aria-live="polite"></p>
						</div>
					</div>

					<div class="ys-form-row">
						<label for="birthDate">생년월일 <span class="ys-required">*</span></label>
						<div class="ys-field-area">
							<input type="date" id="birthDate" name="birthDate" autocomplete="bday" required aria-describedby="birthDateMessage">
							<p id="birthDateMessage" class="ys-field-message" aria-live="polite"></p>
						</div>
					</div>

					<fieldset class="ys-form-row ys-radio-row">
						<legend>성별 <span class="ys-required">*</span></legend>
						<div class="ys-field-area ys-choice-list" id="genderGroup">
							<label class="ys-choice"><input type="radio" name="gender" value="M" required><span>남성</span></label>
							<label class="ys-choice"><input type="radio" name="gender" value="F"><span>여성</span></label>
							<label class="ys-choice"><input type="radio" name="gender" value="N"><span>선택 안 함</span></label>
							<p id="genderMessage" class="ys-field-message" aria-live="polite"></p>
						</div>
					</fieldset>

					<div class="ys-agreement-section">
						<div class="ys-agreement-heading">
							<h3>약관 동의</h3>
							<p>필수 약관에 동의해야 회원가입이 가능합니다.</p>
						</div>

						<label class="ys-agree-all">
							<input type="checkbox" id="agreeAll">
							<span><strong>전체 동의</strong><small>선택 항목을 포함한 모든 약관에 동의합니다.</small></span>
						</label>

						<div class="ys-agreement-list">
							<div class="ys-agreement-item">
								<label><input type="checkbox" class="ys-agree-item ys-required-agreement" id="agreeTerms" name="agreeTerms" value="Y" required><span><b>[필수]</b> 이용약관 동의</span></label>
								<a href="#terms" target="_blank" rel="noopener">내용보기</a>
							</div>
							<div class="ys-agreement-item">
								<label><input type="checkbox" class="ys-agree-item ys-required-agreement" id="agreePrivacy" name="agreePrivacy" value="Y" required><span><b>[필수]</b> 개인정보 수집 및 이용 동의</span></label>
								<a href="#privacy" target="_blank" rel="noopener">내용보기</a>
							</div>
							<div class="ys-agreement-item">
								<label><input type="checkbox" class="ys-agree-item" id="agreeMarketing" name="agreeMarketing" value="Y"><span><em>[선택]</em> 마케팅 정보 수신 동의</span></label>
								<a href="#marketing" target="_blank" rel="noopener">내용보기</a>
							</div>
						</div>
						<p id="agreementMessage" class="ys-field-message" aria-live="polite"></p>
					</div>

					<div class="ys-join-actions">
						<a href="${ctx}/member/login" class="ys-cancel-btn">취소</a>
						<button type="submit" class="ys-submit-btn">회원가입</button>
					</div>
				</form>
			</div>
		</div>
	</section>
</main>



<!-- 기존 공통 스크립트 -->
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

<!-- 주소 검색 및 회원가입 전용 스크립트 -->
<script src="https://t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    

    <script src="${pageContext.request.contextPath}/dist/js/pages/member/join.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
