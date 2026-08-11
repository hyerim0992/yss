<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<aside class="admin-sidebar">
  <nav id="adminNav">
    <a class="nav-item ${requestScope.adminPage eq 'dashboard' ? 'active' : ''}"
       href="<c:url value='/admin' />">
      <span>⌂</span>대시보드
    </a>

    <p>SHOP</p>

    <a class="nav-item ${requestScope.adminPage eq 'member' ? 'active' : ''}"
       href="<c:url value='/admin/member' />">
      <span>♙</span>회원관리
    </a>

    <a class="nav-item ${requestScope.adminPage eq 'product' ? 'active' : ''}"
       href="<c:url value='/admin/product' />">
      <span>□</span>상품관리
    </a>

    <a class="nav-item ${requestScope.adminPage eq 'logistics' ? 'active' : ''}"
       href="<c:url value='/admin/logistics' />">
      <span>▣</span>물류관리 <b>12</b>
    </a>

    <p>SERVICE</p>

    <a class="nav-item ${requestScope.adminPage eq 'support' ? 'active' : ''}"
       href="<c:url value='/admin/support' />">
      <span>?</span>고객지원 <b>5</b>
    </a>

    <a class="nav-item ${requestScope.adminPage eq 'status' ? 'active' : ''}"
       href="<c:url value='/admin/status' />">
      <span>↗</span>통계현황
    </a>
  </nav>
</aside>
