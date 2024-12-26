<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.UniversityDAO" %>
<%@ page import="model.University" %>
<%@ page import="model.VoteDAO" %>
<%
    // 从 session 中获取用户信息
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int votedUniversityId = VoteDAO.getUserVote(user.getId());
    University votedUniversity = UniversityDAO.getUniversityById(votedUniversityId);
%>

<html>
<head>
    <title>您的投票信息</title>
    <style>
        .content {
            text-align: center;
            margin-top: 50px;
        }

        .university-details {
            text-align: left;
            margin-top: 20px;
        }

        .university-details img {
            /*width: 100%;*/
            height: auto;
            max-width: 500px;
            margin: 10px 0;
        }

        .back-home-button {
            margin-top: 20px;
            background-color: #357ab8;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .back-home-button:hover {
            background-color: #285e8e;
        }
    </style>
</head>
<body>

<div class="content">
    <h2>您已投票给 <%= votedUniversity.getName() %> </h2>
    <div class="university-details">
        <img src="<%= votedUniversity.getImageUrl() %>" alt="<%= votedUniversity.getName() %>">
        <p><%= votedUniversity.getDescription() %></p>
    </div>

    <a href="viewVote.jsp" class="view-vote-button">查看所有投票结果</a>
    <a href="main.jsp" class="back-home-button">返回首页</a>
</div>

</body>
</html>
