<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2024/12/26
  Time: 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>删除用户</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String url = "jdbc:mysql://localhost:3306/votedb";
    String dbUser = "root";
    String dbPassword = "dtm20031126";
    int userId = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // 删除 votes 表中的相关记录
        String deleteVotesSql = "DELETE FROM votes WHERE user_id = ?";
        stmt = conn.prepareStatement(deleteVotesSql);
        stmt.setInt(1, userId);
        stmt.executeUpdate();

        // 删除 users 表中的记录
        String deleteUserSql = "DELETE FROM users WHERE id = ?";
        stmt = conn.prepareStatement(deleteUserSql);
        stmt.setInt(1, userId);
        stmt.executeUpdate();

        out.print("<script>alert('用户删除成功！');window.location.href='editUs.jsp';</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("<script>alert('删除失败：" + e.getMessage() + "');window.history.back();</script>");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
</body>
</html>
