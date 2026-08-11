<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="adminPage" value="member" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원관리 | Yongsinsa 관리자</title>
  <script>
    document.documentElement.classList.add("ys-page-loading");
    window.__ysPageLoaderStart = Date.now();
  </script>
  <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/list.css?v=20260810">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/modal.css?v=20260810">
</head>
<body data-context-path="${pageContext.request.contextPath}">
  <jsp:include page="/WEB-INF/views/common/page-loader.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

  <main class="admin-main">
    <jsp:include page="/WEB-INF/views/admin/layout/listContent.jsp"/>
  </main>

  <jsp:include page="/WEB-INF/views/admin/layout/modal.jsp"/>
  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
  <script src="${pageContext.request.contextPath}/dist/js/admin/data/member.js?v=20260810"></script>
  <script src="${pageContext.request.contextPath}/dist/js/admin/list.js?v=20260810"></script>
</body>
</html>
