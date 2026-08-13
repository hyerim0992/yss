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
  <title>자주 묻는 질문 | Yongsinsa</title>
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
              <a href="${ctx}/customer/faq/list" class="is-active">자주 묻는 질문</a>
              <a href="${ctx}/customer/notice/list">공지사항</a>
              <a href="${ctx}/customer/inquiry/list">1:1 문의</a>
              <a href="${ctx}/customer/qna/list">상품문의</a>
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
            <section class="abc-cs-view is-active" aria-labelledby="abcFaqTitle">
              <header class="abc-cs-section-head">
                <div>
                  <h2 id="abcFaqTitle">자주 묻는 질문</h2>
                  <p>궁금한 내용을 검색하거나 카테고리를 선택해 빠르게 확인하세요.</p>
                </div>
              </header>

              <form class="abc-cs-search" id="abcFaqSearchForm" method="get" action="${ctx}/customer/faq/list">
                <i class="fas fa-search" aria-hidden="true"></i>
                <input id="abcFaqSearchInput" name="kwd" type="search" placeholder="궁금한 내용을 입력해 주세요." autocomplete="off" />
                <button type="submit">검색</button>
              </form>

              <div class="abc-cs-category-grid" aria-label="FAQ 카테고리">
                <button type="button" class="is-active" data-abc-faq-category="전체">전체</button>
                <button type="button" data-abc-faq-category="회원">회원</button>
                <button type="button" data-abc-faq-category="주문/결제">주문/결제</button>
                <button type="button" data-abc-faq-category="배송">배송</button>
                <button type="button" data-abc-faq-category="교환/반품">교환/반품</button>
                <button type="button" data-abc-faq-category="상품정보">상품정보</button>
                <button type="button" data-abc-faq-category="심의">심의</button>
                <button type="button" data-abc-faq-category="기타">기타</button>
              </div>

              <div class="abc-cs-list-title">
                <strong>자주 묻는 질문 BEST</strong>
                <span>총 <b id="abcFaqCount">8</b>건</span>
              </div>

              <!--
                ★ 연습 포인트
                지금은 샘플 FAQ를 JSP에 직접 적어 두었습니다.
                DB 연동을 시작하면 아래 article 8개를 보고 직접 c:forEach 형태로 바꿔보세요.
                답변 공개 여부 같은 조건이 생기면 조건문도 직접 작성하는 연습용입니다.
              -->
              <div class="abc-cs-faq-list" id="abcFaqList">
                <article class="abc-cs-faq-item" data-category="주문/결제" data-search="주문 취소 결제 환불 주문을 취소하고 싶어요">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false"><span class="abc-cs-row-category">주문/결제</span><strong>주문을 취소하고 싶어요.</strong><span class="abc-cs-arrow" aria-hidden="true"></span></button>
                  <div class="abc-cs-faq-answer"><p>상품 준비 전에는 마이페이지 주문내역에서 직접 취소할 수 있습니다. 상품 준비가 시작된 이후에는 판매자 확인이 필요할 수 있습니다.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="배송" data-search="배송 조회 운송장 언제 출발 배송 상태">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false"><span class="abc-cs-row-category">배송</span><strong>배송 상태와 운송장 번호는 어디에서 확인하나요?</strong><span class="abc-cs-arrow" aria-hidden="true"></span></button>
                  <div class="abc-cs-faq-answer"><p>마이페이지의 구매내역에서 배송 단계와 운송장 번호를 확인할 수 있습니다.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="교환/반품" data-search="교환 반품 접수 환불 사이즈 변경">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false"><span class="abc-cs-row-category">교환/반품</span><strong>교환 또는 반품은 어떻게 신청하나요?</strong><span class="abc-cs-arrow" aria-hidden="true"></span></button>
                  <div class="abc-cs-faq-answer"><p>상품 수령 후 7일 이내 마이페이지에서 신청해 주세요.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="상품정보" data-search="상품 가격 같은 상품 가격 다른 이유 판매 희망가">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false"><span class="abc-cs-row-category">상품정보</span><strong>같은 상품인데 가격이 다른 이유가 무엇인가요?</strong><span class="abc-cs-arrow" aria-hidden="true"></span></button>
                  <div class="abc-cs-faq-answer"><p>판매자, 사이즈, 상품 상태와 판매 희망가에 따라 가격이 달라질 수 있습니다.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="회원" data-search="회원 정보 비밀번호 아이디 연락처 변경">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false"><span class="abc-cs-row-category">회원</span><strong>회원정보와 비밀번호는 어디서 변경하나요?</strong><span class="abc-cs-arrow" aria-hidden="true"></span></button>
                  <div class="abc-cs-faq-answer"><p>마이페이지의 내 정보 메뉴에서 변경할 수 있습니다.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="심의" data-search="심의 신청 상품 상태 하자 오배송 이의 접수">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false"><span class="abc-cs-row-category">심의</span><strong>상품 상태에 대한 심의는 어떻게 신청하나요?</strong><span class="abc-cs-arrow" aria-hidden="true"></span></button>
                  <div class="abc-cs-faq-answer"><p>1:1 문의에서 주문번호, 문제 내용과 확인 가능한 사진을 함께 등록해 주세요.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="주문/결제" data-search="결제 수단 카드 간편 결제 변경">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false"><span class="abc-cs-row-category">주문/결제</span><strong>결제 완료 후 결제수단을 변경할 수 있나요?</strong><span class="abc-cs-arrow" aria-hidden="true"></span></button>
                  <div class="abc-cs-faq-answer"><p>결제 완료 후에는 결제수단만 따로 변경할 수 없습니다.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="기타" data-search="포인트 쿠폰 사용 유효 기간">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false"><span class="abc-cs-row-category">기타</span><strong>포인트와 쿠폰의 유효기간은 어디서 확인하나요?</strong><span class="abc-cs-arrow" aria-hidden="true"></span></button>
                  <div class="abc-cs-faq-answer"><p>마이페이지의 혜택 관리 메뉴에서 확인할 수 있습니다.</p></div>
                </article>
              </div>
              <div class="abc-cs-empty" id="abcFaqEmpty" hidden><strong>검색 결과가 없습니다.</strong><p>다른 검색어를 입력하거나 카테고리를 변경해 보세요.</p></div>
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
  <script src="${ctx}/dist/js/pages/customer/faq.js?v=20260812-jsp"></script>
  <script src="${ctx}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
