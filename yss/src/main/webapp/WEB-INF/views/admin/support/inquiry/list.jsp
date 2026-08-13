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
        <!-- 상품문의는 고객이 작성하므로 관리자 신규등록 버튼은 비워둡니다. -->
      </div>

      <nav class="support-tabs" aria-label="고객지원 관리 탭">
        <a href="${pageContext.request.contextPath}/admin/support/inquiry/list" class="active">1:1 문의 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/faq/list">FAQ 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/notice/list">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/qna/list">상품문의 관리</a>
      </nav>

      <!--
        연습 포인트
        1) 검색어/검색조건을 Controller에서 받아 다시 화면에 표시해보기
        2) 검색 버튼을 눌렀을 때 Controller -> Service -> Mapper로 조회되게 연결해보기
      -->
      <form method="get" action="${pageContext.request.contextPath}/admin/support/inquiry/list"
            class="panel search-panel support-search-form">
        <div class="search-row">
          <select name="schType">
            <option value="all">전체</option>
            <option value="productName">상품명</option>
            <option value="subject">문의제목</option>
            <option value="writer">작성자</option>
          </select>

          <input type="text" name="kwd" placeholder="검색어를 입력하세요">

          <button type="submit" class="dark-btn">검색</button>
          <a href="${pageContext.request.contextPath}/admin/support/inquiry/list" class="light-btn">초기화</a>
        </div>
        <div class="filter-row">
          <div class="filter-control">
            <label for="status">답변상태</label>
            <select name="status" id="status">
              <option value="all">전체</option>
              <option value="미답변">미답변</option>
              <option value="답변완료">답변완료</option>
            </select>
          </div>
        </div>
      </form>

      <article class="panel">
        <div class="panel-title">
          <div>
            <h2>상품문의 목록</h2>
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
                <th>문의번호</th>
                <th>상품명</th>
                <th>문의제목</th>
                <th>작성자</th>
                <th>등록일</th>
                <th>답변상태</th>
                <th>담당자</th>
                <th>관리</th>
              </tr>
            </thead>

            <tbody>
              <!--
                ★ 연습할 부분
                아래 샘플 행을 목록 데이터 반복 출력 코드로 직접 바꿔보세요.
                답변상태에 따라 '답변 등록 / 답변 수정' 버튼도 직접 조건 처리해보세요.
              -->
              <tr>
                <td><input type="checkbox" name="nums"></td>
                <td>PQ-2201</td>
                <td>나이키 에어포스 1 '07</td>
                <td><a href="#" class="text-reset">정사이즈인가요?</a></td>
                <td>sneaker01</td>
                <td>2026-08-05</td>
                <td><span class="badge gray">미답변</span></td>
                <td>-</td>
                <td>
                  <div class="support-actions">
                    <a href="#" class="light-btn answer-btn">답변 등록</a>
                    <a href="#" class="light-btn">수정</a>
                    <button type="button" class="light-btn">삭제</button>
                  </div>
                </td>
              </tr>

              <tr>
                <td><input type="checkbox" name="nums"></td>
                <td>PQ-2200</td>
                <td>뉴발란스 993 그레이</td>
                <td><a href="#" class="text-reset">구성품 문의</a></td>
                <td>grey993</td>
                <td>2026-08-04</td>
                <td><span class="badge green">답변완료</span></td>
                <td>관리자</td>
                <td>
                  <div class="support-actions">
                    <a href="#" class="light-btn answer-btn completed">답변 수정</a>
                    <a href="#" class="light-btn">수정</a>
                    <button type="button" class="light-btn">삭제</button>
                  </div>
                </td>
              </tr>

              <tr>
                <td><input type="checkbox" name="nums"></td>
                <td>PQ-2199</td>
                <td>아식스 젤 카야노 14</td>
                <td><a href="#" class="text-reset">재입고 예정</a></td>
                <td>runner22</td>
                <td>2026-08-04</td>
                <td><span class="badge gray">미답변</span></td>
                <td>-</td>
                <td>
                  <div class="support-actions">
                    <a href="#" class="light-btn answer-btn">답변 등록</a>
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
