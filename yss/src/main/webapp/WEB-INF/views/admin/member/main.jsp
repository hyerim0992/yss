<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="adminPage" value="member" scope="request" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원관리 | Yongsinsa 관리자</title>
<script>
	document.documentElement.classList.add("ys-page-loading");
	window.__ysPageLoaderStart = Date.now();
</script>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/list.css?v=20260813">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/modal.css?v=20260813">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/static-list.css?v=20260813">
</head>
<body data-context-path="${pageContext.request.contextPath}">
	<jsp:include page="/WEB-INF/views/common/page-loader.jsp" />
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />
	<jsp:include page="/WEB-INF/views/admin/layout/left.jsp" />
	<main class="admin-main">
		<section class="page active admin-static-page" data-page-key="member">
			<div class="page-heading">
				<div>
					<p>관리자 페이지 / 회원관리</p>
					<h1>회원관리</h1>
					<span>회원 등록·검색, 제재, 포인트, 쿠폰과 FAQ를 관리합니다.</span>
				</div>
			</div>
			<nav class="sub-tabs" aria-label="회원관리 탭">
				<button type="button" data-section-target="0" class="active">회원
					등록 / 검색</button>
				<button type="button" data-section-target="2" class="">회원
					제재 목록</button>
				<button type="button" data-section-target="3" class="">포인트
					관리</button>
				<button type="button" data-section-target="4" class="">쿠폰
					관리</button>
				<button type="button" data-section-target="5" class="">FAQ
					관리</button>
			</nav>
			<section class="admin-section-panel active" data-admin-section="0"
				data-section-name="회원 등록 / 검색" data-table-title="회원 검색 리스트"
				data-add-label="+ 회원 등록" data-can-add="true">
				<c:if test="${not empty message}">
					<div id="memberResultMessage"
						data-message="<c:out value='${message}'/>" hidden></div>
				</c:if>
				<article class="panel search-panel">
					<form class="search-row" method="get"
						action="${pageContext.request.contextPath}/admin/member">
						<select name="schType" class="js-search-type" aria-label="검색 항목">
							<option value="all" ${schType eq 'all' ? 'selected' : ''}>전체</option>
							<option value="memberId"
								${schType eq 'memberId' ? 'selected' : ''}>회원번호</option>
							<option value="name" ${schType eq 'name' ? 'selected' : ''}>이름</option>
							<option value="userId" ${schType eq 'userId' ? 'selected' : ''}>아이디</option>
							<option value="phone" ${schType eq 'phone' ? 'selected' : ''}>휴대폰</option>
							<option value="email" ${schType eq 'email' ? 'selected' : ''}>이메일</option>
							<option value="status" ${schType eq 'status' ? 'selected' : ''}>상태</option>
						</select> <input type="search" name="kwd" class="js-search-keyword"
							value="<c:out value='${kwd}'/>" placeholder="검색어를 입력하세요">
						<select name="memberStatus" aria-label="회원상태">
							<option value="" ${empty memberStatus ? 'selected' : ''}>상태
								전체</option>
							<option value="일반" ${memberStatus eq '일반' ? 'selected' : ''}>일반</option>
							<option value="접속불가" ${memberStatus eq '접속불가' ? 'selected' : ''}>접속불가</option>
							<option value="삭제" ${memberStatus eq '삭제' ? 'selected' : ''}>삭제회원</option>
						</select>
						<button type="submit" class="dark-btn js-search-button">검색</button>
						<a class="light-btn member-reset-link"
							href="${pageContext.request.contextPath}/admin/member">초기화</a>
					</form>
				</article>
				<article class="panel">
					<div class="panel-title">
						<div>
							<h2>회원 검색 리스트</h2>
							<p>
								검색 결과 <b class="result-count">${dataCount}</b>건
							</p>
						</div>
						<div>
							<button type="button" class="primary-btn" id="addMemberButton">+
								회원 등록</button>
						</div>
					</div>
					<div class="table-wrap">
						<table>
							<thead>
								<tr>
									<th>회원번호</th>
									<th>이름</th>
									<th>아이디</th>
									<th>휴대폰</th>
									<th>이메일</th>
									<th>권한</th>
									<th>상태</th>
									<th>가입일</th>
									<th>수정일</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody class="data-body">
								<c:forEach var="dto" items="${list}">
									<tr class="data-row">
										<td><c:out value="${dto.memberId}" /></td>
										<td><c:out value="${dto.name}" /></td>
										<td><c:out value="${dto.userId}" /></td>
										<td><c:out value="${dto.phone}" /></td>
										<td><c:out value="${dto.email}" /></td>
										<td><c:choose>
												<c:when test="${dto.role eq 1}">
													<span class="badge gray">회원</span>
												</c:when>
												<c:when test="${dto.role eq 2}">
													<span class="badge green">우수회원</span>
												</c:when>
												<c:when test="${dto.role eq 3}">
													<span class="badge blue">VIP</span>
												</c:when>
												<c:when test="${dto.role eq 4}">
													<span class="badge orange">판매자</span>
												</c:when>
												<c:otherwise>
													<span class="badge blue">관리자</span>
												</c:otherwise>
											</c:choose></td>
										<td><c:choose>
												<c:when test="${not empty dto.deleteAt}">
													<span class="badge gray">삭제</span>
												</c:when>
												<c:when test="${dto.status eq '일반'}">
													<span class="badge green">일반</span>
												</c:when>
												<c:when test="${dto.status eq '접속불가'}">
													<span class="badge orange">접속불가</span>
												</c:when>
												<c:otherwise>
													<span class="badge gray"><c:out
															value="${dto.status}" /></span>
												</c:otherwise>
											</c:choose></td>
										<td><c:out value="${dto.createAt}" /></td>
										<td><c:out value="${dto.updateAt}" /></td>
										<td class="action-cell"><c:choose>
												<c:when test="${not empty dto.deleteAt}">
													<button type="button" class="light-btn restore-member"
														data-member-id="<c:out value='${dto.memberId}'/>"
														data-member-name="<c:out value='${dto.name}'/>">복구</button>
												</c:when>
												<c:otherwise>
													<button type="button" class="light-btn edit-member"
														data-member-id="<c:out value='${dto.memberId}'/>"
														data-user-id="<c:out value='${dto.userId}'/>"
														data-name="<c:out value='${dto.name}'/>"
														data-email="<c:out value='${dto.email}'/>"
														data-phone="<c:out value='${dto.phone}'/>"
														data-birth="<c:out value='${dto.birth}'/>"
														data-role="<c:out value='${dto.role}'/>"
														data-status="<c:out value='${dto.status}'/>"
														data-zip="<c:out value='${dto.zip}'/>"
														data-addr1="<c:out value='${dto.addr1}'/>"
														data-addr2="<c:out value='${dto.addr2}'/>"
														data-bank-name="<c:out value='${dto.bankName}'/>"
														data-refund-account="<c:out value='${dto.refundAccount}'/>"
														data-account-holder="<c:out value='${dto.accountHolder}'/>">수정</button>
													<button type="button"
														class="light-btn delete-member danger-btn"
														data-member-id="<c:out value='${dto.memberId}'/>"
														data-member-name="<c:out value='${dto.name}'/>">삭제</button>
												</c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<c:if test="${empty list}">
						<div class="empty-state show">검색 결과가 없습니다.</div>
					</c:if>
					<c:url var="prevUrl" value="/admin/member">
						<c:param name="page" value="${page - 1}" />
						<c:param name="schType" value="${schType}" />
						<c:param name="kwd" value="${kwd}" />
						<c:param name="memberStatus" value="${memberStatus}" />
					</c:url>
					<c:url var="nextUrl" value="/admin/member">
						<c:param name="page" value="${page + 1}" />
						<c:param name="schType" value="${schType}" />
						<c:param name="kwd" value="${kwd}" />
						<c:param name="memberStatus" value="${memberStatus}" />
					</c:url>
					<div class="pagination" aria-label="목록 페이지 이동">
						<c:choose>
							<c:when test="${page gt 1}">
								<a class="light-btn" href="${prevUrl}">‹ 이전</a>
							</c:when>
							<c:otherwise>
								<button type="button" disabled>‹ 이전</button>
							</c:otherwise>
						</c:choose>
						<span class="page-info">${page} / ${totalPage}</span>
						<c:choose>
							<c:when test="${page lt totalPage}">
								<a class="light-btn" href="${nextUrl}">다음 ›</a>
							</c:when>
							<c:otherwise>
								<button type="button" disabled>다음 ›</button>
							</c:otherwise>
						</c:choose>
					</div>
				</article>
				<div class="modal-backdrop" id="memberModal" aria-hidden="true"
					hidden>
					<section class="admin-modal" role="dialog" aria-modal="true"
						aria-labelledby="memberModalTitle">
						<div class="modal-head">
							<div>
								<p>회원 기본정보, 배송지, 환불계좌를 함께 저장합니다.</p>
								<h2 id="memberModalTitle">회원 등록</h2>
							</div>
							<button type="button" class="modal-close" id="memberModalClose"
								aria-label="닫기">×</button>
						</div>
						<form id="memberForm" method="post"
							action="${pageContext.request.contextPath}/admin/member/write">
							<input type="hidden" name="memberId" id="memberId">
							<div class="form-grid">
								<div class="form-field">
									<label for="memberUserId">아이디 *</label> <input type="text"
										name="userId" id="memberUserId" maxlength="50" required>
								</div>
								<div class="form-field">
									<label for="memberPassword">비밀번호 <span
										id="passwordRequiredMark">*</span></label> <input type="password"
										name="password" id="memberPassword" maxlength="100" required>
									<span class="field-help" id="passwordHelp">신규 등록 시
										필수입니다.</span>
								</div>
								<div class="form-field">
									<label for="memberName">이름 *</label> <input type="text"
										name="name" id="memberName" maxlength="100" required>
								</div>
								<div class="form-field">
									<label for="memberBirth">생년월일 *</label> <input type="date"
										name="birth" id="memberBirth" required>
								</div>
								<div class="form-field">
									<label for="memberPhone">휴대폰 *</label> <input type="text"
										name="phone" id="memberPhone" placeholder="010-1234-5678"
										maxlength="20" required>
								</div>
								<div class="form-field">
									<label for="memberEmail">이메일 *</label> <input type="email"
										name="email" id="memberEmail" maxlength="100" required>
								</div>
								<div class="form-field">
									<label for="memberRole">권한 *</label> <select name="role"
										id="memberRole" required>
										<option value="1">회원</option>
										<option value="2">우수회원</option>
										<option value="3">VIP</option>
										<option value="4">판매자</option>
										<option value="5">관리자</option>
									</select>
								</div>
								<div class="form-field">
									<label for="memberStatus">상태 *</label> <select name="status"
										id="memberStatus" required>
										<option value="일반">일반</option>
										<option value="접속불가">접속불가</option>
									</select>
								</div>

								<div class="form-field">
									<label for="memberZip">우편번호 *</label>
									<div style="display: flex; gap: 8px;">
										<input type="text" name="zip" id="memberZip" maxlength="20"
											placeholder="우편번호" readonly required style="flex: 1;">
										<button type="button" class="light-btn"
											id="memberFindAddressBtn" style="white-space: nowrap;">주소
											검색</button>
									</div>
								</div>
								<div class="form-field">
									<label for="memberAddr1">주소 *</label> <input type="text"
										name="addr1" id="memberAddr1" maxlength="200"
										placeholder="주소 검색을 눌러주세요" readonly required>
								</div>
								<div class="form-field">
									<label for="memberAddr2">상세주소</label> <input type="text"
										name="addr2" id="memberAddr2" maxlength="200"
										placeholder="상세주소를 입력하세요">
								</div>
								<div class="form-field">
									<label for="memberBankName">환불 은행</label> <input type="text"
										name="bankName" id="memberBankName" maxlength="50">
								</div>
								<div class="form-field">
									<label for="memberRefundAccount">환불 계좌번호</label> <input
										type="text" name="refundAccount" id="memberRefundAccount"
										maxlength="100">
								</div>
								<div class="form-field">
									<label for="memberAccountHolder">예금주</label> <input type="text"
										name="accountHolder" id="memberAccountHolder" maxlength="100">
								</div>
							</div>
							<div class="modal-actions">
								<button type="button" class="light-btn" id="memberModalCancel">취소</button>
								<button type="submit" class="primary-btn">저장</button>
							</div>
						</form>
					</section>
				</div>
				<form id="memberDeleteForm" method="post"
					action="${pageContext.request.contextPath}/admin/member/delete"
					hidden>
					<input type="hidden" name="memberId" id="deleteMemberId">
				</form>
				<form id="memberRestoreForm" method="post"
					action="${pageContext.request.contextPath}/admin/member/restore"
					hidden>
					<input type="hidden" name="memberId" id="restoreMemberId">
				</form>
			</section>
			<section class="admin-section-panel" data-admin-section="2"
				data-section-name="회원 제재 목록" data-table-title="회원 제재 목록"
				data-add-label="+ 제재 등록" data-can-add="true" hidden>
				<article class="panel search-panel">

					<form class="search-row" method="get"
						action="${pageContext.request.contextPath}/admin/member">

						<!-- 검색 후 회원 제재 탭 다시 열기 -->
						<input type="hidden" name="tab" value="2"> <label
							for="sanctionStatus"> 제재상태 </label> <select name="sanctionStatus"
							id="sanctionStatus" aria-label="제재상태">

							<option value="" ${empty sanctionStatus ? 'selected' : ''}>
								전체</option>

							<option value="진행중" ${sanctionStatus eq '진행중' ? 'selected' : ''}>
								진행중</option>

							<option value="해제" ${sanctionStatus eq '해제' ? 'selected' : ''}>
								해제</option>

						</select>

						<button type="submit" class="dark-btn">검색</button>

						<a class="light-btn"
							href="${pageContext.request.contextPath}/admin/member?tab=2">
							초기화 </a>

					</form>

				</article>
				<article class="panel">
					<div class="panel-title">
						<div>
							<h2>회원 제재 목록</h2>
							<p>
								검색 결과 <b class="result-count">${sanctionCount}</b>건 · 선택 <b
									id="sanctionSelectedCount">0</b>건
							</p>
						</div>
						<div>
							<button type="button" class="light-btn danger-btn"
								id="deleteSelectedSanctions" disabled>선택 삭제</button>
							<button type="button" class="light-btn export-button" disabled
								title="백엔드 기능 구현 전">CSV 저장</button>
						</div>
					</div>
					<div class="table-wrap">
						<table>
							<thead>
								<tr>
									<th><input type="checkbox" id="sanctionCheckAll"
										aria-label="현재 페이지 전체 선택"></th>
									<th>제재번호</th>
									<th>회원아이디</th>
									<th>회원명</th>
									<th>제재사유</th>
									<th>시작일</th>
									<th>종료일</th>
									<th>상태</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody class="data-body">
								<c:forEach var="dto" items="${sanctionList}">
									<tr class="data-row">
										<td><input type="checkbox" class="sanction-row-check"
											data-sanction-id="${dto.sanctionId}" aria-label="제재 선택"></td>
										<td><c:out value="${dto.sanctionId}" /></td>
										<td><c:out value="${dto.userId}" /></td>
										<td><c:out value="${dto.name}" /></td>
										<td><c:out value="${dto.sanctionReason}" /></td>
										<td><c:out value="${dto.sanctionStartDate}" /></td>
										<td><c:choose>
												<c:when test="${empty dto.sanctionEndDate}">
													-
												</c:when>
												<c:otherwise>
													<c:out value="${dto.sanctionEndDate}" />
												</c:otherwise>
											</c:choose></td>
										<td><c:choose>
												<c:when test="${dto.sanctionStatus eq '진행중'}">
													<span class="badge orange">진행중</span>
												</c:when>
												<c:when test="${dto.sanctionStatus eq '해제'}">
													<span class="badge green">해제</span>
												</c:when>
												<c:otherwise>
													<span class="badge gray"><c:out
															value="${dto.sanctionStatus}" /></span>
												</c:otherwise>
											</c:choose></td>
										<td class="action-cell"><c:choose>
												<c:when test="${dto.sanctionStatus eq '진행중'}">
													<form method="post"
														action="${pageContext.request.contextPath}/admin/member/releaseSanction"
														onsubmit="return confirm('이 회원의 제재를 해제하시겠습니까?');">
														<input type="hidden" name="memberId"
															value="<c:out value='${dto.memberId}'/>">
														<button type="submit" class="light-btn">제재 해제</button>
													</form>
												</c:when>
												<c:when test="${dto.sanctionStatus eq '해제'}">
													<button type="button" class="light-btn"
														onclick="location.href='${pageContext.request.contextPath}/admin/member/sanction?memberId=${dto.memberId}'">
														다시 제재</button>
												</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<form id="sanctionDeleteForm" method="post"
						action="${pageContext.request.contextPath}/admin/member/deleteSanctions"
						hidden></form>
					<c:if test="${empty sanctionList}">
						<div class="empty-state show">제재된 회원이 없습니다.</div>
					</c:if>
					<div class="pagination" aria-label="목록 페이지 이동">
						<button type="button" class="page-prev" aria-label="이전 페이지"
							disabled title="백엔드 기능 구현 전">‹</button>
						<span class="page-info">1 / 1</span>
						<button type="button" class="page-next" aria-label="다음 페이지"
							disabled title="백엔드 기능 구현 전">›</button>
					</div>
				</article>
			</section>
			<section class="admin-section-panel" data-admin-section="3"
				data-section-name="포인트 관리" data-table-title="회원별 포인트 목록"
				data-can-add="false" hidden>
				<article class="panel search-panel">
					<form class="search-row" method="get"
						action="${pageContext.request.contextPath}/admin/member">
						<input type="hidden" name="tab" value="3"> <select
							name="pointSchType" aria-label="검색 항목">
							<option value="all" ${pointSchType eq 'all' ? 'selected' : ''}>전체</option>
							<option value="memberId"
								${pointSchType eq 'memberId' ? 'selected' : ''}>회원번호</option>
							<option value="name" ${pointSchType eq 'name' ? 'selected' : ''}>회원명</option>
							<option value="userId"
								${pointSchType eq 'userId' ? 'selected' : ''}>아이디</option>
						</select> <input type="search" name="pointKwd"
							value="<c:out value='${pointKwd}'/>" placeholder="검색어를 입력하세요">
						<button type="submit" class="dark-btn">검색</button>
						<a class="light-btn"
							href="${pageContext.request.contextPath}/admin/member?tab=3">초기화</a>
					</form>
				</article>
				<article class="panel">
					<div class="panel-title">
						<div>
							<h2>회원별 포인트 목록</h2>
							<p>
								검색 결과 <b class="result-count">${pointCount}</b>건
							</p>
						</div>
					</div>
					<div class="table-wrap">
						<table>
							<thead>
								<tr>
									<th>회원번호</th>
									<th>회원명</th>
									<th>아이디</th>
									<th>보유포인트</th>
									<th>누적적립</th>
									<th>누적사용</th>
									<th>최종변경일</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody class="data-body">
								<c:forEach var="point" items="${pointList}">
									<tr class="data-row">
										<td><c:out value="${point.memberId}" /></td>
										<td><c:out value="${point.name}" /></td>
										<td><c:out value="${point.userId}" /></td>
										<td><c:out value="${point.balance}" /></td>
										<td><c:out value="${point.totalEarn}" /></td>
										<td><c:out value="${point.totalUsed}" /></td>
										<td><c:out value="${point.lastUpdatedAt}" /></td>
										<td class="action-cell">
											<button type="button" class="light-btn adjust-point"
												data-member-id="<c:out value='${point.memberId}'/>"
												data-member-name="<c:out value='${point.name}'/>"
												data-balance="<c:out value='${point.balance}'/>">포인트
												조정</button> <c:url var="pointHistoryUrl" value="/admin/member">
												<c:param name="tab" value="3" />
												<c:param name="pointHistoryMemberId"
													value="${point.memberId}" />
												<c:param name="pointSchType" value="${pointSchType}" />
												<c:param name="pointKwd" value="${pointKwd}" />
											</c:url>

											<button type="button" class="light-btn"
												onclick="location.href='${pointHistoryUrl}'">히스토리</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<c:if test="${empty pointList}">
						<div class="empty-state show">포인트 검색 결과가 없습니다.</div>
					</c:if>
				</article>

				<div class="modal-backdrop" id="pointModal" aria-hidden="true"
					hidden>
					<section class="admin-modal" role="dialog" aria-modal="true"
						aria-labelledby="pointModalTitle">
						<div class="modal-head">
							<div>
								<p id="pointMemberInfo">회원 포인트를 적립하거나 차감합니다.</p>
								<h2 id="pointModalTitle">포인트 조정</h2>
							</div>
							<button type="button" class="modal-close" id="pointModalClose"
								aria-label="닫기">×</button>
						</div>
						<form method="post"
							action="${pageContext.request.contextPath}/admin/member/pointAdjust">
							<input type="hidden" name="memberId" id="pointMemberId">
							<div class="form-grid">
								<div class="form-field">
									<label for="pointType">처리유형 *</label> <select name="type"
										id="pointType" required>
										<option value="적립">적립</option>
										<option value="차감">차감</option>
									</select>
								</div>
								<div class="form-field">
									<label for="pointAmount">포인트 *</label> <input type="number"
										name="amount" id="pointAmount" min="1" required>
								</div>
								<div class="form-field" style="grid-column: 1/-1;">
									<label for="pointReason">사유 *</label> <input type="text"
										name="reason" id="pointReason" maxlength="500"
										placeholder="예: 이벤트 보상, 오지급 정정" required>
								</div>
							</div>
							<div class="modal-actions">
								<button type="button" class="light-btn" id="pointModalCancel">취소</button>
								<button type="submit" class="primary-btn">저장</button>
							</div>
						</form>
					</section>
				</div>

				<c:if test="${not empty pointHistoryMemberId}">
					<div class="modal-backdrop" id="pointHistoryModal"
						data-auto-open="true" aria-hidden="true" hidden>
						<section class="admin-modal" role="dialog" aria-modal="true"
							aria-labelledby="pointHistoryModalTitle"
							style="width: min(1100px, 96vw); max-width: 1100px;">

							<div class="modal-head">
								<div>
									<p>
										회원번호 <b><c:out value="${pointHistoryMemberId}" /></b>
										<c:if test="${not empty pointHistoryMemberName}">
											/ <c:out value="${pointHistoryMemberName}" />
										</c:if>
										<c:if test="${not empty pointHistoryUserId}">
											(<c:out value="${pointHistoryUserId}" />)
										</c:if>
									</p>
									<h2 id="pointHistoryModalTitle">포인트 적립 · 차감 히스토리</h2>
								</div>
								<button type="button" class="modal-close"
									id="pointHistoryModalClose" aria-label="닫기">×</button>
							</div>

							<div style="padding: 0 24px 10px;">
								<p>
									전체 <b><c:out value="${pointHistoryCount}" /></b>건
								</p>
							</div>

							<div class="table-wrap"
								style="margin: 0 24px; max-height: 520px; overflow: auto;">
								<table>
									<thead>
										<tr>
											<th>포인트번호</th>
											<th>구분</th>
											<th>변경포인트</th>
											<th>처리 후 잔액</th>
											<th>사유</th>
											<th>주문번호</th>
											<th>변경일</th>
											<th>만료일</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="history" items="${pointHistoryList}">
											<tr>
												<td><c:out value="${history.pointId}" /></td>
												<td><c:choose>
														<c:when test="${history.amount lt 0}">
															<span class="badge gray"><c:out
																	value="${history.type}" /></span>
														</c:when>
														<c:otherwise>
															<span class="badge green"><c:out
																	value="${history.type}" /></span>
														</c:otherwise>
													</c:choose></td>
												<td><c:if test="${history.amount gt 0}">+</c:if> <c:out
														value="${history.amount}" />P</td>
												<td><c:out value="${history.balance}" />P</td>
												<td><c:out value="${history.reason}" /></td>
												<td><c:out value="${history.orderId}" /></td>
												<td><c:out value="${history.updatedAt}" /></td>
												<td><c:choose>
														<c:when test="${empty history.expiredAt}">-</c:when>
														<c:otherwise>
															<c:out value="${history.expiredAt}" />
														</c:otherwise>
													</c:choose></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

							<c:if test="${empty pointHistoryList}">
								<div class="empty-state show" style="margin: 20px 24px;">
									포인트 적립/차감 이력이 없습니다.</div>
							</c:if>

							<div class="modal-actions">
								<button type="button" class="light-btn"
									id="pointHistoryModalCancel">닫기</button>
							</div>
						</section>
					</div>
				</c:if>
			</section>
			<section class="admin-section-panel" data-admin-section="4"
				data-section-name="쿠폰 관리" data-table-title="쿠폰 목록"
				data-can-add="true" hidden>
				<article class="panel search-panel">
					<form class="search-row" method="get"
						action="${pageContext.request.contextPath}/admin/member">
						<input type="hidden" name="tab" value="4"> <select
							name="couponSchType" aria-label="검색 항목">
							<option value="all" ${couponSchType eq 'all' ? 'selected' : ''}>전체</option>
							<option value="couponId"
								${couponSchType eq 'couponId' ? 'selected' : ''}>쿠폰번호</option>
							<option value="name" ${couponSchType eq 'name' ? 'selected' : ''}>쿠폰명</option>
						</select> <input type="search" name="couponKwd"
							value="<c:out value='${couponKwd}'/>" placeholder="검색어를 입력하세요">
						<input type="search" name="couponStatus"
							value="<c:out value='${couponStatus}'/>"
							placeholder="상태(AVAILABILITY)">
						<button type="submit" class="dark-btn">검색</button>
						<a class="light-btn"
							href="${pageContext.request.contextPath}/admin/member?tab=4">초기화</a>
					</form>
				</article>
				<article class="panel">
					<div class="panel-title">
						<div>
							<h2>쿠폰 목록</h2>
							<p>
								검색 결과 <b class="result-count">${couponCount}</b>건
							</p>
						</div>
						<div>
							<button type="button" class="primary-btn" id="addCouponButton">+
								쿠폰 등록</button>
						</div>
					</div>
					<div class="table-wrap">
						<table>
							<thead>
								<tr>
									<th>쿠폰번호</th>
									<th>쿠폰명</th>
									<th>할인혜택</th>
									<th>유효일</th>
									<th>최소주문금액</th>
									<th>최대할인금액</th>
									<th>발급수</th>
									<th>상태</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody class="data-body">
								<c:forEach var="coupon" items="${couponList}">
									<tr class="data-row">
										<td><c:out value="${coupon.couponId}" /></td>
										<td><c:out value="${coupon.name}" /></td>
										<td><c:out value="${coupon.discount}" /> <c:out
												value="${coupon.discountType}" /></td>
										<td><c:out value="${coupon.validDays}" /></td>
										<td><c:out value="${coupon.minOrderAmount}" /></td>
										<td><c:out value="${coupon.maxDiscountAmount}" /></td>
										<td><c:out value="${coupon.issuedCount}" /></td>
										<td><span class="badge gray"><c:out
													value="${coupon.availability}" /></span></td>
										<td class="action-cell">
											<button type="button" class="light-btn issue-coupon"
												data-coupon-id="<c:out value='${coupon.couponId}'/>"
												data-coupon-name="<c:out value='${coupon.name}'/>">발급</button>
											<button type="button" class="light-btn edit-coupon"
												data-coupon-id="<c:out value='${coupon.couponId}'/>"
												data-name="<c:out value='${coupon.name}'/>"
												data-valid-days="<c:out value='${coupon.validDays}'/>"
												data-discount="<c:out value='${coupon.discount}'/>"
												data-discount-type="<c:out value='${coupon.discountType}'/>"
												data-min-order-amount="<c:out value='${coupon.minOrderAmount}'/>"
												data-max-discount-amount="<c:out value='${coupon.maxDiscountAmount}'/>"
												data-availability="<c:out value='${coupon.availability}'/>">수정</button>
											<button type="button"
												class="light-btn danger-btn delete-coupon"
												data-coupon-id="<c:out value='${coupon.couponId}'/>"
												data-coupon-name="<c:out value='${coupon.name}'/>">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<c:if test="${empty couponList}">
						<div class="empty-state show">쿠폰 검색 결과가 없습니다.</div>
					</c:if>
				</article>

				<div class="modal-backdrop" id="couponModal" aria-hidden="true"
					hidden>
					<section class="admin-modal" role="dialog" aria-modal="true"
						aria-labelledby="couponModalTitle">
						<div class="modal-head">
							<div>
								<p>쿠폰 기본정보를 등록하거나 수정합니다.</p>
								<h2 id="couponModalTitle">쿠폰 등록</h2>
							</div>
							<button type="button" class="modal-close" id="couponModalClose"
								aria-label="닫기">×</button>
						</div>
						<form id="couponForm" method="post"
							action="${pageContext.request.contextPath}/admin/member/couponWrite">
							<input type="hidden" name="couponId" id="couponId">
							<div class="form-grid">
								<div class="form-field">
									<label for="couponName">쿠폰명 *</label><input type="text"
										name="name" id="couponName" maxlength="100" required>
								</div>
								<div class="form-field">
									<label for="couponValidDays">유효일 *</label><input type="date"
										name="validDays" id="couponValidDays" required>
								</div>
								<div class="form-field">
									<label for="couponDiscount">할인값 *</label><input type="number"
										name="discount" id="couponDiscount" min="0" required>
								</div>
								<div class="form-field">
									<label for="couponDiscountType">할인유형 *</label><input
										type="text" name="discountType" id="couponDiscountType"
										maxlength="30" placeholder="예: 정액, 정률" required>
								</div>
								<div class="form-field">
									<label for="couponMinOrderAmount">최소주문금액</label><input
										type="number" name="minOrderAmount" id="couponMinOrderAmount"
										min="0">
								</div>
								<div class="form-field">
									<label for="couponMaxDiscountAmount">최대할인금액</label><input
										type="number" name="maxDiscountAmount"
										id="couponMaxDiscountAmount" min="0">
								</div>
								<div class="form-field">
									<label for="couponAvailability">상태 *</label><input type="text"
										name="availability" id="couponAvailability" maxlength="30"
										placeholder="DB에 사용하는 상태값" required>
								</div>
							</div>
							<div class="modal-actions">
								<button type="button" class="light-btn" id="couponModalCancel">취소</button>
								<button type="submit" class="primary-btn">저장</button>
							</div>
						</form>
					</section>
				</div>

				<div class="modal-backdrop" id="couponIssueModal" aria-hidden="true"
					hidden>
					<section class="admin-modal" role="dialog" aria-modal="true"
						aria-labelledby="couponIssueTitle">
						<div class="modal-head">
							<div>
								<p id="couponIssueInfo">회원번호를 입력해 쿠폰을 발급합니다.</p>
								<h2 id="couponIssueTitle">쿠폰 발급</h2>
							</div>
							<button type="button" class="modal-close"
								id="couponIssueModalClose" aria-label="닫기">×</button>
						</div>
						<form method="post"
							action="${pageContext.request.contextPath}/admin/member/couponIssue">
							<input type="hidden" name="couponId" id="issueCouponId">
							<div class="form-grid">
								<div class="form-field">
									<label for="issueMemberId">회원번호 *</label><input type="number"
										name="memberId" id="issueMemberId" min="1" required>
								</div>
							</div>
							<div class="modal-actions">
								<button type="button" class="light-btn"
									id="couponIssueModalCancel">취소</button>
								<button type="submit" class="primary-btn">발급</button>
							</div>
						</form>
					</section>
				</div>

				<form id="couponDeleteForm" method="post"
					action="${pageContext.request.contextPath}/admin/member/couponDelete"
					hidden>
					<input type="hidden" name="couponId" id="deleteCouponId">
				</form>
			</section>
			<section class="admin-section-panel" data-admin-section="5"
				data-section-name="FAQ 관리" data-table-title="FAQ 목록"
				data-can-add="true" hidden>
				<article class="panel search-panel">
					<form class="search-row" method="get"
						action="${pageContext.request.contextPath}/admin/member">
						<input type="hidden" name="tab" value="5"> <select
							name="faqSchType" aria-label="검색 항목">
							<option value="all" ${faqSchType eq 'all' ? 'selected' : ''}>전체</option>
							<option value="faqId" ${faqSchType eq 'faqId' ? 'selected' : ''}>FAQ번호</option>
							<option value="title" ${faqSchType eq 'title' ? 'selected' : ''}>제목</option>
							<option value="category"
								${faqSchType eq 'category' ? 'selected' : ''}>카테고리</option>
						</select> <input type="search" name="faqKwd"
							value="<c:out value='${faqKwd}'/>" placeholder="검색어를 입력하세요">
						<button type="submit" class="dark-btn">검색</button>
						<a class="light-btn"
							href="${pageContext.request.contextPath}/admin/member?tab=5">초기화</a>
					</form>
				</article>
				<article class="panel">
					<div class="panel-title">
						<div>
							<h2>FAQ 목록</h2>
							<p>
								검색 결과 <b class="result-count">${faqCount}</b>건
							</p>
						</div>
						<div>
							<button type="button" class="primary-btn" id="addFaqButton">+
								FAQ 등록</button>
						</div>
					</div>
					<div class="table-wrap">
						<table>
							<thead>
								<tr>
									<th>FAQ번호</th>
									<th>카테고리</th>
									<th>제목</th>
									<th>작성회원</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody class="data-body">
								<c:forEach var="faq" items="${faqList}">
									<tr class="data-row">
										<td><c:out value="${faq.faqId}" /></td>
										<td><c:out value="${faq.category}" /></td>
										<td><c:out value="${faq.title}" /></td>
										<td><c:out value="${faq.memberId}" /></td>
										<td class="action-cell">
											<button type="button" class="light-btn edit-faq"
												data-faq-id="<c:out value='${faq.faqId}'/>"
												data-title="<c:out value='${faq.title}'/>"
												data-category="<c:out value='${faq.category}'/>"
												data-content="<c:out value='${faq.content}'/>">수정</button>
											<button type="button" class="light-btn danger-btn delete-faq"
												data-faq-id="<c:out value='${faq.faqId}'/>"
												data-faq-title="<c:out value='${faq.title}'/>">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<c:if test="${empty faqList}">
						<div class="empty-state show">FAQ 검색 결과가 없습니다.</div>
					</c:if>
				</article>

				<div class="modal-backdrop" id="faqModal" aria-hidden="true" hidden>
					<section class="admin-modal" role="dialog" aria-modal="true"
						aria-labelledby="faqModalTitle">
						<div class="modal-head">
							<div>
								<p>고객센터 FAQ 내용을 등록하거나 수정합니다.</p>
								<h2 id="faqModalTitle">FAQ 등록</h2>
							</div>
							<button type="button" class="modal-close" id="faqModalClose"
								aria-label="닫기">×</button>
						</div>
						<form id="faqForm" method="post"
							action="${pageContext.request.contextPath}/admin/member/faqWrite">
							<input type="hidden" name="faqId" id="faqId">
							<div class="form-grid">
								<div class="form-field">
									<label for="faqCategory">카테고리 *</label><input type="text"
										name="category" id="faqCategory" maxlength="100" required>
								</div>
								<div class="form-field">
									<label for="faqTitle">제목 *</label><input type="text"
										name="title" id="faqTitle" maxlength="200" required>
								</div>
								<div class="form-field" style="grid-column: 1/-1;">
									<label for="faqContent">내용 *</label>
									<textarea name="content" id="faqContent" rows="8" required></textarea>
								</div>
							</div>
							<div class="modal-actions">
								<button type="button" class="light-btn" id="faqModalCancel">취소</button>
								<button type="submit" class="primary-btn">저장</button>
							</div>
						</form>
					</section>
				</div>
				<form id="faqDeleteForm" method="post"
					action="${pageContext.request.contextPath}/admin/member/faqDelete"
					hidden>
					<input type="hidden" name="faqId" id="deleteFaqId">
				</form>
			</section>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp" />
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
		src="${pageContext.request.contextPath}/dist/js/admin/member.js?v=20260820-4"></script>
</body>
</html>