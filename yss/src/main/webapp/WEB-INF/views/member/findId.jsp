<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!doctype html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>아이디 찾기 | 용신사</title>
	<jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
	<link rel="stylesheet" href="${ctx}/dist/css/pages/member/login.css">
	<link rel="stylesheet" href="${ctx}/dist/css/common/layout.css">
</head>

<body class="has-site-layout ys-login-body">
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main class="ys-login-page">
		<section class="ys-login-title">
			<h2>아이디 찾기</h2>
			<p>가입할 때 입력한 이름과 이메일을 입력해 주세요.</p>
		</section>
		<section class="ys-login-section">
			<div class="ys-login-container">
				<div class="ys-login-wrap">
					<article class="ys-login-box">
						<div class="ys-login-heading">
							<span class="ys-login-eyebrow">
								FIND ID
							</span>
							<h3>아이디 찾기</h3>
						</div>
						<c:if test="${empty foundUserId}">
							<form action="${ctx}/member/findId" method="post">
								<div class="ys-form-group">
									<label for="name"> 이름 </label>
									<input type="text" id="name" name="name" placeholder="이름을 입력해 주세요" 	required>
								</div>
								<div class="ys-form-group">
									<label for="email"> 이메일 </label>
									<input type="email" id="email" name="email" placeholder="이메일을 입력해 주세요" required>
								</div>
								<button type="submit" class="ys-login-btn"> 아이디 찾기 </button>
							</form>
						</c:if>
						<c:if test="${not empty message}">
							<p class="ys-login-status is-error"> ${message} </p>
						</c:if>
						<c:if test="${not empty foundUserId}">
							<div class="ys-login-heading">
								<p> 회원님의 아이디는 </p>
								<h3> ${foundUserId} </h3>
							</div>
						</c:if>
						<div class="ys-join-area">
							<a href="${ctx}/member/login" class="ys-join-btn"> 로그인으로 돌아가기 </a>
						</div>
					</article>
				</div>
			</div>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	
</body>
</html>