<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  try {
    if (session != null) {
      session.invalidate();
    }
  } catch (IllegalStateException ignored) {
    // 이미 종료된 세션이면 그대로 메인으로 이동합니다.
  }
  response.sendRedirect(request.getContextPath() + "/index.jsp?logout=1");
%>
