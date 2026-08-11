<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="adminPage" value="dashboard" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관리자 대시보드 | Yongsinsa</title>
  <script>
    document.documentElement.classList.add("ys-page-loading");
    window.__ysPageLoaderStart = Date.now();
  </script>
  <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/dashboard.css?v=20260810">
</head>
<body data-context-path="${pageContext.request.contextPath}">
  <jsp:include page="/WEB-INF/views/common/page-loader.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

  <main class="admin-main">
    <section class="page active" id="dashboard">
      <div class="page-heading">
        <div>
          <p id="dashboardDate">관리자 페이지</p>
          <h1>관리자 대시보드</h1>
          <span>오늘의 판매와 운영 현황을 한눈에 확인하세요.</span>
        </div>
        <a class="primary-btn" href="${pageContext.request.contextPath}/admin/product">+ 상품 등록</a>
      </div>

      <div class="summary-grid">
        <article>
          <span>오늘 주문</span><strong>128<small>건</small></strong>
          <em>어제보다 +12.4%</em>
        </article>
        <article>
          <span>오늘 매출</span><strong>12,840,000<small>원</small></strong>
          <em>어제보다 +8.2%</em>
        </article>
        <article>
          <span>배송 준비</span><strong>12<small>건</small></strong>
          <em class="warning">오늘 출고 예정</em>
        </article>
        <article>
          <span>미답변 문의</span><strong>5<small>건</small></strong>
          <em class="warning">답변이 필요해요</em>
        </article>
      </div>

      <div class="dashboard-grid">
        <article class="panel chart-panel">
          <div class="panel-title">
            <div>
              <h2>주간 매출 현황</h2>
              <p>최근 7일 결제 완료 기준</p>
            </div>
            <strong>₩ 68.4M</strong>
          </div>
          <div class="bars">
            <i style="height:42%"><span>월</span></i>
            <i style="height:57%"><span>화</span></i>
            <i style="height:50%"><span>수</span></i>
            <i style="height:76%"><span>목</span></i>
            <i style="height:63%"><span>금</span></i>
            <i style="height:92%"><span>토</span></i>
            <i style="height:70%"><span>일</span></i>
          </div>
        </article>

        <article class="panel task-panel">
          <div class="panel-title">
            <div>
              <h2>처리할 업무</h2>
              <p>빠른 확인이 필요한 항목</p>
            </div>
          </div>
          <a href="${pageContext.request.contextPath}/admin/member"><span>접속 제한 회원</span><b>3명 ›</b></a>
          <a href="${pageContext.request.contextPath}/admin/product"><span>품절 상품</span><b>3건 ›</b></a>
          <a href="${pageContext.request.contextPath}/admin/logistics"><span>반품·교환 요청</span><b>4건 ›</b></a>
          <a href="${pageContext.request.contextPath}/admin/support"><span>미답변 1:1 문의</span><b>5건 ›</b></a>
        </article>
      </div>

      <article class="panel">
        <div class="panel-title">
          <div>
            <h2>최근 주문</h2>
            <p>새로 접수된 주문 5건</p>
          </div>
          <a class="text-btn" href="${pageContext.request.contextPath}/admin/logistics">전체보기</a>
        </div>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>주문번호</th><th>상품</th><th>구매자</th><th>결제금액</th><th>주문상태</th><th>주문일시</th>
              </tr>
            </thead>
            <tbody>
              <tr><td>ES260803-0128</td><td>나이키 에어포스 1 '07</td><td>김민준</td><td>139,000원</td><td><span class="badge blue">결제완료</span></td><td>14:32</td></tr>
              <tr><td>ES260803-0127</td><td>뉴발란스 993 그레이</td><td>박서연</td><td>289,000원</td><td><span class="badge orange">배송준비</span></td><td>14:18</td></tr>
              <tr><td>ES260803-0126</td><td>아디다스 삼바 OG</td><td>이도윤</td><td>149,000원</td><td><span class="badge green">배송중</span></td><td>13:54</td></tr>
              <tr><td>ES260803-0125</td><td>아식스 젤 카야노 14</td><td>최지우</td><td>189,000원</td><td><span class="badge gray">배송완료</span></td><td>13:20</td></tr>
            </tbody>
          </table>
        </div>
      </article>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
  <script src="${pageContext.request.contextPath}/dist/js/admin/dashboard.js?v=20260810"></script>
</body>
</html>
