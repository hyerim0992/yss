<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>로그인 | 용신사</title>
  <link rel="shortcut icon" type="image/x-icon" href="${ctx}/dist/images/favicon.ico" />

  <jsp:include page="/WEB-INF/views/common/head-styles.jsp" />
  <link rel="stylesheet" href="${ctx}/dist/css/pages/member/login.css?v=20260806-1420" />
  <link rel="stylesheet" href="${ctx}/dist/css/common/layout.css?v=20260806-0205" />
</head>
<body class="has-site-layout ys-login-body">
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main class="ys-login-page">
    <section class="ys-login-title" aria-labelledby="loginPageTitle">
      <h2 id="loginPageTitle">로그인</h2>
      <p>용신사 회원 서비스와 주문 정보를 안전하게 확인하세요.</p>
    </section>

    <section class="ys-login-section">
      <div class="ys-login-container">
        <div class="ys-login-wrap">
          <article class="ys-login-box">
            <div class="ys-login-heading">
              <span class="ys-login-eyebrow">MEMBER LOGIN</span>
              <h3>회원 로그인</h3>
              <p>아이디와 비밀번호를 입력하면 마이페이지로 이동합니다.</p>
            </div>

            <form
              id="memberLoginForm"
              action="${ctx}/member/login"
              method="post"
              data-member-login-form
              novalidate
            >
              <div class="ys-form-group">
                <label for="loginUserId">아이디</label>
                <input
                  type="text"
                  id="loginUserId"
                  name="userId"
                  autocomplete="username"
                  placeholder="아이디를 입력해 주세요"
                  required
                />
              </div>

              <div class="ys-form-group">
                <label for="loginPassword">비밀번호</label>
                <input
                  type="password"
                  id="loginPassword"
                  name="password"
                  autocomplete="current-password"
                  placeholder="비밀번호를 입력해 주세요"
                  required
                />
              </div>

              <div class="ys-login-option">
                <label class="ys-check" for="rememberUserId">
                  <input type="checkbox" id="rememberUserId" name="rememberUserId" />
                  <span>아이디 저장</span>
                </label>

                <div class="ys-find-links" aria-label="계정 찾기">
                  <a href="#" data-no-page-loader data-demo-message="아이디 찾기 기능은 Controller 연결 단계에서 구현합니다.">아이디 찾기</a>
                  <span aria-hidden="true"></span>
                  <a href="#" data-no-page-loader data-demo-message="비밀번호 찾기 기능은 Controller 연결 단계에서 구현합니다.">비밀번호 찾기</a>
                </div>
              </div>

              <button type="submit" class="ys-login-btn">로그인</button>
              <p class="ys-login-status" data-login-status aria-live="polite"></p>
            </form>

            <div class="ys-join-area">
              <p>아직 용신사 회원이 아니신가요?</p>
              <a href="${ctx}/member/join" class="ys-join-btn">회원가입</a>
            </div>
          </article>

          <article class="ys-guest-box" id="guest-order">
            <div class="ys-login-heading">
              <span class="ys-login-eyebrow">GUEST ORDER</span>
              <h3>비회원 주문조회</h3>
              <p>결제 완료 화면에서 받은 주문번호와 주문 비밀번호를 입력해 주세요.</p>
            </div>

            <form action="#guest-order" method="post" data-guest-order-form novalidate>
              <div class="ys-form-group">
                <label for="guestOrderNumber">주문번호</label>
                <input
                  type="text"
                  id="guestOrderNumber"
                  name="guestOrderNumber"
                  inputmode="numeric"
                  maxlength="8"
                  pattern="[0-9]{8}"
                  placeholder="주문번호 8자리"
                  required
                />
              </div>

              <div class="ys-form-group">
                <label for="guestOrderPassword">주문 비밀번호</label>
                <input
                  type="password"
                  id="guestOrderPassword"
                  name="guestOrderPassword"
                  minlength="6"
                  placeholder="주문 비밀번호 6자 이상"
                  required
                />
              </div>

              <button type="submit" class="ys-guest-btn">주문조회</button>
              <p class="ys-login-status" data-guest-status aria-live="polite"></p>
            </form>

            <div class="ys-guest-guide">
              <p><i class="fas fa-info-circle" aria-hidden="true"></i> 주문번호는 결제 완료 화면에서 확인할 수 있습니다.</p>
              <p><i class="fas fa-lock" aria-hidden="true"></i> 주문할 때 설정한 비밀번호를 입력해 주세요.</p>
            </div>
          </article>
        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />

  <script src="${ctx}/dist/js/vendor/modernizr-3.5.0.min.js"></script>
  <script src="https://code.jquery.com/jquery-4.0.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
  <script src="${ctx}/dist/js/vendor/owl.carousel.min.js"></script>
  <script src="${ctx}/dist/js/vendor/slick.min.js"></script>
  <script src="${ctx}/dist/js/vendor/wow.min.js"></script>
  <script src="${ctx}/dist/js/vendor/jquery.scrollUp.min.js"></script>
  <script src="${ctx}/dist/js/vendor/jquery.nice-select.min.js"></script>
  <script src="${ctx}/dist/js/vendor/jquery.magnific-popup.js"></script>
  <script src="${ctx}/dist/js/vendor/jquery.ajaxchimp.min.js"></script>
  <script src="${ctx}/dist/js/common/plugins.js"></script>
  <script src="${ctx}/dist/js/common/main.js"></script>
  <script src="${ctx}/dist/js/common/layout.js?v=20260806-0200"></script>
  <script src="${ctx}/dist/js/pages/member/login.js?v=20260806-1420"></script>
  
  <c:if test="${not empty message}">
  <script>
    alert("${message}");
  </script>
</c:if>

</body>
</html>
