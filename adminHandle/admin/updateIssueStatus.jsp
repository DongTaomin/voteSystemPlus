<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2024/12/26
  Time: 11:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>更新问题状态</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:mysql://localhost:3306/votedb";
    String dbUser = "root";
    String dbPassword = "dtm20031126";

    int issueId = Integer.parseInt(request.getParameter("id"));
    String newStatus = request.getParameter("status");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // 更新问题状态
        String updateSql = "UPDATE issue SET status = ? WHERE id = ?";
        stmt = conn.prepareStatement(updateSql);
        stmt.setString(1, newStatus);
        stmt.setInt(2, issueId);
        stmt.executeUpdate();

        out.print("<script>alert('问题状态更新成功！'); window.location.href='handleIssue.jsp';</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("<script>alert('更新失败：" + e.getMessage() + "'); window.location.href='handleIssue.jsp';</script>");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
</body>
</html>

