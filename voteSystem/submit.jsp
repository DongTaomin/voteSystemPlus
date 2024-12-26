<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2024/12/26
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.IssueDAO" %>
<%@ page import="java.sql.Timestamp" %>
<%
    // 从 session 中获取用户信息
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);  // 判断用户是否已登录
%>

<html>
<head>
    <title>问题反馈</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .login-status {
            background-color: #4a90e2;
            color: white;
            padding: 10px;
            text-align: right;
        }

        .content {
            text-align: center;
            margin-top: 50px;
        }

        .feedback-form {
            width: 50%;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .feedback-form textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            margin-top: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .feedback-form input[type="submit"] {
            background-color: #4a90e2;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            margin-top: 20px;
        }

        .feedback-form input[type="submit"]:hover {
            background-color: #357ab8;
        }

        .error-message {
            color: red;
            font-size: 14px;
        }
        a {
            text-decoration: none;
        }
    </style>
</head>
<body>

<!-- 显示登录状态 -->
<%
    if (isLoggedIn) {
%>
<div class="login-status">
    你好, <%= user.getName() %> | <a href="logout.jsp">退出</a>
</div>
<%
} else {
%>
<div class="login-status">
    未登录 | <a href="login.jsp">用户登录</a> | <a href="register.jsp">注册</a>
</div>
<%
    }
%>
<div class="a"><a href="main.jsp" class="back-home-button">返回首页</a></div>

<!-- 页面内容 -->
<div class="content">
    <h2>问题反馈</h2>

    <%-- 如果用户未登录，则提示登录 --%>
    <%
        if (!isLoggedIn) {
    %>
    <p class="error-message">请登录后提交问题反馈！</p>
    <a href="login.jsp">登录</a>
    <% } else { %>

    <!-- 反馈表单 -->
    <div class="feedback-form">
        <form action="submit.jsp" method="post">
            <label for="description">问题描述：</label>
            <textarea id="description" name="description" placeholder="请描述您遇到的问题" required></textarea>

            <input type="submit" value="提交反馈">
        </form>
    </div>

    <% } %>
</div>

<%
    request.setCharacterEncoding("utf-8");
    // 如果是 POST 请求，处理反馈提交
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // 获取用户提交的反馈内容
        String description = request.getParameter("description");

        // 如果描述不为空，则插入数据库
        if (description != null && !description.trim().isEmpty()) {
            try {
                // 插入问题反馈到数据库
                boolean success = IssueDAO.submitFeedback(user.getId(), description);

                if (success) {
                    out.println("<p>您的问题已提交，感谢您的反馈！</p>");
                } else {
                    out.println("<p class='error-message'>提交失败，请稍后再试。</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p class='error-message'>出现错误，请稍后再试。</p>");
            }
        } else {
            out.println("<p class='error-message'>问题描述不能为空！</p>");
        }
    }
%>


</body>
</html>
