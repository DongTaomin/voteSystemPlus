<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.UniversityDAO" %>
<%@ page import="model.University" %>
<%@ page import="model.VoteDAO" %>
<%@ page import="java.util.List" %>
<%
    // 从 session 中获取用户信息
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
    boolean hasVoted = isLoggedIn && user.hasVoted();  // 判断用户是否已投票
%>

<html>
<head>
    <title>大学投票系统</title>

    <!-- 引入 Slick CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css"/>

    <!-- 引入 jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- 引入 Slick JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>

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

        .carousel {
            width: 80%;
            margin: 0 auto;

            position: relative;
        }

        /* 轮播图片样式 */
        .carousel img {
            margin: 0 auto;
            width: 300px;
            height: auto;
            object-fit: cover; /* 保证图片保持比例并裁剪多余部分 */
        }

        .carousel .slick-prev, .carousel .slick-next {
            color: black;
        }

        .view-vote-button {
            margin-top: 10px;
            background-color: #4a90e2;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .view-vote-button:hover {
            background-color: #357ab8;
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

        .carousel div {
            margin-bottom: 20px;
        }

        .admin-login {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #357ab8;
            color: white;
            padding: 5px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .admin-login:hover {
            background-color: #28658f;
        }
        .feedback-link {
            position: fixed;
            bottom: 1px;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function(){
            $('.carousel').slick({
                infinite: true,         // 循环播放
                slidesToShow: 1,        // 每次显示1个项目
                slidesToScroll: 1,      // 每次滚动1个项目
                prevArrow: '<button type="button" class="slick-prev">Prev</button>', // 自定义上一页按钮
                nextArrow: '<button type="button" class="slick-next">Next</button>', // 自定义下一页按钮
                autoplay: true,         // 自动播放
                autoplaySpeed: 3000,    // 每隔3秒切换
            });
        });
    </script>
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

<!-- 管理员登录入口 -->
<% if (!isLoggedIn || (isLoggedIn && !"admin".equals(user.getRole()))) { %>
<a href="../adminHandle/login.jsp" class="admin-login">管理员登录</a>
<% } %>

<!-- 页面内容 -->
<div class="content">
    <h2>大学投票系统</h2>

    <%-- 轮播图展示大学信息 --%>
    <div class="carousel">
        <%
            List<University> universities = UniversityDAO.getAllUniversities();
            for (University university : universities) {
        %>
        <div>
            <img src="<%= university.getImageUrl() %>" alt="<%= university.getName() %>">
            <p><%= university.getName() %></p>
            <p><%= university.getDescription() %></p>
            <%-- 判断用户是否已投票 --%>
            <% if (!hasVoted) { %>
            <!-- 用户未投票，显示投票按钮 -->
            <form action="/servlet.VoteServlet" method="post" onsubmit="return checkLogin();">
                <input type="hidden" name="university" value="<%= university.getId() %>">
                <input type="submit" value="投票">
            </form>
            <% } else { %>
            <!-- 已投票用户，显示查看投票信息按钮 -->
            <form action="voteInfo.jsp" method="get">
                <input type="submit" value="查看您的投票信息" />
            </form>

            <% } %>

            <!-- 查看票数按钮 -->
            <a href="viewVote.jsp?universityId=<%= university.getId() %>" class="view-vote-button">查看票数</a>
        </div>
        <% } %>
    </div>
    <%-- 反馈问题按钮 --%>
    <% if (isLoggedIn) { %>
    <div class="feedback-button">
        <a href="submitFeedback.jsp" class="feedback-link">反馈问题</a>
    </div>
    <% } %>


</div>

<script>
    function checkLogin() {
        var loggedIn = <%= isLoggedIn ? "true" : "false" %>;
        if (!loggedIn) {
            alert("请登录后再投票！");
            window.location.href = "login.jsp";  // 登录后跳转到登录页面
            return false; // 阻止表单提交
        }
        return true;
    }
</script>

</body>
</html>
