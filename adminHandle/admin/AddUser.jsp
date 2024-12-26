<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>添加用户</title>
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
        input[type="text"] {
            width: 80%;
            padding: 10px;
            margin-bottom: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        select {
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
            alert("用户添加成功！");
        }
    </script>
</head>
<body>
<div class="container">
    <h1>添加用户</h1>
    <form method="post" action="" onsubmit="showSuccessMessage()">
        <input type="text" name="userName" placeholder="用户名" required /><br/>
        <select name="userGender" required>
            <option value="">选择性别</option>
            <option value="男">男</option>
            <option value="女">女</option>
        </select><br/>
        <button type="submit">添加用户</button>
    </form>

    <%
        request.setCharacterEncoding("utf-8");
        // 处理表单提交
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String userName = request.getParameter("userName");
            String userGender = request.getParameter("userGender");
            String defaultPassword = "123456";  // 默认密码

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                // 加载数据库驱动
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedb", "root", "dtm20031126");

                // 插入用户信息到数据库
                String sql = "INSERT INTO users (name, sex, password, has_voted) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, userName);
                stmt.setString(2, userGender);
                stmt.setString(3, defaultPassword);  // 使用默认密码
                stmt.setBoolean(4, false);  // 默认未投票

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    // 插入成功后，显示添加成功的消息
    %>
    <div class="success-message">用户添加成功！</div>
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
