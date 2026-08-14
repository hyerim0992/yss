<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!doctype html>
<html lang="ko">

<head>

	<meta charset="UTF-8">
	<meta name="viewport"
		content="width=device-width, initial-scale=1">

	<title>비밀번호 찾기 | 용신사</title>

	<jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
	<link rel="stylesheet" href="${ctx}/dist/css/pages/member/login.css">
	<link rel="stylesheet" href="${ctx}/dist/css/common/layout.css">
</head>
<body class="has-site-layout ys-login-body">
	<jsp:include
		page="/WEB-INF/views/common/header.jsp" />
	<main class="ys-login-page">
		<section class="ys-login-title">
			<h2>비밀번호 찾기</h2>
			<p>	회원정보 확인 후 새 비밀번호를 설정해 주세요. </p>
		</section>
		<section class="ys-login-section">
			<div class="ys-login-container">
				<div class="ys-login-wrap">
					<article class="ys-login-box">
						<div class="ys-login-heading">
							<span class="ys-login-eyebrow">
								RESET PASSWORD
							</span>
							<h3>비밀번호 재설정</h3>
						</div>
						<c:if test="${empty success}">
							<form action="${ctx}/member/findPassword" method="post">
								<div class="ys-form-group">
									<label for="userId"> 아이디 </label>
									<input type="text" id="userId" name="userId" required>
								</div>
								<div class="ys-form-group">
									<label for="name"> 이름 </label>
									<input type="text" id="name" name="name" required>
								</div>
								<div class="ys-form-group">
									<label for="email"> 이메일 </label>
									<input type="email" id="email" name="email" required>
								</div>
								<div class="ys-form-group">
									<label for="password"> 새 비밀번호 </label>
									<input type="password" id="password" name="password" required>
								</div>
								<div class="ys-form-group">
									<label for="passwordConfirm"> 새 비밀번호 확인 </label>
									<input type="password" id="passwordConfirm" name="passwordConfirm" required>
								</div>
								<button type="submit" class="ys-login-btn"> 비밀번호 변경 </button>
							</form>
						</c:if>
						<c:if test="${not empty message}">
							<p class="ys-login-status is-error"> ${message} </p>
						</c:if>
						<c:if test="${success}">
							<div class="ys-login-heading">
								<h3> 비밀번호가 변경되었습니다. </h3>
								<p> 새 비밀번호로 로그인해 주세요. </p>
							</div>
						</c:if>
						<div class="ys-join-area">
							<a href="${ctx}/member/login" class="ys-join-btn">
								로그인으로 돌아가기
							</a>
						</div>
					</article>
				</div>
			</div>
		</section>
	</main>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>