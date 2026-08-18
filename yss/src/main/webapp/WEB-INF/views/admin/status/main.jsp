<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="adminPage" value="status" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>통계현황 | Yongsinsa 관리자</title>
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
    <section class="page active admin-static-page" data-page-key="status">
      <div class="page-heading">
        <div>
          <p>관리자 페이지 / 통계 현황 관리</p>
          <h1>통계 현황 관리</h1>
          <span>접속자와 매출을 기간별 통계로 확인합니다.</span>
        </div>
      </div>

      <nav class="sub-tabs" aria-label="통계 현황 관리 탭">
        <button type="button" data-section-target="0" class="active">접속자 현황</button>
        <button type="button" data-section-target="1" class="">매출 현황</button>
      </nav>

      <section class="admin-section-panel active" data-admin-section="0" data-section-name="접속자 현황" data-table-title="접속자 통계" data-add-label="+ 신규 등록" data-can-add="false">
        <article class="panel search-panel">
          <div class="search-row">
            <select class="js-search-type" aria-label="검색 항목" disabled>
              <option value="all">전체</option>
              <option value="0">날짜</option>
              <option value="1">방문자수</option>
              <option value="2">로그인회원</option>
              <option value="3">비회원</option>
              <option value="4">평균접속시간</option>
              <option value="5">최고접속시간대</option>
              <option value="6">전일대비</option>
            </select>
            <input type="search" class="js-search-keyword" placeholder="검색어를 입력하세요" disabled>
            <button type="button" class="dark-btn js-search-button" disabled title="백엔드 기능 구현 전">검색</button>
            <button type="button" class="light-btn js-reset-button" disabled title="백엔드 기능 구현 전">초기화</button>
          </div>
          <div class="filter-row" aria-label="추가 검색 조건">
          <div class="filter-control range-control" data-filter-type="dateRange" data-filter-column="0">
            <label>조회기간</label>
            <div class="filter-date-range">
              <input type="date" class="filter-from" aria-label="조회기간 시작일" disabled>
              <span>~</span>
              <input type="date" class="filter-to" aria-label="조회기간 종료일" disabled>
            </div>
          </div>
          </div>
        </article>

        <article class="panel">
          <div class="panel-title">
            <div>
              <h2>접속자 통계</h2>
              <p>검색 결과 <b class="result-count">3</b>건 · 선택 <b class="selected-count">0</b>건</p>
            </div>
            <div>
              <button type="button" class="light-btn danger-btn delete-selected-button" disabled title="백엔드 기능 구현 전">선택 삭제</button>
              <button type="button" class="light-btn export-button" disabled title="백엔드 기능 구현 전">CSV 저장</button>
            </div>
          </div>

          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th><input type="checkbox" class="check-all" aria-label="현재 페이지 전체 선택" disabled></th>
                  <th>날짜</th>
                  <th>방문자수</th>
                  <th>로그인회원</th>
                  <th>비회원</th>
                  <th>평균접속시간</th>
                  <th>최고접속시간대</th>
                  <th>전일대비</th>
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
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택" disabled></td>
                  <td data-field-index="0">2026-08-05</td>
                  <td data-field-index="1">2,984</td>
                  <td data-field-index="2">1,142</td>
                  <td data-field-index="3">1,842</td>
                  <td data-field-index="4">08분 42초</td>
                  <td data-field-index="5">20:00~21:00</td>
                  <td data-field-index="6">+6.0%</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row" disabled title="백엔드 기능 구현 전">수정</button>
                    <button type="button" class="light-btn delete-row" disabled title="백엔드 기능 구현 전">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택" disabled></td>
                  <td data-field-index="0">2026-08-04</td>
                  <td data-field-index="1">2,814</td>
                  <td data-field-index="2">1,096</td>
                  <td data-field-index="3">1,718</td>
                  <td data-field-index="4">08분 15초</td>
                  <td data-field-index="5">19:00~20:00</td>
                  <td data-field-index="6">+10.5%</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row" disabled title="백엔드 기능 구현 전">수정</button>
                    <button type="button" class="light-btn delete-row" disabled title="백엔드 기능 구현 전">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택" disabled></td>
                  <td data-field-index="0">2026-08-03</td>
                  <td data-field-index="1">2,546</td>
                  <td data-field-index="2">984</td>
                  <td data-field-index="3">1,562</td>
                  <td data-field-index="4">07분 58초</td>
                  <td data-field-index="5">20:00~21:00</td>
                  <td data-field-index="6">+6.4%</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row" disabled title="백엔드 기능 구현 전">수정</button>
                    <button type="button" class="light-btn delete-row" disabled title="백엔드 기능 구현 전">삭제</button>
                  </td>
              </tr>
              </tbody>
            </table>
          </div>

          <div class="empty-state">검색 결과가 없습니다.</div>
          <div class="pagination" aria-label="목록 페이지 이동">
            <button type="button" class="page-prev" aria-label="이전 페이지" disabled title="백엔드 기능 구현 전">‹</button>
            <span class="page-info">1 / 1</span>
            <button type="button" class="page-next" aria-label="다음 페이지" disabled title="백엔드 기능 구현 전">›</button>
          </div>
        </article>

      </section>

      <section class="admin-section-panel" data-admin-section="1" data-section-name="매출 현황" data-table-title="기간별 매출 통계" data-add-label="+ 신규 등록" data-can-add="false" hidden>
        <article class="panel search-panel">
          <div class="search-row">
            <select class="js-search-type" aria-label="검색 항목" disabled>
              <option value="all">전체</option>
              <option value="0">기간</option>
              <option value="1">거래건수</option>
              <option value="2">거래액</option>
              <option value="3">매입원가</option>
              <option value="4">총 시세차익</option>
              <option value="5">반품액</option>
              <option value="6">순거래액</option>
            </select>
            <input type="search" class="js-search-keyword" placeholder="검색어를 입력하세요" disabled>
            <button type="button" class="dark-btn js-search-button" disabled title="백엔드 기능 구현 전">검색</button>
            <button type="button" class="light-btn js-reset-button" disabled title="백엔드 기능 구현 전">초기화</button>
          </div>
          <div class="filter-row is-hidden" aria-label="추가 검색 조건">
            <!-- 이 탭은 추가 검색 조건이 없습니다. -->
          </div>
        </article>

        <article class="panel">
          <div class="panel-title">
            <div>
              <h2>기간별 매출 통계</h2>
              <p>검색 결과 <b class="result-count">3</b>건 · 선택 <b class="selected-count">0</b>건</p>
            </div>
            <div>
              <button type="button" class="light-btn danger-btn delete-selected-button" disabled title="백엔드 기능 구현 전">선택 삭제</button>
              <button type="button" class="light-btn export-button" disabled title="백엔드 기능 구현 전">CSV 저장</button>
            </div>
          </div>

          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th><input type="checkbox" class="check-all" aria-label="현재 페이지 전체 선택" disabled></th>
                  <th>기간</th>
                  <th>거래건수</th>
                  <th>거래액</th>
                  <th>매입원가</th>
                  <th>총 시세차익</th>
                  <th>반품액</th>
                  <th>순거래액</th>
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
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택" disabled></td>
                  <td data-field-index="0">2026-08-05</td>
                  <td data-field-index="1">132건</td>
                  <td data-field-index="2">13,480,000원</td>
                  <td data-field-index="3">9,120,000원</td>
                  <td data-field-index="4">4,360,000원</td>
                  <td data-field-index="5">210,000원</td>
                  <td data-field-index="6">13,270,000원</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row" disabled title="백엔드 기능 구현 전">수정</button>
                    <button type="button" class="light-btn delete-row" disabled title="백엔드 기능 구현 전">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택" disabled></td>
                  <td data-field-index="0">2026-08-04</td>
                  <td data-field-index="1">128건</td>
                  <td data-field-index="2">12,840,000원</td>
                  <td data-field-index="3">8,730,000원</td>
                  <td data-field-index="4">4,110,000원</td>
                  <td data-field-index="5">530,000원</td>
                  <td data-field-index="6">12,310,000원</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row" disabled title="백엔드 기능 구현 전">수정</button>
                    <button type="button" class="light-btn delete-row" disabled title="백엔드 기능 구현 전">삭제</button>
                  </td>
              </tr>

              <tr class="data-row">
                  <td><input type="checkbox" class="row-check" aria-label="항목 선택" disabled></td>
                  <td data-field-index="0">2026-08-03</td>
                  <td data-field-index="1">114건</td>
                  <td data-field-index="2">11,870,000원</td>
                  <td data-field-index="3">8,090,000원</td>
                  <td data-field-index="4">3,780,000원</td>
                  <td data-field-index="5">410,000원</td>
                  <td data-field-index="6">11,460,000원</td>
                  <td class="action-cell">
                    <button type="button" class="light-btn edit-row" disabled title="백엔드 기능 구현 전">수정</button>
                    <button type="button" class="light-btn delete-row" disabled title="백엔드 기능 구현 전">삭제</button>
                  </td>
              </tr>
              </tbody>
            </table>
          </div>

          <div class="empty-state">검색 결과가 없습니다.</div>
          <div class="pagination" aria-label="목록 페이지 이동">
            <button type="button" class="page-prev" aria-label="이전 페이지" disabled title="백엔드 기능 구현 전">‹</button>
            <span class="page-info">1 / 1</span>
            <button type="button" class="page-next" aria-label="다음 페이지" disabled title="백엔드 기능 구현 전">›</button>
          </div>
        </article>

      </section>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
  <!-- 현재 백엔드가 없는 화면이므로 status.js는 탭 전환만 담당합니다. -->
  <script src="${pageContext.request.contextPath}/dist/js/admin/status.js?v=20260818"></script>
</body>
</html>
