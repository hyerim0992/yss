<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="adminPage" value="logistics" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>물류관리 | Yongsinsa 관리자</title>
  <script>
    document.documentElement.classList.add("ys-page-loading");
    window.__ysPageLoaderStart = Date.now();
  </script>
  <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/list.css?v=20260813">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/modal.css?v=20260813">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/static-list.css?v=20260813">
</head>
<body data-context-path="${pageContext.request.contextPath}">
  <jsp:include page="/WEB-INF/views/common/page-loader.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

  <main class="admin-main">
    <section class="page active admin-static-page" data-page-key="logistics">
      <div class="page-heading">
        <div>
          <p>관리자 페이지 / 물류관리</p>
          <h1>물류관리</h1>
          <span>입고 재고, 결제 확인, 출고, 반품·교환과 실시간 배송정보를 관리합니다.</span>
        </div>
        <button type="button" class="primary-btn" id="addButton">+ 입고 등록</button>
      </div>

      <nav class="sub-tabs" aria-label="물류관리 탭">
        <button type="button" data-section-target="0" class="active">재고 관리</button>
        <button type="button" data-section-target="1" class="">주문 및 출고 관리</button>
        <button type="button" data-section-target="2" class="">반품 / 교환 관리</button>
        <button type="button" data-section-target="3" class="">실시간 배송조회</button>
      </nav>

      <section class="admin-section-panel active" data-admin-section="0" data-section-name="재고 관리" data-table-title="입고 물품 목록" data-add-label="+ 입고 등록" data-can-add="true">
        <article class="panel search-panel">
          <div class="search-row">
            <select class="js-search-type" aria-label="검색 항목">
              <option value="all">전체</option>
              <option value="0">입고번호</option>
              <option value="1">물품번호</option>
              <option value="2">상품명</option>
              <option value="3">구매가격</option>
              <option value="4">컨테이너위치</option>
              <option value="5">수량</option>
              <option value="6">상태</option>
              <option value="7">입고일</option>
            </select>
            <input type="search" class="js-search-keyword" placeholder="검색어를 입력하세요">
            <button type="button" class="dark-btn js-search-button">검색</button>
            <button type="button" class="light-btn js-reset-button">초기화</button>
          </div>
          <div class="filter-row" aria-label="추가 검색 조건">
          <div class="filter-control" data-filter-type="select" data-filter-column="6">
            <label>입고상태</label>
            <select class="extra-filter" id="filter-stockStatus">
              <option value="">전체</option>
              <option value="입고완료">입고완료</option>
              <option value="입고대기">입고대기</option>
              <option value="재고부족">재고부족</option>
            </select>
          </div>
          </div>
        </article>

        <article class="panel">
          <div class="panel-title">
            <div>
              <h2>입고 물품 목록</h2>
              <p>검색 결과 <b class="result-count">3</b>건 · 선택 <b class="selected-count">0</b>건</p>
            </div>
            <div>
              <button type="button" class="light-btn danger-btn delete-selected-button">선택 삭제</button>
              <button type="button" class="light-btn export-button">CSV 저장</button>
            </div>
          </div>

          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th><input type="checkbox" class="check-all" aria-label="현재 페이지 전체 선택"></th>
                  <th>입고번호</th>
                  <th>물품번호</th>
                  <th>상품명</th>
                  <th>구매가격</th>
                  <th>컨테이너위치</th>
                  <th>수량</th>
                  <th>상태</th>
                  <th>입고일</th>
                  <th>관리</th>
                </tr>
              </thead>
              <tbody class="data-body">
                <!--
                  ★ 연습 포인트
                  아래 샘플 행을 보고 나중에 Controller에서 List를 받아
                  직접 c:forEach / DTO 출력 코드로 바꿔보세요.
                  지금은 연습할 수 있도록 샘플 HTML을 그대로 둔 상태입니다.
                -->
              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">STK-260805-18</td>
                  <td data-field-index="1">NK-AF1-001</td>
                  <td data-field-index="2">나이키 에어포스 1 &#x27;07</td>
                  <td data-field-index="3">92,000원</td>
                  <td data-field-index="4">A-02-14</td>
                  <td data-field-index="5">12</td>
                  <td data-field-index="6"><span class="badge green">입고완료</span></td>
                  <td data-field-index="7">2026-08-05</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">STK-260805-17</td>
                  <td data-field-index="1">NB-993-002</td>
                  <td data-field-index="2">뉴발란스 993 그레이</td>
                  <td data-field-index="3">221,000원</td>
                  <td data-field-index="4">B-01-08</td>
                  <td data-field-index="5">5</td>
                  <td data-field-index="6"><span class="badge green">입고완료</span></td>
                  <td data-field-index="7">2026-08-05</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">STK-260804-16</td>
                  <td data-field-index="1">AD-SAM-003</td>
                  <td data-field-index="2">아디다스 삼바 OG</td>
                  <td data-field-index="3">103,000원</td>
                  <td data-field-index="4">A-04-02</td>
                  <td data-field-index="5">0</td>
                  <td data-field-index="6"><span class="badge gray">재고부족</span></td>
                  <td data-field-index="7">2026-08-04</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>
              </tbody>
            </table>
          </div>

          <div class="empty-state">검색 결과가 없습니다.</div>
          <div class="pagination" aria-label="목록 페이지 이동">
            <!-- 페이지 버튼의 모양은 JSP에 있고 JS는 이 template을 복제해서 번호만 바꿉니다. -->
          </div>
        </article>

                <template class="admin-row-template">
          <tr class="data-row">
            <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
              <td data-field-index="0"></td>
              <td data-field-index="1"></td>
              <td data-field-index="2"></td>
              <td data-field-index="3"></td>
              <td data-field-index="4"></td>
              <td data-field-index="5"></td>
              <td data-field-index="6"><span class="badge blue"></span></td>
              <td data-field-index="7"></td>
            <td class="action-cell">
              <button type="button" class="light-btn edit-row">수정</button>
              <button type="button" class="light-btn delete-row">삭제</button>
            </td>
          </tr>
        </template>

        <template class="admin-form-template">
          <div class="form-field">
            <label>입고번호</label>
            <input type="text" data-field-index="0" data-default="" placeholder="입고번호 입력">
          </div>
          <div class="form-field">
            <label>물품번호</label>
            <input type="text" data-field-index="1" data-default="" placeholder="물품번호 입력">
          </div>
          <div class="form-field">
            <label>상품명</label>
            <input type="text" data-field-index="2" data-default="" placeholder="상품명 입력">
          </div>
          <div class="form-field">
            <label>구매가격</label>
            <input type="text" data-field-index="3" data-default="" placeholder="구매가격 입력">
          </div>
          <div class="form-field">
            <label>컨테이너위치</label>
            <input type="text" data-field-index="4" data-default="" placeholder="컨테이너위치 입력">
          </div>
          <div class="form-field">
            <label>수량</label>
            <input type="text" data-field-index="5" data-default="" placeholder="수량 입력">
          </div>
          <div class="form-field">
            <label>상태</label>
            <select data-field-index="6" data-default="입고완료">
              <option value="">선택해 주세요</option>
              <option value="입고완료" selected>입고완료</option>
              <option value="입고대기">입고대기</option>
              <option value="재고부족">재고부족</option>
            </select>
          </div>
          <div class="form-field">
            <label>입고일</label>
            <input type="text" data-field-index="7" data-default="" placeholder="입고일 입력">
          </div>
        </template>
      </section>

      <section class="admin-section-panel" data-admin-section="1" data-section-name="주문 및 출고 관리" data-table-title="결제 확인 및 출고 목록" data-add-label="+ 신규 등록" data-can-add="false" hidden>
        <article class="panel search-panel">
          <div class="search-row">
            <select class="js-search-type" aria-label="검색 항목">
              <option value="all">전체</option>
              <option value="0">주문번호</option>
              <option value="1">결제상태</option>
              <option value="2">상품명</option>
              <option value="3">구매자</option>
              <option value="4">연락처</option>
              <option value="5">배송지</option>
              <option value="6">출고상태</option>
              <option value="7">택배사</option>
            </select>
            <input type="search" class="js-search-keyword" placeholder="검색어를 입력하세요">
            <button type="button" class="dark-btn js-search-button">검색</button>
            <button type="button" class="light-btn js-reset-button">초기화</button>
          </div>
          <div class="filter-row" aria-label="추가 검색 조건">
          <div class="filter-control" data-filter-type="select" data-filter-column="1">
            <label>결제상태</label>
            <select class="extra-filter" id="filter-paymentStatus">
              <option value="">전체</option>
              <option value="결제완료">결제완료</option>
              <option value="결제대기">결제대기</option>
              <option value="결제취소">결제취소</option>
            </select>
          </div>
          <div class="filter-control" data-filter-type="select" data-filter-column="6">
            <label>출고상태</label>
            <select class="extra-filter" id="filter-releaseStatus">
              <option value="">전체</option>
              <option value="출고대기">출고대기</option>
              <option value="배송준비">배송준비</option>
              <option value="배송중">배송중</option>
              <option value="배송완료">배송완료</option>
            </select>
          </div>
          </div>
        </article>

        <article class="panel">
          <div class="panel-title">
            <div>
              <h2>결제 확인 및 출고 목록</h2>
              <p>검색 결과 <b class="result-count">3</b>건 · 선택 <b class="selected-count">0</b>건</p>
            </div>
            <div>
              <button type="button" class="light-btn danger-btn delete-selected-button">선택 삭제</button>
              <button type="button" class="light-btn export-button">CSV 저장</button>
            </div>
          </div>

          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th><input type="checkbox" class="check-all" aria-label="현재 페이지 전체 선택"></th>
                  <th>주문번호</th>
                  <th>결제상태</th>
                  <th>상품명</th>
                  <th>구매자</th>
                  <th>연락처</th>
                  <th>배송지</th>
                  <th>출고상태</th>
                  <th>택배사</th>
                  <th>관리</th>
                </tr>
              </thead>
              <tbody class="data-body">
                <!--
                  ★ 연습 포인트
                  아래 샘플 행을 보고 나중에 Controller에서 List를 받아
                  직접 c:forEach / DTO 출력 코드로 바꿔보세요.
                  지금은 연습할 수 있도록 샘플 HTML을 그대로 둔 상태입니다.
                -->
              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">ES260805-0132</td>
                  <td data-field-index="1"><span class="badge green">결제완료</span></td>
                  <td data-field-index="2">나이키 에어포스 1 &#x27;07</td>
                  <td data-field-index="3">김민준</td>
                  <td data-field-index="4">010-1234-5678</td>
                  <td data-field-index="5">서울시 마포구 월드컵북로 00</td>
                  <td data-field-index="6"><span class="badge orange">배송준비</span></td>
                  <td data-field-index="7">CJ대한통운</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">ES260805-0131</td>
                  <td data-field-index="1"><span class="badge green">결제완료</span></td>
                  <td data-field-index="2">뉴발란스 993 그레이</td>
                  <td data-field-index="3">박서연</td>
                  <td data-field-index="4">010-2841-9032</td>
                  <td data-field-index="5">경기도 성남시 분당구 00</td>
                  <td data-field-index="6"><span class="badge orange">출고대기</span></td>
                  <td data-field-index="7">-</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">ES260805-0130</td>
                  <td data-field-index="1"><span class="badge green">결제완료</span></td>
                  <td data-field-index="2">아식스 젤 카야노 14</td>
                  <td data-field-index="3">최지우</td>
                  <td data-field-index="4">010-7712-1120</td>
                  <td data-field-index="5">부산시 해운대구 센텀로 00</td>
                  <td data-field-index="6"><span class="badge green">배송중</span></td>
                  <td data-field-index="7">한진택배</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>
              </tbody>
            </table>
          </div>

          <div class="empty-state">검색 결과가 없습니다.</div>
          <div class="pagination" aria-label="목록 페이지 이동">
            <!-- 페이지 버튼의 모양은 JSP에 있고 JS는 이 template을 복제해서 번호만 바꿉니다. -->
          </div>
        </article>

                <template class="admin-row-template">
          <tr class="data-row">
            <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
              <td data-field-index="0"></td>
              <td data-field-index="1"><span class="badge blue"></span></td>
              <td data-field-index="2"></td>
              <td data-field-index="3"></td>
              <td data-field-index="4"></td>
              <td data-field-index="5"></td>
              <td data-field-index="6"><span class="badge blue"></span></td>
              <td data-field-index="7"></td>
            <td class="action-cell">
              <button type="button" class="light-btn edit-row">수정</button>
              <button type="button" class="light-btn delete-row">삭제</button>
            </td>
          </tr>
        </template>

        <template class="admin-form-template">
          <div class="form-field">
            <label>주문번호</label>
            <input type="text" data-field-index="0" data-default="" placeholder="주문번호 입력">
          </div>
          <div class="form-field">
            <label>결제상태</label>
            <select data-field-index="1" data-default="">
              <option value="">선택해 주세요</option>
              <option value="결제완료">결제완료</option>
              <option value="결제대기">결제대기</option>
              <option value="결제취소">결제취소</option>
            </select>
          </div>
          <div class="form-field">
            <label>상품명</label>
            <input type="text" data-field-index="2" data-default="" placeholder="상품명 입력">
          </div>
          <div class="form-field">
            <label>구매자</label>
            <input type="text" data-field-index="3" data-default="" placeholder="구매자 입력">
          </div>
          <div class="form-field">
            <label>연락처</label>
            <input type="text" data-field-index="4" data-default="" placeholder="연락처 입력">
          </div>
          <div class="form-field">
            <label>배송지</label>
            <input type="text" data-field-index="5" data-default="" placeholder="배송지 입력">
          </div>
          <div class="form-field">
            <label>출고상태</label>
            <select data-field-index="6" data-default="">
              <option value="">선택해 주세요</option>
              <option value="출고대기">출고대기</option>
              <option value="배송준비">배송준비</option>
              <option value="배송중">배송중</option>
              <option value="배송완료">배송완료</option>
            </select>
          </div>
          <div class="form-field">
            <label>택배사</label>
            <input type="text" data-field-index="7" data-default="" placeholder="택배사 입력">
          </div>
        </template>
      </section>

      <section class="admin-section-panel" data-admin-section="2" data-section-name="반품 / 교환 관리" data-table-title="반품·교환 접수 목록" data-add-label="+ 신규 등록" data-can-add="false" hidden>
        <article class="panel search-panel">
          <div class="search-row">
            <select class="js-search-type" aria-label="검색 항목">
              <option value="all">전체</option>
              <option value="0">접수번호</option>
              <option value="1">주문번호</option>
              <option value="2">상품명</option>
              <option value="3">요청유형</option>
              <option value="4">요청사유</option>
              <option value="5">검수정보대조</option>
              <option value="6">책임소재</option>
              <option value="7">처리상태</option>
            </select>
            <input type="search" class="js-search-keyword" placeholder="검색어를 입력하세요">
            <button type="button" class="dark-btn js-search-button">검색</button>
            <button type="button" class="light-btn js-reset-button">초기화</button>
          </div>
          <div class="filter-row" aria-label="추가 검색 조건">
          <div class="filter-control" data-filter-type="select" data-filter-column="3">
            <label>요청유형</label>
            <select class="extra-filter" id="filter-returnType">
              <option value="">전체</option>
              <option value="반품">반품</option>
              <option value="교환">교환</option>
            </select>
          </div>
          <div class="filter-control" data-filter-type="select" data-filter-column="7">
            <label>처리상태</label>
            <select class="extra-filter" id="filter-returnStatus">
              <option value="">전체</option>
              <option value="접수">접수</option>
              <option value="확인중">확인중</option>
              <option value="처리완료">처리완료</option>
              <option value="반려">반려</option>
            </select>
          </div>
          </div>
        </article>

        <article class="panel">
          <div class="panel-title">
            <div>
              <h2>반품·교환 접수 목록</h2>
              <p>검색 결과 <b class="result-count">3</b>건 · 선택 <b class="selected-count">0</b>건</p>
            </div>
            <div>
              <button type="button" class="light-btn danger-btn delete-selected-button">선택 삭제</button>
              <button type="button" class="light-btn export-button">CSV 저장</button>
            </div>
          </div>

          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th><input type="checkbox" class="check-all" aria-label="현재 페이지 전체 선택"></th>
                  <th>접수번호</th>
                  <th>주문번호</th>
                  <th>상품명</th>
                  <th>요청유형</th>
                  <th>요청사유</th>
                  <th>검수정보대조</th>
                  <th>책임소재</th>
                  <th>처리상태</th>
                  <th>관리</th>
                </tr>
              </thead>
              <tbody class="data-body">
                <!--
                  ★ 연습 포인트
                  아래 샘플 행을 보고 나중에 Controller에서 List를 받아
                  직접 c:forEach / DTO 출력 코드로 바꿔보세요.
                  지금은 연습할 수 있도록 샘플 HTML을 그대로 둔 상태입니다.
                -->
              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">RT-260805-04</td>
                  <td data-field-index="1">ES260801-0112</td>
                  <td data-field-index="2">아디다스 삼바 OG</td>
                  <td data-field-index="3">교환</td>
                  <td data-field-index="4">사이즈 변경</td>
                  <td data-field-index="5"><span class="badge green">일치</span></td>
                  <td data-field-index="6">구매자</td>
                  <td data-field-index="7"><span class="badge orange">확인중</span></td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">RT-260804-03</td>
                  <td data-field-index="1">ES260731-0105</td>
                  <td data-field-index="2">나이키 에어포스 1 &#x27;07</td>
                  <td data-field-index="3">반품</td>
                  <td data-field-index="4">오염 발견</td>
                  <td data-field-index="5"><span class="badge gray">상이</span></td>
                  <td data-field-index="6">판매자</td>
                  <td data-field-index="7"><span class="badge orange">접수</span></td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">RT-260803-02</td>
                  <td data-field-index="1">ES260730-0098</td>
                  <td data-field-index="2">뉴발란스 993 그레이</td>
                  <td data-field-index="3">반품</td>
                  <td data-field-index="4">단순 변심</td>
                  <td data-field-index="5"><span class="badge green">일치</span></td>
                  <td data-field-index="6">구매자</td>
                  <td data-field-index="7"><span class="badge green">처리완료</span></td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>
              </tbody>
            </table>
          </div>

          <div class="empty-state">검색 결과가 없습니다.</div>
          <div class="pagination" aria-label="목록 페이지 이동">
            <!-- 페이지 버튼의 모양은 JSP에 있고 JS는 이 template을 복제해서 번호만 바꿉니다. -->
          </div>
        </article>

                <template class="admin-row-template">
          <tr class="data-row">
            <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
              <td data-field-index="0"></td>
              <td data-field-index="1"></td>
              <td data-field-index="2"></td>
              <td data-field-index="3"></td>
              <td data-field-index="4"></td>
              <td data-field-index="5"><span class="badge blue"></span></td>
              <td data-field-index="6"></td>
              <td data-field-index="7"><span class="badge blue"></span></td>
            <td class="action-cell">
              <button type="button" class="light-btn edit-row">수정</button>
              <button type="button" class="light-btn delete-row">삭제</button>
            </td>
          </tr>
        </template>

        <template class="admin-form-template">
          <div class="form-field">
            <label>접수번호</label>
            <input type="text" data-field-index="0" data-default="" placeholder="접수번호 입력">
          </div>
          <div class="form-field">
            <label>주문번호</label>
            <input type="text" data-field-index="1" data-default="" placeholder="주문번호 입력">
          </div>
          <div class="form-field">
            <label>상품명</label>
            <input type="text" data-field-index="2" data-default="" placeholder="상품명 입력">
          </div>
          <div class="form-field">
            <label>요청유형</label>
            <select data-field-index="3" data-default="">
              <option value="">선택해 주세요</option>
              <option value="반품">반품</option>
              <option value="교환">교환</option>
            </select>
          </div>
          <div class="form-field">
            <label>요청사유</label>
            <input type="text" data-field-index="4" data-default="" placeholder="요청사유 입력">
          </div>
          <div class="form-field">
            <label>검수정보대조</label>
            <input type="text" data-field-index="5" data-default="" placeholder="검수정보대조 입력">
          </div>
          <div class="form-field">
            <label>책임소재</label>
            <input type="text" data-field-index="6" data-default="" placeholder="책임소재 입력">
          </div>
          <div class="form-field">
            <label>처리상태</label>
            <select data-field-index="7" data-default="">
              <option value="">선택해 주세요</option>
              <option value="접수">접수</option>
              <option value="확인중">확인중</option>
              <option value="처리완료">처리완료</option>
              <option value="반려">반려</option>
            </select>
          </div>
        </template>
      </section>

      <section class="admin-section-panel" data-admin-section="3" data-section-name="실시간 배송조회" data-table-title="배송 API 조회 목록" data-add-label="+ 신규 등록" data-can-add="false" hidden>
        <article class="panel search-panel">
          <div class="search-row">
            <select class="js-search-type" aria-label="검색 항목">
              <option value="all">전체</option>
              <option value="0">송장번호</option>
              <option value="1">주문번호</option>
              <option value="2">구매자</option>
              <option value="3">택배사</option>
              <option value="4">현재위치</option>
              <option value="5">배송상태</option>
              <option value="6">최종갱신</option>
            </select>
            <input type="search" class="js-search-keyword" placeholder="검색어를 입력하세요">
            <button type="button" class="dark-btn js-search-button">검색</button>
            <button type="button" class="light-btn js-reset-button">초기화</button>
          </div>
          <div class="filter-row" aria-label="추가 검색 조건">
          <div class="filter-control" data-filter-type="select" data-filter-column="5">
            <label>배송상태</label>
            <select class="extra-filter" id="filter-deliveryStatus">
              <option value="">전체</option>
              <option value="집화완료">집화완료</option>
              <option value="배송중">배송중</option>
              <option value="배달출발">배달출발</option>
              <option value="배송완료">배송완료</option>
            </select>
          </div>
          </div>
        </article>

        <article class="panel">
          <div class="panel-title">
            <div>
              <h2>배송 API 조회 목록</h2>
              <p>검색 결과 <b class="result-count">3</b>건 · 선택 <b class="selected-count">0</b>건</p>
            </div>
            <div>
              <button type="button" class="light-btn danger-btn delete-selected-button">선택 삭제</button>
              <button type="button" class="light-btn export-button">CSV 저장</button>
            </div>
          </div>

          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th><input type="checkbox" class="check-all" aria-label="현재 페이지 전체 선택"></th>
                  <th>송장번호</th>
                  <th>주문번호</th>
                  <th>구매자</th>
                  <th>택배사</th>
                  <th>현재위치</th>
                  <th>배송상태</th>
                  <th>최종갱신</th>
                  <th>관리</th>
                </tr>
              </thead>
              <tbody class="data-body">
                <!--
                  ★ 연습 포인트
                  아래 샘플 행을 보고 나중에 Controller에서 List를 받아
                  직접 c:forEach / DTO 출력 코드로 바꿔보세요.
                  지금은 연습할 수 있도록 샘플 HTML을 그대로 둔 상태입니다.
                -->
              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">589123456701</td>
                  <td data-field-index="1">ES260805-0132</td>
                  <td data-field-index="2">김민준</td>
                  <td data-field-index="3">CJ대한통운</td>
                  <td data-field-index="4">마포BSub</td>
                  <td data-field-index="5"><span class="badge green">집화완료</span></td>
                  <td data-field-index="6">2026-08-05 14:32</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">402771223190</td>
                  <td data-field-index="1">ES260805-0130</td>
                  <td data-field-index="2">최지우</td>
                  <td data-field-index="3">한진택배</td>
                  <td data-field-index="4">부산해운대</td>
                  <td data-field-index="5"><span class="badge orange">배달출발</span></td>
                  <td data-field-index="6">2026-08-05 13:58</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
                  <td data-field-index="0">686018823441</td>
                  <td data-field-index="1">ES260804-0124</td>
                  <td data-field-index="2">윤서준</td>
                  <td data-field-index="3">롯데택배</td>
                  <td data-field-index="4">서울동남권</td>
                  <td data-field-index="5"><span class="badge green">배송중</span></td>
                  <td data-field-index="6">2026-08-05 13:40</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row">수정</button>
                    <button type="button" class="light-btn delete-row">삭제</button>
                  </td>
              </tr>
              </tbody>
            </table>
          </div>

          <div class="empty-state">검색 결과가 없습니다.</div>
          <div class="pagination" aria-label="목록 페이지 이동">
            <!-- 페이지 버튼의 모양은 JSP에 있고 JS는 이 template을 복제해서 번호만 바꿉니다. -->
          </div>
        </article>

                <template class="admin-row-template">
          <tr class="data-row">
            <td><input type="checkbox" class="row-check" aria-label="항목 선택"></td>
              <td data-field-index="0"></td>
              <td data-field-index="1"></td>
              <td data-field-index="2"></td>
              <td data-field-index="3"></td>
              <td data-field-index="4"></td>
              <td data-field-index="5"><span class="badge blue"></span></td>
              <td data-field-index="6"></td>
            <td class="action-cell">
              <button type="button" class="light-btn edit-row">수정</button>
              <button type="button" class="light-btn delete-row">삭제</button>
            </td>
          </tr>
        </template>

        <template class="admin-form-template">
          <div class="form-field">
            <label>송장번호</label>
            <input type="text" data-field-index="0" data-default="" placeholder="송장번호 입력">
          </div>
          <div class="form-field">
            <label>주문번호</label>
            <input type="text" data-field-index="1" data-default="" placeholder="주문번호 입력">
          </div>
          <div class="form-field">
            <label>구매자</label>
            <input type="text" data-field-index="2" data-default="" placeholder="구매자 입력">
          </div>
          <div class="form-field">
            <label>택배사</label>
            <input type="text" data-field-index="3" data-default="" placeholder="택배사 입력">
          </div>
          <div class="form-field">
            <label>현재위치</label>
            <input type="text" data-field-index="4" data-default="" placeholder="현재위치 입력">
          </div>
          <div class="form-field">
            <label>배송상태</label>
            <select data-field-index="5" data-default="">
              <option value="">선택해 주세요</option>
              <option value="집화완료">집화완료</option>
              <option value="배송중">배송중</option>
              <option value="배달출발">배달출발</option>
              <option value="배송완료">배송완료</option>
            </select>
          </div>
          <div class="form-field">
            <label>최종갱신</label>
            <input type="text" data-field-index="6" data-default="" placeholder="최종갱신 입력">
          </div>
        </template>
      </section>

      <!-- JS가 버튼 HTML을 문자열로 만들지 않도록 JSP에 페이지 버튼 템플릿을 둡니다. -->
      <template id="paginationButtonTemplate">
        <button type="button" class="page-number-button"></button>
      </template>

      <!-- CSV 저장용 링크도 JSP에 미리 둡니다. JS는 주소와 파일명만 설정합니다. -->
      <a id="adminCsvDownloadLink" hidden aria-hidden="true"></a>
    </section>
  </main>

  <!-- 등록/수정 모달의 바깥 디자인은 기존 공용 JSP를 그대로 사용합니다. -->
  <jsp:include page="/WEB-INF/views/admin/layout/modal.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
  <script src="${pageContext.request.contextPath}/dist/js/admin/list.js?v=20260813"></script>
</body>
</html>
