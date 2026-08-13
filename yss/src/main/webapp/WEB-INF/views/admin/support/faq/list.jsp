<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="adminPage" value="support" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>고객지원 | Yongsinsa 관리자</title>

  <script>
    document.documentElement.classList.add("ys-page-loading");
    window.__ysPageLoaderStart = Date.now();
  </script>

  <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/list.css?v=20260812">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/support.css?v=20260812">
</head>
<body>
  <jsp:include page="/WEB-INF/views/common/page-loader.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

  <main class="admin-main">
    <section class="page active">
      <div class="page-heading">
        <div>
          <p>관리자 페이지 / 고객 지원 / 관리</p>
          <h1>고객 지원 / 관리</h1>
          <span>1:1 문의, FAQ, 공지사항과 상품문의 답변을 관리합니다.</span>
        </div>
        <a href="#" class="primary-btn">+ FAQ 등록</a>
      </div>

      <nav class="support-tabs" aria-label="고객지원 관리 탭">
        <a href="${pageContext.request.contextPath}/admin/support/inquiry/list">1:1 문의 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/faq/list" class="active">FAQ 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/notice/list">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/qna/list">상품문의 관리</a>
      </nav>

      <!--
        연습 포인트
        1) 검색어/검색조건을 Controller에서 받아 다시 화면에 표시해보기
        2) 검색 버튼을 눌렀을 때 Controller -> Service -> Mapper로 조회되게 연결해보기
      -->
      <form method="get" action="${pageContext.request.contextPath}/admin/support/faq/list"
            class="panel search-panel support-search-form">
        <div class="search-row">
          <select name="schType">
            <option value="all">전체</option>
            <option value="category">카테고리</option>
            <option value="question">질문</option>
          </select>

          <input type="text" name="kwd" placeholder="검색어를 입력하세요">

          <button type="submit" class="dark-btn">검색</button>
          <a href="${pageContext.request.contextPath}/admin/support/faq/list" class="light-btn">초기화</a>
        </div>
        <div class="filter-row">
          <div class="filter-control">
            <label for="status">공개상태</label>
            <select name="status" id="status">
              <option value="all">전체</option>
              <option value="공개">공개</option>
              <option value="비공개">비공개</option>
            </select>
          </div>
        </div>
      </form>

      <article class="panel">
        <div class="panel-title">
          <div>
            <h2>FAQ 목록</h2>
            <p>검색 결과 <b>3</b>건 · 선택 0건</p>
          </div>

          <div>
            <button type="button" class="light-btn danger-btn">선택 삭제</button>
            <button type="button" class="light-btn">CSV 저장</button>
          </div>
        </div>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th><input type="checkbox"></th>
                <th>FAQ번호</th>
                <th>카테고리</th>
                <th>질문</th>
                <th>공개상태</th>
                <th>조회수</th>
                <th>등록일</th>
                <th>수정일</th>
                <th>관리</th>
              </tr>
            </thead>

            <tbody>
              <!--
                ★ 연습할 부분
                아래 샘플 행을 보고 목록 데이터를 반복 출력하도록 직접 바꿔보세요.
                공개/비공개 상태에 따라 badge도 직접 조건 처리해보세요.
              -->
              <tr>
                <td><input type="checkbox" name="nums"></td>
                <td>FAQ-021</td>
                <td>주문/결제</td>
                <td><a href="#" class="text-reset">결제수단을 변경할 수 있나요?</a></td>
                <td><span class="badge green">공개</span></td>
                <td>1,284</td>
                <td>2026-07-22</td>
                <td>2026-08-02</td>
                <td>
                  <div class="support-actions">
                    <a href="#" class="light-btn">수정</a>
                    <button type="button" class="light-btn">삭제</button>
                  </div>
                </td>
              </tr>

              <tr>
                <td><input type="checkbox" name="nums"></td>
                <td>FAQ-020</td>
                <td>배송</td>
                <td><a href="#" class="text-reset">배송 조회는 어디에서 하나요?</a></td>
                <td><span class="badge green">공개</span></td>
                <td>2,102</td>
                <td>2026-07-18</td>
                <td>2026-08-01</td>
                <td>
                  <div class="support-actions">
                    <a href="#" class="light-btn">수정</a>
                    <button type="button" class="light-btn">삭제</button>
                  </div>
                </td>
              </tr>

              <tr>
                <td><input type="checkbox" name="nums"></td>
                <td>FAQ-019</td>
                <td>교환/반품</td>
                <td><a href="#" class="text-reset">교환 신청 절차가 궁금해요.</a></td>
                <td><span class="badge gray">비공개</span></td>
                <td>640</td>
                <td>2026-07-10</td>
                <td>2026-07-30</td>
                <td>
                  <div class="support-actions">
                    <a href="#" class="light-btn">수정</a>
                    <button type="button" class="light-btn">삭제</button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <!-- TODO : 실제 페이징 값으로 바꿔보기 -->
        <div class="support-pagination">
          <span>‹</span>
          <span class="active">1</span>
          <span>›</span>
        </div>
      </article>

    </section>
  </main>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>
