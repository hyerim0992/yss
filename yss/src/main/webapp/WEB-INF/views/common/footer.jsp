<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- 원래 index.jsp의 푸터 UI를 그대로 공통화 -->
<footer class="custom-footer">
  <div class="footer-top-line">
    <div class="container">
      <div class="footer-top-inner">
        <div class="footer-top-left">
          <strong class="cs-title">통합고객센터</strong>
          <span class="cs-phone">1111-2222</span>
          <span class="cs-time">월~금 09:00 ~ 12:00 / 13:00 ~ 18:00 (주말·공휴일 휴무)</span>
          <button type="button" class="chat-btn" onclick="location.href='${ctx}/customer/contact'">챗봇 상담</button>
        </div>

        <div class="footer-top-right">
          <span class="footer-notice">NOTICE</span>
          <span class="footer-divider"></span>
          <span class="footer-notice-link">YONGSINSA 소비자 분쟁 안내</span>
          <span class="footer-plus">+</span>
          <span class="family-site">FAMILY SITE</span>
        </div>
      </div>
    </div>
  </div>

  <div class="footer-main">
    <div class="container">
      <div class="row footer-main-row">
        <div class="col-xl-7 col-lg-7 col-md-12">
          <div class="footer-company">
            <div class="footer-brand">
              <a href="${ctx}/index.jsp" aria-label="YONGSINSA 메인으로 이동">
                <img src="${ctx}/dist/images/logo/logo.png" alt="YONGSINSA">
              </a>
            </div>

            <div class="footer-company-info">
              <p>
                대표이사: 김자바
                <span class="info-bar">|</span>
                사업자등록번호: 111-22-333333
                <span class="info-bar">|</span>
                이메일:
                <a href="mailto:yongsinsa@yongsinsa.com">yongsinsa@yongsinsa.com</a>
              </p>
              <p>사업장 소재지: 인천광역시 서구 청라비즈니스로 157, 용신사타워 5층</p>
              <p>통합고객센터: 1111-2222</p>
            </div>

            <div class="footer-policy">
              <span>사업자정보확인</span>
              <span class="info-bar">|</span>
              <span><strong>개인정보처리방침</strong></span>
              <span class="info-bar">|</span>
              <span>이용약관</span>
              <span class="info-bar">|</span>
              <span>회원서비스 이용약관</span>
              <span class="info-bar">|</span>
              <span><strong>위치 정보 서비스 이용약관</strong></span>
              <span class="info-bar">|</span>
              <span>구매안전서비스 가입사실확인</span>
            </div>
          </div>
        </div>

        <div class="col-xl-5 col-lg-5 col-md-12">
          <div class="footer-side-wrap">
            <div class="footer-menu-box">
              <h4>HELP</h4>
              <ul>
                <li><a href="${ctx}/customer/contact">고객센터</a></li>
                <li><a href="${ctx}/mypage#inquiry">1:1 문의</a></li>
                <li><a href="${ctx}/mypage#shipping">배송 조회</a></li>
                <li><a href="${ctx}/mypage#purchase">취소/교환/반품</a></li>
                <li><a href="${ctx}/mypage#guide">이용 안내</a></li>
              </ul>
            </div>

            <div class="footer-menu-box">
              <h4>BRAND</h4>
              <ul>
                <li>NIKE</li>
                <li>ADIDAS</li>
                <li>NEW BALANCE</li>
                <li>CONVERSE</li>
                <li>PUMA</li>
              </ul>
            </div>

            <div class="footer-menu-box social-box">
              <h4>SOCIAL</h4>
              <div class="social-icons">
                <span class="social-icon"><i class="fab fa-facebook-f"></i></span>
                <span class="social-icon social-blog">blog</span>
                <span class="social-icon"><i class="fab fa-youtube"></i></span>
                <span class="social-icon"><i class="fab fa-instagram"></i></span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="footer-bottom">
        <p>Copyright &copy; <span data-current-year></span> YONGSINSA. All rights reserved.</p>
      </div>
    </div>
  </div>
</footer>
