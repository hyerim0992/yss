<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<section class="page active" id="listPage">
  <div class="page-heading">
    <div>
      <p id="breadcrumb">관리자 페이지</p>
      <h1 id="pageTitle">관리</h1>
      <span id="pageDesc">관리 화면입니다.</span>
    </div>
    <button type="button" class="primary-btn" id="addButton">+ 신규 등록</button>
  </div>

  <div class="sub-tabs" id="subTabs"></div>

  <article class="panel search-panel">
    <div class="search-row">
      <select id="searchType">
        <option>전체</option>
      </select>
      <input id="searchKeyword" placeholder="검색어를 입력하세요">
      <button type="button" class="dark-btn" id="searchButton">검색</button>
      <button type="button" class="light-btn" id="resetButton">초기화</button>
    </div>
    <div class="filter-row" id="filterFields" aria-label="추가 검색 조건"></div>
  </article>

  <article class="panel">
    <div class="panel-title">
      <div>
        <h2 id="tableTitle">목록</h2>
        <p>
          검색 결과 <b id="resultCount">0</b>건 · 선택
          <b id="selectedCount">0</b>건
        </p>
      </div>
      <div>
        <button type="button" class="light-btn danger-btn" id="deleteSelectedButton">선택 삭제</button>
        <button type="button" class="light-btn" id="exportButton">CSV 저장</button>
      </div>
    </div>

    <div class="table-wrap">
      <table>
        <thead id="dataHead"></thead>
        <tbody id="dataBody"></tbody>
      </table>
    </div>

    <div class="empty-state" id="emptyState">검색 결과가 없습니다.</div>
    <div class="pagination" id="pagination"></div>
  </article>
</section>
