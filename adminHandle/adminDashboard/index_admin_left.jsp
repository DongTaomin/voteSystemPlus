<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2024/10/24
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员菜单页面</title>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .nav-link {
            display: block;
            padding: 10px 15px;
            margin: 5px 0;
            background-color: #007bff;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
        }
        .nav-link:hover {
            background-color: #0056b3;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<br><br><br>
<p><a href="../admin/ListUniversity.jsp" target="right" class="nav-link">全部大学</a></p>
<p><a href="../admin/ListUser.jsp" target="right" class="nav-link">全部用户</a></p>
<p><a href="../admin/FindUniversity.jsp" target="right" class="nav-link">查询大学</a></p>
<p><a href="../admin/FindUser.jsp" target="right" class="nav-link">查询用户</a></p>
<p><a href="../admin/AddUniversity.jsp" target="right" class="nav-link">添加大学</a></p>
<p><a href="../admin/AddUser.jsp" target="right" class="nav-link">添加用户</a></p>
<p><a href="../admin/editUni.jsp" target="right" class="nav-link">编辑大学</a></p>
<p><a href="../admin/editUs.jsp" target="right" class="nav-link">编辑用户</a></p>
<p><a href="../admin/handleIssue.jsp" target="right" class="nav-link">解决问题</a></p>

</body>
</html>

