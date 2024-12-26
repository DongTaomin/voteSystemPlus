<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>编辑大学信息</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        input[type="text"], input[type="url"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            height: 150px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>编辑大学信息</h1>
    <%
        request.setCharacterEncoding("utf-8");
        // 获取大学ID
        String id = request.getParameter("id");
        if (id == null) {
            out.println("<script>alert('大学ID不能为空'); window.location.href='editUni.jsp';</script>");
            return;
        }

        String universityName = "";
        String description = "";
        String imageUrl = "";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedb", "root", "dtm20031126");

            // 获取大学信息
            String sql = "SELECT name, description, image_url FROM universities WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(id));
            rs = stmt.executeQuery();
            if (rs.next()) {
                universityName = rs.getString("name");
                description = rs.getString("description");
                imageUrl = rs.getString("image_url");
            }
        } catch (Exception e) {
            out.println("<script>alert('数据库连接失败');</script>");
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <form method="post" action="editUniversityAction.jsp">
        <input type="hidden" name="id" value="<%= id %>">
        <label for="name">大学名称:</label>
        <input type="text" id="name" name="name" value="<%= universityName %>" required>

        <label for="description">大学描述:</label>
        <textarea id="description" name="description" required><%= description %></textarea>

        <label for="imageUrl">大学图片 URL:</label>
        <input type="url" id="imageUrl" name="imageUrl" value="<%= imageUrl %>" required>

        <button type="submit">保存修改</button>
    </form>
</div>
</body>
</html>
