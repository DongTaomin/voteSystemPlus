<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBHelper" %>

<%
    // 从 session 中获取用户信息
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);

    if (!isLoggedIn) {
        // 未登录的用户不能访问反馈页面，跳转到登录页面
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
    <title>反馈问题</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .content {
            margin: 50px auto;
            width: 60%;
            text-align: center;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #4a90e2;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
        }

        input[type="submit"]:hover {
            background-color: #357ab8;
        }
    </style>
</head>
<body>

<div class="content">
    <h2>反馈问题</h2>

    <form action="submit.jsp" method="post">
        <input type="hidden" name="username" value="<%= user.getName() %>">
        <textarea name="issueDescription" rows="6" placeholder="请输入您的问题描述..." required></textarea>
        <br>
        <input type="submit" value="提交反馈">
    </form>

    <p><a href="main.jsp">返回首页</a></p>
</div>

</body>
</html>


