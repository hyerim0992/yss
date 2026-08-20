<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/head-styles.jsp" />

<link rel="stylesheet" href="${ctx}/dist/css/pages/customer/contact.css" />

<link rel="stylesheet" href="${ctx}/dist/css/common/layout.css" />

<style>
.notice-detail-panel {
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 22px;
	margin-top: 20px;
	background: #fff;
	margin-bottom: 18px;
}

.notice-detail-panel h3 {
	margin: 0;
	font-size: 22px;
}

.notice-detail-date {
	margin: 0;
	color: #777;
	font-size: 14px;
	white-space: nowrap;
}

.notice-detail-content {
	min-height: 200px;
	padding: 20px 0;
}

.notice-detail-file {
	margin-top: 20px;
	padding-top: 15px;
	border-top: 1px solid #eee;
}

.notice-detail-actions {
	display: flex;
	gap: 5px;
	align-items: center;
	margin-top: 30px;
	justify-content: flex-end;
}

.notice-detail-actions a {
	display: inline-block;
	border: 1px solid #ddd;
	background: #fff;
	border-radius: 6px;
	padding: 9px 13px;
	text-decoration: none;
	color: #111;
}

.notice-detail-head {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 20px;
}
</style>

<title>공지사항 상세</title>
</head>

<body class="has-site-layout">

	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<main class="abc-cs-page">
		<div class="abc-cs-wrap">

			<nav class="abc-cs-breadcrumb">
				<a href="${ctx}/index.jsp">HOME</a>
				<span>&gt;</span>
				<strong>고객센터</strong>
			</nav>

			<div class="abc-cs-layout">

				<aside class="abc-cs-sidebar">
					<h1>고객센터</h1>

					<nav class="abc-cs-side-menu">
						<a href="${ctx}/customer/faq/list">자주 묻는 질문</a>
						<a href="${ctx}/customer/notice/list" class="is-active">공지사항</a>
						<a href="${ctx}/customer/inquiry/list">1:1 문의</a>
						<a href="${ctx}/customer/qna/list">상품문의</a>
					</nav>

					<div class="abc-cs-contact-box">
						<span>CS CENTER</span>
						<strong>1588-9667</strong>
						<p>평일 09:00 - 18:00</p>
						<p>점심 12:00 - 13:00</p>
						<p class="muted">주말·공휴일 휴무</p>
					</div>
				</aside>

				<div class="abc-cs-content">
					<section class="abc-cs-view is-active">

						<header class="abc-cs-section-head">
							<div>
								<h2>공지사항</h2>
								<p>서비스 운영과 이벤트 관련 주요 안내를 확인하세요.</p>
							</div>
						</header>

						<div class="notice-detail-panel">
							<div class="notice-detail-head">
								<h3><c:out value="${dto.title}" /></h3>
								<div class="notice-detail-date">작성일 : <c:out value="${dto.createDate}" /></div>
							</div>

							<hr>

							<div class="notice-detail-content">${dto.content}</div>

							<div class="notice-detail-file">
								<c:if test="${listFile.size() != 0}">
							
									<details>
										<summary>첨부파일 <span>${listFile.size()}</span></summary>
							
										<c:forEach var="vo" items="${listFile}">
											<div>
												<a href="${ctx}/customer/notice/download?fileId=${vo.fileId}" class="text-reset" data-no-page-loader download>${vo.files}</a>
											</div>
										</c:forEach>
									</details>
							
								</c:if>
							</div>

							<div class="notice-detail-actions">
								<a href="${ctx}/customer/notice/list">목록</a>
							</div>
						</div>

					</section>
				</div>

			</div>
		</div>
	</main>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>