<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>删除大学信息</title>
</head>
<body>
<%
    // 获取大学ID
    String id = request.getParameter("id");
    if (id == null) {
        out.println("<script>alert('大学ID不能为空'); window.location.href='editUni.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedb", "root", "dtm20031126");

        // 更新投过该大学票的用户的状态，将has_voted字段设置为0
        String updateUsersSql = "UPDATE users SET has_voted = 0 WHERE id IN (SELECT user_id FROM votes WHERE university_id = ?)";
        PreparedStatement updateUsersStmt = conn.prepareStatement(updateUsersSql);
        updateUsersStmt.setInt(1, Integer.parseInt(id));
        updateUsersStmt.executeUpdate();

        // 删除相关的投票记录
        String deleteVotesSql = "DELETE FROM votes WHERE university_id = ?";
        PreparedStatement deleteVotesStmt = conn.prepareStatement(deleteVotesSql);
        deleteVotesStmt.setInt(1, Integer.parseInt(id));
        deleteVotesStmt.executeUpdate();



        // 删除大学信息
        String deleteUniversitySql = "DELETE FROM universities WHERE id = ?";
        stmt = conn.prepareStatement(deleteUniversitySql);
        stmt.setInt(1, Integer.parseInt(id));

        int result = stmt.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('删除成功'); window.location.href='editUni.jsp';</script>");
        } else {
            out.println("<script>alert('删除失败'); window.location.href='editUni.jsp';</script>");
        }

    } catch (Exception e) {
        out.println("<script>alert('数据库连接失败'); window.location.href='editUni.jsp';</script>");
        e.printStackTrace();
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>
