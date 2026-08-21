<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="adminPage" value="member" scope="request" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>회원 제재 등록 | Yongsinsa 관리자</title>

<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp" />

<link rel="stylesheet" href="${ctx}/dist/css/admin/list.css?v=20260813">

<style>
.sanction-page {
	max-width: 850px;
}

.sanction-card {
	padding: 30px;
}

.sanction-info {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	margin-bottom: 25px;
}

.sanction-field {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.sanction-field label {
	font-weight: 700;
}

.sanction-field input, .sanction-field select, .sanction-field textarea
	{
	width: 100%;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 6px;
	box-sizing: border-box;
	font-size: 14px;
}

.sanction-field input[readonly] {
	background: #f7f7f7;
}

.sanction-reason {
	margin-top: 20px;
}

.sanction-field textarea {
	min-height: 130px;
	resize: vertical;
}

#customReasonField {
	margin-top: 15px;
}

.sanction-actions {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 25px;
}

.reason-help {
	font-size: 13px;
	color: #777;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/page-loader.jsp" />
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<jsp:include page="/WEB-INF/views/admin/layout/left.jsp" />
	<main class="admin-main">
		<section class="page active sanction-page">
			<div class="page-heading">
				<div>
					<p>관리자 페이지 / 회원관리 / 회원 제재</p>
					<h1>회원 제재 등록</h1>
					<span>제재 사유를 선택하거나 직접 입력할 수 있습니다.</span>
				</div>
			</div>
			<article class="panel sanction-card">
				<form method="post" action="${ctx}/admin/member/sanction"
					id="sanctionForm">
					<input type="hidden" name="memberId"
						value="<c:out value='${member.memberId}'/>">
					<!-- Controller로 실제 전송되는 제재 사유 -->
					<input type="hidden" name="sanctionReason" id="sanctionReason">
					<div class="sanction-info">
						<div class="sanction-field">
							<label>회원번호</label> <input type="text"
								value="<c:out value='${member.memberId}'/>" readonly>
						</div>
						<div class="sanction-field">
							<label>회원 아이디</label> <input type="text"
								value="<c:out value='${member.userId}'/>" readonly>
						</div>
						<div class="sanction-field">
							<label>회원명</label> <input type="text"
								value="<c:out value='${member.name}'/>" readonly>
						</div>
						<div class="sanction-field">
							<label>현재 상태</label> <input type="text"
								value="<c:out value='${member.status}'/>" readonly>
						</div>
					</div>
					<div class="sanction-field sanction-reason">
						<label for="sanctionReasonSelect"> 제재 사유 * </label> <select
							id="sanctionReasonSelect" required>
							<option value="">제재 사유를 선택하세요</option>
							<option value="비정상 접속 반복">비정상 접속 반복</option>
							<option value="욕설 및 비방">욕설 및 비방</option>
							<option value="부정 주문 및 결제 시도">부정 주문 및 결제 시도</option>
							<option value="서비스 운영 방해">서비스 운영 방해</option>
							<option value="이용약관 위반">이용약관 위반</option>
							<option value="직접입력">직접 입력</option>
						</select> <span class="reason-help"> 목록에 없는 사유는 '직접 입력'을 선택하세요. </span>
					</div>
					<!-- 직접입력을 선택했을 때만 표시 -->
					<div class="sanction-field" id="customReasonField" hidden>
						<label for="customSanctionReason"> 제재 사유 직접 입력 * </label>
						<textarea id="customSanctionReason" maxlength="500"
							placeholder="제재 사유를 직접 입력하세요."></textarea>
						<span class="reason-help"> 최대 500자까지 입력할 수 있습니다. </span>
					</div>
					<c:if test="${param.error eq 'reason'}">
						<p style="color: red;">제재 사유를 선택하거나 직접 입력해 주세요.</p>
					</c:if>
					<div class="sanction-actions">
						<a class="light-btn" href="${ctx}/admin/member"> 취소 </a>
						<button type="submit" class="primary-btn">제재 등록</button>
					</div>
				</form>
			</article>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp" />

	<script>
		document.addEventListener("DOMContentLoaded", function() {

			var form = document.getElementById("sanctionForm");
			var reasonSelect = document.getElementById("sanctionReasonSelect");
			var customField = document.getElementById("customReasonField");
			var customReason = document.getElementById("customSanctionReason");
			var sanctionReason = document.getElementById("sanctionReason");
			if (!form || !reasonSelect) {
				return;
			}

			// 제재 사유 선택 변경
			reasonSelect.addEventListener("change", function() {

				if (this.value === "직접입력") {
					customField.hidden = false;
					customReason.required = true;

					setTimeout(function() {
						customReason.focus();
					}, 0);

				} else {
					customField.hidden = true;
					customReason.required = false;
					customReason.value = "";
				}
			});

			// 제재 등록
			form.addEventListener("submit",
					function(e) {
						var selectedReason = reasonSelect.value;
						var finalReason = "";
						if (!selectedReason) {
							e.preventDefault();
							alert("제재 사유를 선택해 주세요.");
							reasonSelect.focus();
							return;
						}

						// 직접 입력
						if (selectedReason === "직접입력") {
							finalReason = customReason.value.trim();
							if (!finalReason) {
								e.preventDefault();
								alert("제재 사유를 직접 입력해 주세요.");
								customReason.focus();
								return;
							}
						} else {
							// 선택한 사유
							finalReason = selectedReason;
						}
						// hidden input에 최종 제재 사유 저장
						sanctionReason.value = finalReason;
						if (!confirm("이 회원을 제재하시겠습니까?\n\n" + "제재 사유 : "
								+ finalReason)) {
							e.preventDefault();
						}
					});

		});
	</script>

</body>
</html>