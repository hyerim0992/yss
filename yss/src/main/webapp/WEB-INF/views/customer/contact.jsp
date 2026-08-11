<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!doctype html>
<html class="no-js" lang="ko">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>고객센터 | Yongsinsa</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      rel="shortcut icon"
      type="image/x-icon"
      href="${ctx}/dist/images/favicon.ico"
    />

    <!-- 화면 스타일 파일 -->
    <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/pages/customer/contact.css?v=20260806-0140" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/common/layout.css?v=20260806-0140" />
</head>

  <body class="has-site-layout">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    



    <main class="abc-cs-page" id="abcCsPage" data-logged-in="${not empty sessionScope.sessionInfo or param.testLogin eq '1'}" data-context-path="${ctx}">
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
              <button type="button" class="is-active" data-abc-open="faq">자주 묻는 질문</button>
              <button type="button" data-abc-open="notice">공지사항</button>
              <button type="button" data-abc-open="inquiry" data-requires-login="true">1:1 문의</button>
              <button type="button" data-abc-open="voice" data-requires-login="true">고객의 소리</button>
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
            <!-- FAQ -->
            <section class="abc-cs-view is-active" data-abc-view="faq" aria-labelledby="abcFaqTitle">
              <header class="abc-cs-section-head">
                <div>
                  <h2 id="abcFaqTitle">자주 묻는 질문</h2>
                  <p>궁금한 내용을 검색하거나 카테고리를 선택해 빠르게 확인하세요.</p>
                </div>
              </header>

              <form class="abc-cs-search" id="abcFaqSearchForm">
                <i class="fas fa-search" aria-hidden="true"></i>
                <input id="abcFaqSearchInput" type="search" placeholder="궁금한 내용을 입력해 주세요." autocomplete="off" />
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

              <div class="abc-cs-faq-list" id="abcFaqList">
                <article class="abc-cs-faq-item" data-category="주문/결제" data-search="주문 취소 결제 환불 주문을 취소하고 싶어요">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false">
                    <span class="abc-cs-row-category">주문/결제</span>
                    <strong>주문을 취소하고 싶어요.</strong>
                    <span class="abc-cs-arrow" aria-hidden="true"></span>
                  </button>
                  <div class="abc-cs-faq-answer"><p>상품 준비 전에는 마이페이지 주문내역에서 직접 취소할 수 있습니다. 상품 준비가 시작된 이후에는 판매자 확인이 필요할 수 있습니다.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="배송" data-search="배송 조회 운송장 언제 출발 배송 상태">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false">
                    <span class="abc-cs-row-category">배송</span>
                    <strong>배송 상태와 운송장 번호는 어디에서 확인하나요?</strong>
                    <span class="abc-cs-arrow" aria-hidden="true"></span>
                  </button>
                  <div class="abc-cs-faq-answer"><p>마이페이지의 구매내역 또는 판매내역에서 배송 단계와 운송장 번호를 확인할 수 있습니다. 운송장 등록 후 조회 반영까지 시간이 걸릴 수 있습니다.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="교환/반품" data-search="교환 반품 접수 환불 사이즈 변경">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false">
                    <span class="abc-cs-row-category">교환/반품</span>
                    <strong>교환 또는 반품은 어떻게 신청하나요?</strong>
                    <span class="abc-cs-arrow" aria-hidden="true"></span>
                  </button>
                  <div class="abc-cs-faq-answer"><p>상품 수령 후 7일 이내 마이페이지에서 신청해 주세요. 상품 사용 흔적, 구성품 누락 또는 훼손이 있는 경우 접수가 제한될 수 있습니다.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="상품정보" data-search="상품 가격 같은 상품 가격 다른 이유 판매 희망가">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false">
                    <span class="abc-cs-row-category">상품정보</span>
                    <strong>같은 상품인데 가격이 다른 이유가 무엇인가요?</strong>
                    <span class="abc-cs-arrow" aria-hidden="true"></span>
                  </button>
                  <div class="abc-cs-faq-answer"><p>판매자, 사이즈, 상품 상태, 배송 방식과 판매 희망가에 따라 가격이 달라질 수 있습니다. 상세페이지에서 옵션별 가격을 확인해 주세요.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="회원" data-search="회원 정보 비밀번호 아이디 연락처 변경">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false">
                    <span class="abc-cs-row-category">회원</span>
                    <strong>회원정보와 비밀번호는 어디서 변경하나요?</strong>
                    <span class="abc-cs-arrow" aria-hidden="true"></span>
                  </button>
                  <div class="abc-cs-faq-answer"><p>마이페이지의 내 정보 메뉴에서 비밀번호, 연락처, 이메일과 배송지를 변경할 수 있습니다.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="심의" data-search="심의 신청 상품 상태 하자 오배송 이의 접수">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false">
                    <span class="abc-cs-row-category">심의</span>
                    <strong>상품 상태에 대한 심의는 어떻게 신청하나요?</strong>
                    <span class="abc-cs-arrow" aria-hidden="true"></span>
                  </button>
                  <div class="abc-cs-faq-answer"><p>수령한 상품에 하자가 있거나 상품 정보와 실제 상태가 다른 경우 마이페이지의 1:1 문의에서 심의를 신청할 수 있습니다. 주문번호, 문제 내용과 확인 가능한 사진을 함께 등록해 주세요.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="주문/결제" data-search="결제 수단 카드 간편 결제 변경">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false">
                    <span class="abc-cs-row-category">주문/결제</span>
                    <strong>결제 완료 후 결제수단을 변경할 수 있나요?</strong>
                    <span class="abc-cs-arrow" aria-hidden="true"></span>
                  </button>
                  <div class="abc-cs-faq-answer"><p>결제 완료 후에는 결제수단만 따로 변경할 수 없습니다. 주문 취소가 가능한 단계라면 취소 후 다시 주문해 주세요.</p></div>
                </article>
                <article class="abc-cs-faq-item" data-category="기타" data-search="포인트 쿠폰 사용 유효 기간">
                  <button type="button" class="abc-cs-faq-question" aria-expanded="false">
                    <span class="abc-cs-row-category">기타</span>
                    <strong>포인트와 쿠폰의 유효기간은 어디서 확인하나요?</strong>
                    <span class="abc-cs-arrow" aria-hidden="true"></span>
                  </button>
                  <div class="abc-cs-faq-answer"><p>마이페이지의 혜택 관리 메뉴에서 보유 포인트와 쿠폰의 사용 조건 및 유효기간을 확인할 수 있습니다.</p></div>
                </article>
              </div>
              <div class="abc-cs-empty" id="abcFaqEmpty" hidden>
                <strong>검색 결과가 없습니다.</strong>
                <p>다른 검색어를 입력하거나 카테고리를 변경해 보세요.</p>
              </div>
            </section>

            <!-- 공지사항 -->
            <section class="abc-cs-view" data-abc-view="notice" aria-labelledby="abcNoticeTitle" hidden>
              <header class="abc-cs-section-head">
                <div>
                  <h2 id="abcNoticeTitle">공지사항</h2>
                  <p>서비스 운영과 이벤트 관련 주요 안내를 확인하세요.</p>
                </div>
              </header>

              <form class="abc-cs-search" id="abcNoticeSearchForm">
                <i class="fas fa-search" aria-hidden="true"></i>
                <input id="abcNoticeSearchInput" type="search" placeholder="공지사항 제목을 검색해 주세요." autocomplete="off" />
                <button type="submit">검색</button>
              </form>

              <div class="abc-cs-category-grid abc-cs-category-grid--notice" aria-label="공지사항 분류">
                <button type="button" class="is-active" data-abc-notice-category="전체">전체</button>
                <button type="button" data-abc-notice-category="공지">공지</button>
                <button type="button" data-abc-notice-category="이벤트">이벤트</button>
                <button type="button" data-abc-notice-category="서비스 안내">서비스 안내</button>
              </div>

              <div class="abc-cs-table-head abc-cs-notice-columns">
                <span>번호</span><span>제목</span><span>작성일</span>
              </div>
              <div class="abc-cs-notice-list" id="abcNoticeList">
                <button type="button" class="abc-cs-notice-row is-pinned" data-category="공지" data-title="개인정보처리방침 개정 안내" data-date="2026.08.04" data-body="서비스 이용에 적용되는 개인정보처리방침이 개정됩니다. 변경된 주요 내용을 확인해 주세요.">
                  <span class="abc-cs-notice-number">중요</span><strong>개인정보처리방침 개정 안내</strong><time>2026.08.04</time>
                </button>
                <button type="button" class="abc-cs-notice-row is-pinned" data-category="서비스 안내" data-title="택배 없는 날 배송 및 정산 일정 안내" data-date="2026.08.03" data-body="택배 없는 날 전후로 배송과 정산 일정이 일부 조정됩니다. 주문 전 예상 일정을 확인해 주세요.">
                  <span class="abc-cs-notice-number">중요</span><strong>택배 없는 날 배송 및 정산 일정 안내</strong><time>2026.08.03</time>
                </button>
                <button type="button" class="abc-cs-notice-row" data-category="이벤트" data-title="신규 회원 웰컴 쿠폰 이벤트" data-date="2026.07.29" data-body="신규 가입 회원을 위한 웰컴 쿠폰 이벤트가 진행됩니다. 발급 조건과 사용 기간을 확인해 주세요.">
                  <span class="abc-cs-notice-number">126</span><strong>[이벤트] 신규 회원 웰컴 쿠폰 안내</strong><time>2026.07.29</time>
                </button>
                <button type="button" class="abc-cs-notice-row" data-category="공지" data-title="상품 심의 접수 절차 안내" data-date="2026.07.28" data-body="상품 상태에 대한 확인이 필요한 경우 1:1 문의를 통해 심의를 신청할 수 있습니다. 주문번호와 관련 사진을 함께 등록해 주세요.">
                  <span class="abc-cs-notice-number">125</span><strong>상품 심의 접수 절차 안내</strong><time>2026.07.28</time>
                </button>
                <button type="button" class="abc-cs-notice-row" data-category="이벤트" data-title="여름 시즌 래플 당첨자 발표" data-date="2026.07.24" data-body="여름 시즌 래플 이벤트 당첨자를 발표합니다. 당첨 회원에게는 별도 안내가 발송됩니다.">
                  <span class="abc-cs-notice-number">124</span><strong>[이벤트 발표] 여름 시즌 래플 당첨자 안내</strong><time>2026.07.24</time>
                </button>
                <button type="button" class="abc-cs-notice-row" data-category="서비스 안내" data-title="고객센터 운영시간 변경 안내" data-date="2026.07.20" data-body="고객센터 운영시간이 평일 오전 9시부터 오후 6시까지로 변경됩니다.">
                  <span class="abc-cs-notice-number">123</span><strong>고객센터 운영시간 변경 안내</strong><time>2026.07.20</time>
                </button>
              </div>
              <div class="abc-cs-empty" id="abcNoticeEmpty" hidden><strong>검색 결과가 없습니다.</strong><p>다른 검색어 또는 분류를 선택해 보세요.</p></div>

              <article class="abc-cs-notice-detail" id="abcNoticeDetail" hidden>
                <button type="button" class="abc-cs-text-button" id="abcNoticeBack">목록으로</button>
                <div class="abc-cs-notice-detail-head">
                  <span id="abcNoticeDetailType">공지</span>
                  <h3 id="abcNoticeDetailTitle"></h3>
                  <time id="abcNoticeDetailDate"></time>
                </div>
                <div class="abc-cs-notice-detail-body">
                  <p id="abcNoticeDetailBody"></p>
                  <p>관련 문의는 고객센터 1:1 문의를 이용해 주세요.</p>
                </div>
              </article>
            </section>

            <!-- 1:1 문의 -->
            <section class="abc-cs-view" data-abc-view="inquiry" aria-labelledby="abcInquiryTitle" hidden>
              <header class="abc-cs-section-head">
                <div>
                  <h2 id="abcInquiryTitle">1:1 문의</h2>
                  <p>주문, 결제, 배송 등 해결되지 않은 문의를 남겨주세요.</p>
                </div>
              </header>

              <c:if test="${empty sessionScope.sessionInfo and param.testLogin ne '1'}">
                <div class="abc-cs-login-guide">
                  <div><strong>1:1 문의는 로그인 후 이용할 수 있습니다.</strong><p>로그인하면 문의 작성과 문의내역 조회를 이용할 수 있습니다.</p></div>
                  <a href="${ctx}/member/login">로그인</a>
                </div>
              </c:if>

              <c:if test="${not empty sessionScope.sessionInfo or param.testLogin eq '1'}">
              <div class="abc-cs-subtabs">
                <button type="button" class="is-active" data-abc-inquiry-tab="write">문의 작성</button>
                <button type="button" data-abc-inquiry-tab="history">문의내역 조회</button>
              </div>

              <form class="abc-cs-form" id="abcInquiryForm" data-abc-inquiry-panel="write">
                <div class="abc-cs-form-line">
                  <div class="abc-cs-form-label">문의 유형 <b>*</b></div>
                  <div class="abc-cs-choice-group" data-choice-group="inquiryType">
                    <input type="hidden" name="inquiryType" />
                    <button type="button" data-choice-value="주문/결제">주문/결제</button>
                    <button type="button" data-choice-value="배송">배송</button>
                    <button type="button" data-choice-value="교환/반품">교환/반품</button>
                    <button type="button" data-choice-value="상품정보">상품정보</button>
                    <button type="button" data-choice-value="회원정보">회원정보</button>
                    <button type="button" data-choice-value="기타">기타</button>
                  </div>
                </div>
                <div class="abc-cs-form-line">
                  <div class="abc-cs-form-label">상세 유형 <b>*</b></div>
                  <div class="abc-cs-choice-group" data-choice-group="inquiryDetail">
                    <input type="hidden" name="inquiryDetail" />
                    <button type="button" data-choice-value="취소/환불">취소/환불</button>
                    <button type="button" data-choice-value="배송 조회">배송 조회</button>
                    <button type="button" data-choice-value="상품 상태">상품 상태</button>
                    <button type="button" data-choice-value="기타">기타</button>
                  </div>
                </div>
                <label class="abc-cs-form-line">
                  <span class="abc-cs-form-label">제목 <b>*</b></span>
                  <input name="title" maxlength="50" required placeholder="제목을 50자 이내로 입력해 주세요." />
                </label>
                <label class="abc-cs-form-line abc-cs-form-line--textarea">
                  <span class="abc-cs-form-label">내용 <b>*</b></span>
                  <span class="abc-cs-textarea-wrap">
                    <textarea id="abcInquiryContent" name="content" maxlength="1000" required placeholder="문의 내용을 구체적으로 입력해 주세요."></textarea>
                    <small><span data-abc-count="abcInquiryContent">0</span>/1000</small>
                  </span>
                </label>
                <div class="abc-cs-form-line">
                  <div class="abc-cs-form-label">파일 첨부</div>
                  <div class="abc-cs-file-area">
                    <label class="abc-cs-file-button" for="abcInquiryFiles">파일 선택</label>
                    <input id="abcInquiryFiles" type="file" multiple accept=".jpg,.jpeg,.png,.gif,.bmp" />
                    <span>이미지 파일, 최대 3개까지 첨부할 수 있습니다.</span>
                    <div class="abc-cs-file-list" id="abcInquiryFileList"></div>
                  </div>
                </div>
                <div class="abc-cs-form-actions">
                  <button type="reset" class="abc-cs-btn abc-cs-btn--light"><span class="abc-cs-btn-label">취소</span></button>
                  <button type="submit" class="abc-cs-btn abc-cs-btn--dark"><span class="abc-cs-btn-label">문의 접수</span></button>
                </div>
              </form>

              <div class="abc-cs-history" data-abc-inquiry-panel="history" hidden>
                <div class="abc-cs-table-head abc-cs-history-columns"><span>문의유형</span><span>제목</span><span>접수일</span></div>
                <div id="abcInquiryHistoryList"></div>
                <div class="abc-cs-empty" id="abcInquiryHistoryEmpty"><strong>등록된 문의가 없습니다.</strong><p>문의 작성 탭에서 새로운 문의를 남겨보세요.</p></div>
              </div>
              </c:if>
            </section>

            <!-- 고객의 소리 -->
            <section class="abc-cs-view" data-abc-view="voice" aria-labelledby="abcVoiceTitle" hidden>
              <header class="abc-cs-section-head">
                <div>
                  <h2 id="abcVoiceTitle">고객의 소리</h2>
                  <p>서비스에 대한 칭찬, 불편사항과 개선 의견을 남겨주세요.</p>
                </div>
              </header>

              <c:if test="${empty sessionScope.sessionInfo and param.testLogin ne '1'}">
                <div class="abc-cs-login-guide">
                  <div><strong>고객의 소리는 로그인 후 작성할 수 있습니다.</strong><p>로그인 후 칭찬, 불편사항과 개선 의견을 접수해 주세요.</p></div>
                  <a href="${ctx}/member/login">로그인</a>
                </div>
              </c:if>

              <c:if test="${not empty sessionScope.sessionInfo or param.testLogin eq '1'}">
              <form class="abc-cs-form" id="abcVoiceForm">
                <div class="abc-cs-form-line">
                  <div class="abc-cs-form-label">의견 유형 <b>*</b></div>
                  <div class="abc-cs-choice-group" data-choice-group="voiceType">
                    <input type="hidden" name="voiceType" />
                    <button type="button" data-choice-value="칭찬">칭찬</button>
                    <button type="button" data-choice-value="불편사항">불편사항</button>
                    <button type="button" data-choice-value="개선 제안">개선 제안</button>
                    <button type="button" data-choice-value="기타">기타</button>
                  </div>
                </div>
                <div class="abc-cs-form-line">
                  <div class="abc-cs-form-label">상세 유형 <b>*</b></div>
                  <div class="abc-cs-choice-group" data-choice-group="voiceDetail">
                    <input type="hidden" name="voiceDetail" />
                    <button type="button" data-choice-value="온라인 서비스">온라인 서비스</button>
                    <button type="button" data-choice-value="오프라인 매장">오프라인 매장</button>
                    <button type="button" data-choice-value="상담 서비스">상담 서비스</button>
                    <button type="button" data-choice-value="기타">기타</button>
                  </div>
                </div>
                <label class="abc-cs-form-line">
                  <span class="abc-cs-form-label">방문일</span>
                  <input type="date" name="visitDate" />
                </label>
                <label class="abc-cs-form-line">
                  <span class="abc-cs-form-label">제목 <b>*</b></span>
                  <input name="voiceTitle" maxlength="50" required placeholder="제목을 50자 이내로 입력해 주세요." />
                </label>
                <label class="abc-cs-form-line abc-cs-form-line--textarea">
                  <span class="abc-cs-form-label">내용 <b>*</b></span>
                  <span class="abc-cs-textarea-wrap">
                    <textarea id="abcVoiceContent" name="voiceContent" maxlength="1000" required placeholder="의견 내용을 자세히 입력해 주세요."></textarea>
                    <small><span data-abc-count="abcVoiceContent">0</span>/1000</small>
                  </span>
                </label>
                <div class="abc-cs-form-actions">
                  <button type="reset" class="abc-cs-btn abc-cs-btn--light"><span class="abc-cs-btn-label">취소</span></button>
                  <button type="submit" class="abc-cs-btn abc-cs-btn--dark"><span class="abc-cs-btn-label">의견 접수</span></button>
                </div>
              </form>
              </c:if>
            </section>
          </div>
        </div>
      </div>
    </main>

    <div class="abc-cs-toast" id="abcCsToast" role="status" aria-live="polite"></div>

    

    <script src="${ctx}/dist/js/vendor/modernizr-3.5.0.min.js"></script>
    <script src="${ctx}/dist/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="${ctx}/dist/js/vendor/popper.min.js"></script>
    <script src="${ctx}/dist/js/vendor/bootstrap.min.js"></script>
    <script src="${ctx}/dist/js/vendor/owl.carousel.min.js"></script>
    <script src="${ctx}/dist/js/vendor/slick.min.js"></script>
    <script src="${ctx}/dist/js/vendor/wow.min.js"></script>
    <script src="${ctx}/dist/js/vendor/jquery.scrollUp.min.js"></script>
    <script src="${ctx}/dist/js/vendor/jquery.nice-select.min.js"></script>
    
    <script src="${ctx}/dist/js/vendor/jquery.magnific-popup.js"></script>
    <script src="${ctx}/dist/js/common/plugins.js"></script>
    <script src="${ctx}/dist/js/common/main.js"></script>
  
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    

    <script src="${pageContext.request.contextPath}/dist/js/pages/customer/contact.js?v=20260806-1340"></script>
    <script src="${pageContext.request.contextPath}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>
