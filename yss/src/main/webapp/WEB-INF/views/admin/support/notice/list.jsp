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
        <a href="${pageContext.request.contextPath}/admin/support/notice/write" class="primary-btn">+ 공지 등록</a>
      </div>

      <nav class="support-tabs" aria-label="고객지원 관리 탭">
        <a href="${pageContext.request.contextPath}/admin/support/inquiry/list">1:1 문의 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/faq/list">FAQ 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/notice/list" class="active">공지사항 관리</a>
        <a href="${pageContext.request.contextPath}/admin/support/qna/list">상품문의 관리</a>
      </nav>

      <!--
        연습 포인트
        1) 검색어/검색조건을 Controller에서 받아 다시 화면에 표시해보기
        2) 검색 버튼을 눌렀을 때 Controller -> Service -> Mapper로 조회되게 연결해보기
      -->
      <form method="get" action="${pageContext.request.contextPath}/admin/support/notice/list"
            class="panel search-panel support-search-form">
        <div class="search-row">
          <select name="schType">
            <option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
            <option value="title" ${schType=="title"?"selected":""}>제목</option>
            <option value="content" ${schType=="content"?"selected":""}>내용</option>
            <option value="name" ${schType=="name"?"selected":""}>작성자</option>
          </select>

          <input type="text" name="kwd" value="${kwd}" placeholder="검색어를 입력하세요">
          
          <input type="hidden" name="size" value="${size}">

          <button type="submit" class="dark-btn">검색</button>
          <a href="${pageContext.request.contextPath}/admin/support/notice/list" class="light-btn">초기화</a>
        </div>
      </form>

      <article class="panel">
        <div class="panel-title">
          <div>
            <h2>공지사항 목록</h2>
            <p>검색 결과 <b>${dataCount}</b>건 · 선택 0건</p>
          </div>

          <div>
            <button type="button" class="light-btn danger-btn">선택 삭제</button>
          </div>
        </div>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th><input type="checkbox" id="checkAll"></th>
                <th>공지사항 번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일시</th>
                <th>관리</th>
              </tr>
            </thead>

            <tbody>
              <!--
                ★ 연습할 부분
                아래 샘플 행을 목록 데이터 반복 출력 코드로 직접 바꿔보세요.
                공지등록/상태 값에 따라 표시 방법도 직접 정해보세요.
              -->
              <c:forEach var="dto" items="${list}">
              	<tr>
              		<td>
              			<input type="checkbox" name="nums" value="dto.noticeId" class="row-check">
              		</td>
              		
              		<td>${dto.noticeId}</td>
              		
              		<td>
              			<a href="${articleUrl}&noticeId=${dto.noticeId}" class="text-reset">
              			<c:out value="${dto.title}"/>
              			</a>
              		</td>
              		
              		<td>${dto.name}</td>
              		
              		<td>${dto.createDate}</td>
              		<td>
              			<div class="support-actions">
              				<a href="${pageContext.request.contextPath}/admin/support/notice/update?page=${page}&noticeId=${dto.noticeId}"
              					class="light-btn">
              					수정
              				</a>
              				
              				<a href="${pageContext.request.contextPath}/admin/support/notice/delete?noticeId=${dto.noticeId}&page=${page}&size=${size}"
              					class="light-btn"
              					onclick="return confirm('공지사항을 삭제하시겠습니까?');">
              					삭제
              				</a>
              			</div>
              		</td>
              	</tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <!-- TODO : 실제 페이징 값으로 바꿔보기 -->
        <div class="support-pagination">
			${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
        </div>
      </article>

    </section>
  </main>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
  
  <script type="text/javascript">
	  const checkAll = document.getElementById('checkAll');
	  const rowChecks = document.querySelectorAll('.row-check');
	
	  checkAll.addEventListener('change', function() {
	    rowChecks.forEach(function(chk) {
	      chk.checked = checkAll.checked;
	    });
	  });
	
	  rowChecks.forEach(function(chk) {
	    chk.addEventListener('change', function() {
	      checkAll.checked =
	        document.querySelectorAll('.row-check:checked').length === rowChecks.length;
	    });
	  });
  </script>
</body>
</html>
