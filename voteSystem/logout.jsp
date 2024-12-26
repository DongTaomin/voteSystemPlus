<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2024/11/29
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate(); // 清除 session 中的所有数据
    response.sendRedirect("main.jsp"); // 退出后重定向到主页
%>

