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
  <title>1:1 문의 | Yongsinsa</title>
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
              <a href="${ctx}/customer/inquiry/list" class="is-active">1:1 문의</a>
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
            <section class="abc-cs-view is-active" aria-labelledby="abcInquiryTitle">
              <header class="abc-cs-section-head">
                <div>
                  <h2 id="abcInquiryTitle">1:1 문의 ${mode=='update'?'수정':'작성'}</h2>
                  <p>주문, 결제, 배송 등 해결되지 않은 문의를 남겨주세요.</p>
                </div>
              </header>

              <div class="abc-cs-subtabs">
                <button type="button" data-abc-inquiry-tab="history" onclick="changeInquiry()">문의내역 조회</button>
                <button type="button" class="is-active" data-abc-inquiry-tab="write">문의 ${mode=='update'?'수정':'작성'}</button>
              </div>

              <form name="inquiryForm" method="post" class="abc-cs-form" id="abcInquiryForm" data-abc-inquiry-panel="write">
                <div class="abc-cs-form-line">
                  <div class="abc-cs-form-label">문의 유형 <b>*</b></div>
                  <div class="abc-cs-choice-group" data-choice-group="inquiryType">
                    <!-- 수정 모드일 때 기존 문의유형 바인딩 -->
                    <input type="hidden" name="inquiryType" value="${dto.inquiryType}" />
                    <button type="button" class="${dto.inquiryType=='주문/결제'?'is-active':''}" data-choice-value="주문/결제">주문/결제</button>
                    <button type="button" class="${dto.inquiryType=='배송'?'is-active':''}" data-choice-value="배송">배송</button>
                    <button type="button" class="${dto.inquiryType=='교환/반품'?'is-active':''}" data-choice-value="교환/반품">교환/반품</button>
                    <button type="button" class="${dto.inquiryType=='상품정보'?'is-active':''}" data-choice-value="상품정보">상품정보</button>
                    <button type="button" class="${dto.inquiryType=='회원정보'?'is-active':''}" data-choice-value="회원정보">회원정보</button>
                    <button type="button" class="${dto.inquiryType=='기타'?'is-active':''}" data-choice-value="기타">기타</button>
                  </div>
                </div>

                <label class="abc-cs-form-line">
                  <span class="abc-cs-form-label">제목 <b>*</b></span>
                  <input name="title" maxlength="50" required placeholder="제목을 50자 이내로 입력해 주세요." value="${dto.title}" />
                </label>

                <label class="abc-cs-form-line abc-cs-form-line--textarea">
                  <span class="abc-cs-form-label">내용 <b>*</b></span>
                  <span class="abc-cs-textarea-wrap">
                    <textarea id="abcInquiryContent" name="content" maxlength="1000" required placeholder="문의 내용을 구체적으로 입력해 주세요.">${dto.content}</textarea>
                    <small><span data-abc-count="abcInquiryContent">0</span>/1000</small>
                  </span>
                </label>

                <div class="abc-cs-form-line">
                  <div class="abc-cs-form-label">파일 첨부</div>
                  <div class="abc-cs-file-area">
                    <label class="abc-cs-file-button" for="abcInquiryFiles">파일 선택</label>
                    <input id="abcInquiryFiles" type="file" multiple accept=".jpg,.jpeg,.png,.gif,.bmp" />
                    <span>이미지 파일, 최대 3개까지 첨부할 수 있습니다.</span>
                    <div class="abc-cs-file-list"><span id="abcInquiryFileNames">선택된 파일 없음</span></div>
                  </div>
                </div>

                <div class="abc-cs-form-actions">
                  <button type="button" class="abc-cs-btn abc-cs-btn--light" onclick="location.href='${ctx}/customer/inquiry/list';">
                    <span class="abc-cs-btn-label">${mode=='update'?'수정 취소':'등록 취소'}</span>
                  </button>
                  <button type="button" class="abc-cs-btn abc-cs-btn--dark" onclick="sendOk()">
                    <span class="abc-cs-btn-label">${mode=='update'?'수정 완료':'문의 접수'}</span>
                  </button>

                  <!-- 수정 모드 hidden 파라미터 -->
                  <c:if test="${mode=='update'}">
                    <input type="hidden" name="inquiryId" value="${dto.inquiryId}">
                    <input type="hidden" name="page" value="${page}">
                  </c:if>
                </div>
              </form>

              <template id="abcInquiryHistoryTemplate">
                <div class="abc-cs-history-row">
                  <span data-history-type></span>
                  <strong data-history-title></strong>
                  <time data-history-date></time>
                </div>
              </template>
            </section>
          </div>
        </div>
      </div>
    </main>
    
    <script type="text/javascript">
    function changeInquiry() {
    	location.href = '${pageContext.request.contextPath}/customer/inquiry/list';
    }
    
    function sendOk() {
    	const f = document.inquiryForm;
    	
    	if(! f.inquiryType.value) {
    		alert('문의 유형을 선택하세요.');
    		return;
    	}

      let str = f.title.value.trim();
      if(!str) {
        alert('제목을 입력하세요.');
        f.title.focus();
        return;
      }

      str = f.content.value.trim();
      if(!str) {
        alert('내용을 입력하세요.');
        f.content.focus();
        return;
      }
    	
    	// mode로 변경
    	f.action = '${pageContext.request.contextPath}/customer/inquiry/${mode}';
    	f.submit();
    }
    </script>

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

  <script src="${ctx}/dist/js/pages/customer/inquiry.js?v=20260812-jsp"></script>
  <script src="${ctx}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>