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
					<span>회원 등록·검색, 레벨, 제재, 포인트와 쿠폰을 관리합니다.</span>
				</div>
			</div>

			<nav class="sub-tabs" aria-label="회원관리 탭">
				<button type="button" data-section-target="0" class="active">회원
					등록 / 검색</button>
				<button type="button" data-section-target="1" class="">회원
					레벨 관리</button>
				<button type="button" data-section-target="2" class="">회원
					제재 목록</button>
				<button type="button" data-section-target="3" class="">포인트
					관리</button>
				<button type="button" data-section-target="4" class="">쿠폰
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

			<section class="admin-section-panel" data-admin-section="1"
				data-section-name="회원 레벨 관리" data-table-title="회원 레벨 목록"
				data-add-label="+ 레벨 등록" data-can-add="true" hidden>
				<article class="panel search-panel">
					<div class="search-row">
						<select class="js-search-type" aria-label="검색 항목" disabled>
							<option value="all">전체</option>
							<option value="0">레벨코드</option>
							<option value="1">레벨명</option>
							<option value="2">적용대상</option>
							<option value="3">포인트적립률</option>
							<option value="4">주요혜택</option>
							<option value="5">회원수</option>
							<option value="6">수정일</option>
						</select> <input type="search" class="js-search-keyword"
							placeholder="검색어를 입력하세요" disabled>
						<button type="button" class="dark-btn js-search-button" disabled
							title="백엔드 기능 구현 전">검색</button>
						<button type="button" class="light-btn js-reset-button" disabled
							title="백엔드 기능 구현 전">초기화</button>
					</div>
					<div class="filter-row is-hidden" aria-label="추가 검색 조건">
						<!-- 이 탭은 추가 검색 조건이 없습니다. -->
					</div>
				</article>

				<article class="panel">
					<div class="panel-title">
						<div>
							<h2>회원 레벨 목록</h2>
							<p>
								검색 결과 <b class="result-count">5</b>건 · 선택 <b
									class="selected-count">0</b>건
							</p>
						</div>
						<div>
							<button type="button"
								class="light-btn danger-btn delete-selected-button" disabled
								title="백엔드 기능 구현 전">선택 삭제</button>
							<button type="button" class="light-btn export-button" disabled
								title="백엔드 기능 구현 전">CSV 저장</button>
						</div>
					</div>

					<div class="table-wrap">
						<table>
							<thead>
								<tr>
									<th><input type="checkbox" class="check-all"
										aria-label="현재 페이지 전체 선택" disabled></th>
									<th>레벨코드</th>
									<th>레벨명</th>
									<th>적용대상</th>
									<th>포인트적립률</th>
									<th>주요혜택</th>
									<th>회원수</th>
									<th>수정일</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody class="data-body">
								<!--
                  ★ 연습 포인트
                  아래 샘플 행을 보고 나중에 Controller에서 List를 받아
                  직접 c:forEach / DTO 출력 코드로 바꿔보세요.
                  현재 관리자용 DB 조회 기능이 아직 없어서 샘플 HTML을 그대로 둔 상태입니다.
                -->
								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">LV01</td>
									<td data-field-index="1">회원</td>
									<td data-field-index="2"><span class="badge green">일반회원</span></td>
									<td data-field-index="3">1%</td>
									<td data-field-index="4">기본 적립</td>
									<td data-field-index="5">1,824명</td>
									<td data-field-index="6">2026-08-01</td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>

								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">LV02</td>
									<td data-field-index="1">우수회원</td>
									<td data-field-index="2">누적구매 50만원</td>
									<td data-field-index="3">2%</td>
									<td data-field-index="4">배송비 쿠폰</td>
									<td data-field-index="5">482명</td>
									<td data-field-index="6">2026-08-01</td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>

								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">LV03</td>
									<td data-field-index="1">VIP</td>
									<td data-field-index="2">누적구매 200만원</td>
									<td data-field-index="3">3%</td>
									<td data-field-index="4">전용 쿠폰</td>
									<td data-field-index="5">96명</td>
									<td data-field-index="6">2026-08-02</td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>

								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">LV04</td>
									<td data-field-index="1">판매자</td>
									<td data-field-index="2">판매 승인 회원</td>
									<td data-field-index="3">1%</td>
									<td data-field-index="4">판매 등록 권한</td>
									<td data-field-index="5">214명</td>
									<td data-field-index="6">2026-08-03</td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>

								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">LV05</td>
									<td data-field-index="1">관리자</td>
									<td data-field-index="2">운영 담당자</td>
									<td data-field-index="3">-</td>
									<td data-field-index="4">관리자 권한</td>
									<td data-field-index="5">7명</td>
									<td data-field-index="6">2026-08-03</td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="empty-state">검색 결과가 없습니다.</div>
					<div class="pagination" aria-label="목록 페이지 이동">
						<button type="button" class="page-prev" aria-label="이전 페이지"
							disabled title="백엔드 기능 구현 전">‹</button>
						<span class="page-info">1 / 1</span>
						<button type="button" class="page-next" aria-label="다음 페이지"
							disabled title="백엔드 기능 구현 전">›</button>
					</div>
				</article>

			</section>

			<section class="admin-section-panel" data-admin-section="2"
				data-section-name="회원 제재 목록" data-table-title="회원 제재 목록"
				data-add-label="+ 제재 등록" data-can-add="true" hidden>
				<article class="panel search-panel">
					<div class="search-row">
						<select class="js-search-type" aria-label="검색 항목" disabled>
							<option value="all">전체</option>
							<option value="0">제재번호</option>
							<option value="1">회원아이디</option>
							<option value="2">회원명</option>
							<option value="3">제재사유</option>
							<option value="4">시작일</option>
							<option value="5">종료일</option>
							<option value="6">상태</option>
						</select> <input type="search" class="js-search-keyword"
							placeholder="검색어를 입력하세요" disabled>
						<button type="button" class="dark-btn js-search-button" disabled
							title="백엔드 기능 구현 전">검색</button>
						<button type="button" class="light-btn js-reset-button" disabled
							title="백엔드 기능 구현 전">초기화</button>
					</div>
					<div class="filter-row" aria-label="추가 검색 조건">
						<div class="filter-control" data-filter-type="select"
							data-filter-column="6">
							<label>제재상태</label> <select class="extra-filter"
								id="filter-sanctionStatus" disabled>
								<option value="">전체</option>
								<option value="진행중">진행중</option>
								<option value="해제">해제</option>
								<option value="만료">만료</option>
							</select>
						</div>
					</div>
				</article>

				<article class="panel">
					<div class="panel-title">
						<div>
							<h2>회원 제재 목록</h2>
							<p>
								검색 결과 <b class="result-count">3</b>건 · 선택 <b
									class="selected-count">0</b>건
							</p>
						</div>
						<div>
							<button type="button"
								class="light-btn danger-btn delete-selected-button" disabled
								title="백엔드 기능 구현 전">선택 삭제</button>
							<button type="button" class="light-btn export-button" disabled
								title="백엔드 기능 구현 전">CSV 저장</button>
						</div>
					</div>

					<div class="table-wrap">
						<table>
							<thead>
								<tr>
									<th><input type="checkbox" class="check-all"
										aria-label="현재 페이지 전체 선택" disabled></th>
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
								<!--
                  ★ 연습 포인트
                  아래 샘플 행을 보고 나중에 Controller에서 List를 받아
                  직접 c:forEach / DTO 출력 코드로 바꿔보세요.
                  현재 관리자용 DB 조회 기능이 아직 없어서 샘플 HTML을 그대로 둔 상태입니다.
                -->
								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">BAN-032</td>
									<td data-field-index="1">doyoon7</td>
									<td data-field-index="2">이도윤</td>
									<td data-field-index="3"><span class="badge green">비정상
											접속 반복</span></td>
									<td data-field-index="4">2026-08-01</td>
									<td data-field-index="5">2026-08-08</td>
									<td data-field-index="6"><span class="badge orange">진행중</span></td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>

								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">BAN-031</td>
									<td data-field-index="1">shoe_box</td>
									<td data-field-index="2">정하늘</td>
									<td data-field-index="3">상품정보 허위 등록</td>
									<td data-field-index="4">2026-07-25</td>
									<td data-field-index="5">2026-08-01</td>
									<td data-field-index="6"><span class="badge green">해제</span></td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>

								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">BAN-030</td>
									<td data-field-index="1">quickdeal</td>
									<td data-field-index="2">오현우</td>
									<td data-field-index="3">반복적인 주문 취소</td>
									<td data-field-index="4">2026-07-10</td>
									<td data-field-index="5">2026-07-24</td>
									<td data-field-index="6"><span class="badge gray">만료</span></td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="empty-state">검색 결과가 없습니다.</div>
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
				data-add-label="+ 포인트 추가" data-can-add="true" hidden>
				<article class="panel search-panel">
					<div class="search-row">
						<select class="js-search-type" aria-label="검색 항목" disabled>
							<option value="all">전체</option>
							<option value="0">회원번호</option>
							<option value="1">회원명</option>
							<option value="2">아이디</option>
							<option value="3">보유포인트</option>
							<option value="4">누적적립</option>
							<option value="5">누적사용</option>
							<option value="6">최종변경일</option>
						</select> <input type="search" class="js-search-keyword"
							placeholder="검색어를 입력하세요" disabled>
						<button type="button" class="dark-btn js-search-button" disabled
							title="백엔드 기능 구현 전">검색</button>
						<button type="button" class="light-btn js-reset-button" disabled
							title="백엔드 기능 구현 전">초기화</button>
					</div>
					<div class="filter-row is-hidden" aria-label="추가 검색 조건">
						<!-- 이 탭은 추가 검색 조건이 없습니다. -->
					</div>
				</article>

				<article class="panel">
					<div class="panel-title">
						<div>
							<h2>회원별 포인트 목록</h2>
							<p>
								검색 결과 <b class="result-count">3</b>건 · 선택 <b
									class="selected-count">0</b>건
							</p>
						</div>
						<div>
							<button type="button"
								class="light-btn danger-btn delete-selected-button" disabled
								title="백엔드 기능 구현 전">선택 삭제</button>
							<button type="button" class="light-btn export-button" disabled
								title="백엔드 기능 구현 전">CSV 저장</button>
						</div>
					</div>

					<div class="table-wrap">
						<table>
							<thead>
								<tr>
									<th><input type="checkbox" class="check-all"
										aria-label="현재 페이지 전체 선택" disabled></th>
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
								<!--
                  ★ 연습 포인트
                  아래 샘플 행을 보고 나중에 Controller에서 List를 받아
                  직접 c:forEach / DTO 출력 코드로 바꿔보세요.
                  현재 관리자용 DB 조회 기능이 아직 없어서 샘플 HTML을 그대로 둔 상태입니다.
                -->
								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">10024</td>
									<td data-field-index="1">김민준</td>
									<td data-field-index="2">minjun24</td>
									<td data-field-index="3">42,800P</td>
									<td data-field-index="4">81,200P</td>
									<td data-field-index="5">38,400P</td>
									<td data-field-index="6">2026-08-05</td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>

								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">10023</td>
									<td data-field-index="1">박서연</td>
									<td data-field-index="2">seoyeon</td>
									<td data-field-index="3">18,500P</td>
									<td data-field-index="4">42,000P</td>
									<td data-field-index="5">23,500P</td>
									<td data-field-index="6">2026-08-04</td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>

								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">10022</td>
									<td data-field-index="1">이도윤</td>
									<td data-field-index="2">doyoon7</td>
									<td data-field-index="3">3,200P</td>
									<td data-field-index="4">16,900P</td>
									<td data-field-index="5">13,700P</td>
									<td data-field-index="6">2026-08-01</td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="empty-state">검색 결과가 없습니다.</div>
					<div class="pagination" aria-label="목록 페이지 이동">
						<button type="button" class="page-prev" aria-label="이전 페이지"
							disabled title="백엔드 기능 구현 전">‹</button>
						<span class="page-info">1 / 1</span>
						<button type="button" class="page-next" aria-label="다음 페이지"
							disabled title="백엔드 기능 구현 전">›</button>
					</div>
				</article>

			</section>

			<section class="admin-section-panel" data-admin-section="4"
				data-section-name="쿠폰 관리" data-table-title="회원별 쿠폰 목록"
				data-add-label="+ 쿠폰 발급" data-can-add="true" hidden>
				<article class="panel search-panel">
					<div class="search-row">
						<select class="js-search-type" aria-label="검색 항목" disabled>
							<option value="all">전체</option>
							<option value="0">쿠폰번호</option>
							<option value="1">쿠폰명</option>
							<option value="2">대상회원</option>
							<option value="3">할인혜택</option>
							<option value="4">유효기간</option>
							<option value="5">발급수</option>
							<option value="6">상태</option>
						</select> <input type="search" class="js-search-keyword"
							placeholder="검색어를 입력하세요" disabled>
						<button type="button" class="dark-btn js-search-button" disabled
							title="백엔드 기능 구현 전">검색</button>
						<button type="button" class="light-btn js-reset-button" disabled
							title="백엔드 기능 구현 전">초기화</button>
					</div>
					<div class="filter-row" aria-label="추가 검색 조건">
						<div class="filter-control" data-filter-type="select"
							data-filter-column="6">
							<label>쿠폰상태</label> <select class="extra-filter"
								id="filter-couponStatus" disabled>
								<option value="">전체</option>
								<option value="발급중">발급중</option>
								<option value="종료">종료</option>
								<option value="만료">만료</option>
							</select>
						</div>
					</div>
				</article>

				<article class="panel">
					<div class="panel-title">
						<div>
							<h2>회원별 쿠폰 목록</h2>
							<p>
								검색 결과 <b class="result-count">3</b>건 · 선택 <b
									class="selected-count">0</b>건
							</p>
						</div>
						<div>
							<button type="button"
								class="light-btn danger-btn delete-selected-button" disabled
								title="백엔드 기능 구현 전">선택 삭제</button>
							<button type="button" class="light-btn export-button" disabled
								title="백엔드 기능 구현 전">CSV 저장</button>
						</div>
					</div>

					<div class="table-wrap">
						<table>
							<thead>
								<tr>
									<th><input type="checkbox" class="check-all"
										aria-label="현재 페이지 전체 선택" disabled></th>
									<th>쿠폰번호</th>
									<th>쿠폰명</th>
									<th>대상회원</th>
									<th>할인혜택</th>
									<th>유효기간</th>
									<th>발급수</th>
									<th>상태</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody class="data-body">
								<!--
                  ★ 연습 포인트
                  아래 샘플 행을 보고 나중에 Controller에서 List를 받아
                  직접 c:forEach / DTO 출력 코드로 바꿔보세요.
                  현재 관리자용 DB 조회 기능이 아직 없어서 샘플 HTML을 그대로 둔 상태입니다.
                -->
								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">CP-2608-01</td>
									<td data-field-index="1">8월 배송비 쿠폰</td>
									<td data-field-index="2">우수회원</td>
									<td data-field-index="3">배송비 3,000원</td>
									<td data-field-index="4">2026-08-01~08-31</td>
									<td data-field-index="5">482장</td>
									<td data-field-index="6"><span class="badge green">발급중</span></td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>

								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">CP-2608-02</td>
									<td data-field-index="1">VIP 감사 쿠폰</td>
									<td data-field-index="2">VIP</td>
									<td data-field-index="3">10% 할인</td>
									<td data-field-index="4">2026-08-01~08-31</td>
									<td data-field-index="5">96장</td>
									<td data-field-index="6"><span class="badge green">발급중</span></td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>

								<tr class="data-row">
									<td><input type="checkbox" class="row-check"
										aria-label="항목 선택" disabled></td>
									<td data-field-index="0">CP-2607-11</td>
									<td data-field-index="1">신규가입 쿠폰</td>
									<td data-field-index="2">신규회원</td>
									<td data-field-index="3">5,000원 할인</td>
									<td data-field-index="4">2026-07-01~07-31</td>
									<td data-field-index="5">318장</td>
									<td data-field-index="6"><span class="badge gray">종료</span></td>
									<td class="action-cell">
										<button type="button" class="light-btn edit-row" disabled
											title="백엔드 기능 구현 전">수정</button>
										<button type="button" class="light-btn delete-row" disabled
											title="백엔드 기능 구현 전">삭제</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="empty-state">검색 결과가 없습니다.</div>
					<div class="pagination" aria-label="목록 페이지 이동">
						<button type="button" class="page-prev" aria-label="이전 페이지"
							disabled title="백엔드 기능 구현 전">‹</button>
						<span class="page-info">1 / 1</span>
						<button type="button" class="page-next" aria-label="다음 페이지"
							disabled title="백엔드 기능 구현 전">›</button>
					</div>
				</article>

			</section>
		</section>
	</main>

	<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp" />
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
    src="${pageContext.request.contextPath}/dist/js/admin/member.js?v=20260819-2"></script>
</body>
</html>
