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
  <title>1:1 문의 상세보기 | Yongsinsa</title>
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
                  <h2 id="abcInquiryTitle">1:1 문의 상세보기</h2>
                  <p>등록하신 문의 내역을 확인하실 수 있습니다.</p>
                </div>
              </header>

              <!-- 게시글 상세 내용 영역 -->
              <div class="body-main my-3">
                <table class="table board-article" style="width: 100%; border-collapse: collapse; margin-bottom: 20px;">
                  <thead>
                    <tr style="border-top: 2px solid #333; border-bottom: 1px solid #ddd; background-color: #f9f9f9;">
                      <td colspan="2" align="left" style="padding: 15px; font-weight: bold; font-size: 16px;">
                        [${dto.inquiryType}] <c:out value="${dto.title}"/>
                      </td>
                    </tr>
                  </thead>
                  <tbody>
                    <tr style="border-bottom: 1px solid #eee; color: #666; font-size: 14px;">
                      <td width="50%" style="padding: 10px 15px;">
                        작성일 : ${dto.createdAt}
                      </td>
                      <td align="right" style="padding: 10px 15px;">
                        처리 상태 : <strong>${dto.status}</strong>
                      </td>
                    </tr>
                    <tr style="border-bottom: 1px solid #ddd;">
                      <td colspan="2" valign="top" style="padding: 20px 15px; min-height: 200px; line-height: 1.6;">
                        ${dto.content}
                      </td>
                    </tr>

                    <!-- 이전글 영역 -->
                    <tr style="border-bottom: 1px solid #eee;">
                      <td colspan="2" style="padding: 10px 15px; font-size: 14px;">
                        <strong>이전글 : </strong>
                        <c:choose>
                          <c:when test="${not empty prevDto}">
                            <a href="${ctx}/customer/inquiry/article?${query}&inquiryId=${prevDto.inquiryId}" style="color: inherit; text-decoration: none;">
                              <c:out value="${prevDto.title}"/>
                            </a>
                          </c:when>
                          <c:otherwise>
                            <span style="color: #999;">이전글이 없습니다.</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                    </tr>

                    <!-- 다음글 영역 -->
                    <tr style="border-bottom: 1px solid #ddd;">
                      <td colspan="2" style="padding: 10px 15px; font-size: 14px;">
                        <strong>다음글 : </strong>
                        <c:choose>
                          <c:when test="${not empty nextDto}">
                            <a href="${ctx}/customer/inquiry/article?${query}&inquiryId=${nextDto.inquiryId}" style="color: inherit; text-decoration: none;">
                              <c:out value="${nextDto.title}"/>
                            </a>
                          </c:when>
                          <c:otherwise>
                            <span style="color: #999;">다음글이 없습니다.</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                    </tr>
                  </tbody>
                </table>

				<!-- 하단 버튼 영역 -->
                <table class="table table-borderless my-3">
                  <tr>
                    <td width="50%">
                      <c:choose>
                        <c:when test="${sessionScope.member.memberId == dto.memberId}">
                          <button type="button" class="btn btn-dark" style="color: #ffffff !important;"
                                  onclick="location.href='${ctx}/customer/inquiry/update?inquiryId=${dto.inquiryId}&page=${page}';">수정</button>
                        </c:when>
                        <c:otherwise>
                          <button type="button" class="btn btn-secondary" disabled style="color: #ffffff !important;">수정</button>
                        </c:otherwise>
                      </c:choose>

                      <c:choose>
                        <c:when test="${sessionScope.member.memberId == dto.memberId || sessionScope.member.role >= 51}">
                          <button type="button" class="btn btn-dark" style="color: #ffffff !important;"
                                  onclick="deleteOk();">삭제</button>
                        </c:when>
                        <c:otherwise>
                          <button type="button" class="btn btn-secondary" disabled style="color: #ffffff !important;">삭제</button>
                        </c:otherwise>
                      </c:choose>
                    </td>

                    <td class="text-end" align="right">
                      <button type="button" class="btn btn-dark" style="color: #ffffff !important;"
                              onclick="location.href='${ctx}/customer/inquiry/list?${query}';">리스트</button>
                    </td>
                  </tr>
                </table>

              </div>
            </section>
          </div>
        </div>
      </div>
    </main>

  <c:if test="${sessionScope.member.memberId == dto.memberId || sessionScope.member.role >= 51}">
    <script type="text/javascript">
      function deleteOk() {
        if(confirm('게시글을 삭제하시겠습니까?')) {
          let params = 'inquiryId=${dto.inquiryId}&${query}';
          let url = '${ctx}/customer/inquiry/delete?' + params;
          location.href = url;
        }
      }
    </script>
  </c:if>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
  <div class="abc-cs-toast" id="abcCsToast" role="status" aria-live="polite"></div>

  <script src="${ctx}/dist/js/vendor/modernizr-3.5.0.min.js"></script>
  <script src="https://code.jquery.com/jquery-4.0.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
  <script src="${ctx}/dist/js/common/plugins.js"></script>
  <script src="${ctx}/dist/js/common/layout.js?v=20260806-0056"></script>
</body>
</html>