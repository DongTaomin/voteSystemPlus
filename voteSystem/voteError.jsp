<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2024/11/29
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>投票错误</title>
    <style>
        /* 页面整体样式 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: #721c24;
        }

        /* 错误消息容器 */
        .error-container {
            background-color: #f5c6cb;
            padding: 20px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 300px;
        }

        /* 标题样式 */
        h3 {
            margin: 0 0 15px 0;
            font-size: 20px;
        }

        /* 按钮样式 */
        .home-link {
            display: inline-block;
            background-color: #721c24;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
        }

        /* 按钮悬停效果 */
        .home-link:hover {
            background-color: #a94442;
        }
    </style>
</head>
<body>

<div class="error-container">
    <h3>您已经投过票了！</h3>
    <a class="home-link" href="main.jsp">返回首页</a>
</div>

</body>
</html>

