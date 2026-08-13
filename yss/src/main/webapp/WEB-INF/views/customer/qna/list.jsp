<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!doctype html>
<html class="no-js" lang="ko">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="x-ua-compatible" content="ie=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="shortcut icon" type="image/x-icon" href="${ctx}/dist/images/favicon.ico" />
  <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
  <link rel="stylesheet" href="${ctx}/dist/css/pages/customer/contact.css?v=20260812-jsp" />
  <link rel="stylesheet" href="${ctx}/dist/css/common/layout.css?v=20260806-0140" />
  <title>상품문의 | Yongsinsa</title>
</head>
<body class="has-site-layout">
  <jsp:include page="/WEB-INF/views/common/header.jsp" />
  <main class="abc-cs-page" id="abcCsPage" data-context-path="${ctx}">
      <div class="abc-cs-wrap">
        <nav class="abc-cs-breadcrumb" aria-label="현재 위치">
          <a href="${ctx}/index.jsp">HOME</a>
          <span>&gt;</span>
          <strong>고객센터</strong>
        </nav>

        <div class="abc-cs-layout">
          <aside class="abc-cs-sidebar" aria-label="고객센터 메뉴">
            <h1>고객센터</h1>
            <nav class="abc-cs-side-menu">
              <a href="${ctx}/customer/faq/list">자주 묻는 질문</a>
              <a href="${ctx}/customer/notice/list">공지사항</a>
              <a href="${ctx}/customer/inquiry/list">1:1 문의</a>
              <a href="${ctx}/customer/qna/list" class="is-active">상품문의</a>
            </nav>

            <div class="abc-cs-contact-box">
              <span>CS CENTER</span>
              <strong>1588-9667</strong>
              <p>평일 09:00 - 18:00</p>
              <p>점심 12:00 - 13:00</p>
              <p class="muted">주말·공휴일 휴무</p>
            </div>
          </aside>

          <div class="abc-cs-content">
            <section class="abc-cs-view is-active" aria-labelledby="abcQnaTitle">
              <header class="abc-cs-section-head"><div><h2 id="abcQnaTitle">상품문의</h2><p>상품의 사이즈, 재고, 구성과 상세정보에 대해 문의하세요.</p></div></header>

              <div class="abc-cs-subtabs">
                <button type="button" class="is-active" data-abc-qna-tab="write">상품문의 작성</button>
                <button type="button" data-abc-qna-tab="history">상품문의 내역</button>
              </div>

              <!-- ★ 연습 포인트: 상품 번호/상품명은 실제 상품 상세에서 넘어오는 값으로 바꿔보면 됩니다. -->
              <form class="abc-cs-form" id="abcQnaForm" data-abc-qna-panel="write">
                <label class="abc-cs-form-line"><span class="abc-cs-form-label">상품명 <b>*</b></span><input name="productName" maxlength="80" required value="나이키 에어포스 1 '07" /></label>
                <div class="abc-cs-form-line"><div class="abc-cs-form-label">문의 유형 <b>*</b></div><div class="abc-cs-choice-group" data-choice-group="qnaType"><input type="hidden" name="qnaType" /><button type="button" data-choice-value="사이즈">사이즈</button><button type="button" data-choice-value="재고">재고</button><button type="button" data-choice-value="상품정보">상품정보</button><button type="button" data-choice-value="배송">배송</button><button type="button" data-choice-value="기타">기타</button></div></div>
                <label class="abc-cs-form-line"><span class="abc-cs-form-label">제목 <b>*</b></span><input name="title" maxlength="50" required placeholder="상품문의 제목을 입력해 주세요." /></label>
                <label class="abc-cs-form-line abc-cs-form-line--textarea"><span class="abc-cs-form-label">내용 <b>*</b></span><span class="abc-cs-textarea-wrap"><textarea id="abcQnaContent" name="content" maxlength="1000" required placeholder="상품에 대해 궁금한 내용을 입력해 주세요."></textarea><small><span data-abc-count="abcQnaContent">0</span>/1000</small></span></label>
                <div class="abc-cs-form-actions"><button type="reset" class="abc-cs-btn abc-cs-btn--light"><span class="abc-cs-btn-label">취소</span></button><button type="submit" class="abc-cs-btn abc-cs-btn--dark"><span class="abc-cs-btn-label">문의 등록</span></button></div>
              </form>

              <div class="abc-cs-history" data-abc-qna-panel="history" hidden>
                <div class="abc-cs-table-head abc-cs-qna-columns"><span>상품명</span><span>문의제목</span><span>답변상태</span><span>등록일</span></div>
                <!-- ★ 연습 포인트: 아래 샘플 3줄을 나중에 DB 목록으로 교체하세요. -->
                <div id="abcQnaHistoryList">
                  <div class="abc-cs-qna-row"><span>나이키 에어포스 1 '07</span><strong>정사이즈인가요?</strong><span>미답변</span><time>2026.08.05</time></div>
                  <div class="abc-cs-qna-row"><span>뉴발란스 993 그레이</span><strong>구성품 문의</strong><span>답변완료</span><time>2026.08.04</time></div>
                  <div class="abc-cs-qna-row"><span>아식스 젤 카야노 14</span><strong>재입고 일정이 있나요?</strong><span>미답변</span><time>2026.08.04</time></div>
                </div>
                <div class="abc-cs-empty" id="abcQnaHistoryEmpty" hidden><strong>등록된 상품문의가 없습니다.</strong><p>상품문의 작성 탭에서 새로운 문의를 남겨보세요.</p></div>
              </div>
              <template id="abcQnaHistoryTemplate"><div class="abc-cs-qna-row"><span data-qna-product></span><strong data-qna-title></strong><span data-qna-status>미답변</span><time data-qna-date></time></div></template>
            </section>
          </div>
        </div>
      </div>
    </main>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
  <div class="abc-cs-toast" id="abcCsToast" role="status" aria-live="polite"></div>

  <script src="${ctx}/dist/js/vendor/modernizr-3.5.0.min.js"></script>
  <script src="https://code.jquery.com/jquery-4.0.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
  <script src="${ctx}/dist/js/vendor/owl.carousel.min.js"></script>
  <script src="${ctx}/dist/js/vendor/slick.min.js"></script>
  <script src="${ctx}/dist/js/vendor/wow.min.js"></script>
  <script src="${ctx}/dist/js/vendor/jquery.scrollUp.min.js"></script>
  <script src="${ctx}/dist/js/vendor/jquery.nice-select.min.js"></script>
  <script src="${ctx}/dist/js/vendor/jquery.magnific-popup.js"></script>
  <script src="${ctx}/dist/js/common/plugins.js"></script>
  <script src="${ctx}/dist/js/common/main.js"></script>
  <script src="${ctx}/dist/js/pages/customer/qna.js?v=20260812-jsp"></script>
  <script src="${ctx}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
