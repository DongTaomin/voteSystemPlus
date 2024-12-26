<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>添加大学</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 30px auto;
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
        form {
            text-align: center;
            margin-bottom: 20px;
        }
        input[type="text"], textarea {
            width: 80%;
            padding: 10px;
            margin-bottom: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
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
        .success-message {
            background-color: #28a745;
            color: white;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
            margin-top: 20px;
        }
    </style>
    <script>
        // 弹出提示框
        function showSuccessMessage() {
            alert("大学添加成功！");
        }
    </script>
</head>
<body>
<div class="container">
    <h1>添加大学信息</h1>
    <form method="post" action="" onsubmit="showSuccessMessage()">
        <input type="text" name="universityName" placeholder="大学名称" required /><br/>
        <textarea name="universityDescription" rows="4" placeholder="大学描述" required></textarea><br/>
        <input type="text" name="universityImageUrl" placeholder="图片 URL" required /><br/>
        <button type="submit">添加大学</button>
    </form>

    <%
        request.setCharacterEncoding("utf-8");
        // 处理表单提交
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String universityName = request.getParameter("universityName");
            String universityDescription = request.getParameter("universityDescription");
            String universityImageUrl = request.getParameter("universityImageUrl");

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                // 加载数据库驱动
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedb", "root", "dtm20031126");

                // 插入大学信息到数据库
                String sql = "INSERT INTO universities (name, description, image_url) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, universityName);
                stmt.setString(2, universityDescription);
                stmt.setString(3, universityImageUrl);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    // 插入成功后，显示添加成功的消息
    %>
    <div class="success-message">大学信息添加成功！</div>
    <%
        }
    } catch (Exception e) {
    %>
    <div class="success-message" style="background-color: #dc3545;">添加失败：<%= e.getMessage() %></div>
    <%
                e.printStackTrace();
            } finally {
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
</div>
</body>
</html>
