<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>修改大学信息</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    // 获取提交的表单数据
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    String imageUrl = request.getParameter("imageUrl");

    if (id == null || name == null || description == null || imageUrl == null) {
        out.println("<script>alert('信息不完整，修改失败'); window.location.href='editUniversity.jsp?id=" + id + "';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedb", "root", "dtm20031126");

        // 更新大学信息
        String sql = "UPDATE universities SET name = ?, description = ?, image_url = ? WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, description);
        stmt.setString(3, imageUrl);
        stmt.setInt(4, Integer.parseInt(id));

        int result = stmt.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('修改成功'); window.location.href='ListUniversity.jsp';</script>");
        } else {
            out.println("<script>alert('修改失败'); window.location.href='editUniversity.jsp?id=" + id + "';</script>");
        }

    } catch (Exception e) {
        out.println("<script>alert('数据库连接失败'); window.location.href='editUniversity.jsp?id=" + id + "';</script>");
        e.printStackTrace();
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>
