<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UniversityDAO" %>
<%@ page import="model.University" %>
<%
    // 获取URL中的 universityId 参数
    String universityIdParam = request.getParameter("universityId");
    int universityId = Integer.parseInt(universityIdParam);

    // 根据大学ID获取详细信息
    University university = UniversityDAO.getUniversityById(universityId);
%>

<html>
<head>
    <title><%= university.getName() %> - 详情</title>
    <style>
        .details-container {
            width: 70%;
            margin: 20px auto;
            text-align: center;
        }

        .details-container img {
            width: 100%;
            max-width: 500px;
            height: auto;
            margin: 20px 0;
        }

        .back-button {
            background-color: #4a90e2;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .back-button:hover {
            background-color: #357ab8;
        }
    </style>
</head>
<body>

<div class="details-container">
    <h2><%= university.getName() %></h2>

    <%-- 显示大学的图片 --%>
    <img src="<%= university.getImageUrl() %>" alt="<%= university.getName() %>">

    <%-- 显示大学的介绍 --%>
    <p><%= university.getDescription() %></p>

    <%-- 返回按钮 --%>
    <a href="viewVote.jsp" class="back-button">返回投票结果</a>
</div>

</body>
</html>
