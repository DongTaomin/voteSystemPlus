<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UniversityDAO" %>
<%@ page import="model.University" %>
<%@ page import="java.util.List" %>
<%
    // 每页显示10个大学
    int pageSize = 10;

    // 获取当前页数，默认是第1页
    int pageNum = 1;
    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        pageNum = Integer.parseInt(pageParam);
    }

    // 获取排序参数，默认按倒序排列
    String sortOrder = "desc"; // 默认倒序
    String sortParam = request.getParameter("sortOrder");
    if (sortParam != null) {
        sortOrder = sortParam;
    }

    // 获取大学列表
    List<University> universities = UniversityDAO.getUniversitiesWithPagination(pageNum, pageSize, sortOrder);

    // 获取总的大学数目
    int totalUniversities = UniversityDAO.getTotalUniversityCount();

    // 计算总页数
    int totalPages = (int) Math.ceil((double) totalUniversities / pageSize);
%>

<html>
<head>
    <title>所有投票结果</title>
    <style>
        table {
            width: 60%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #4a90e2;
            color: white;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination a {
            background-color: #4a90e2;
            color: white;
            padding: 8px 16px;
            margin: 0 5px;
            text-decoration: none;
            border-radius: 5px;
        }

        .pagination a:hover {
            background-color: #357ab8;
        }

        .sorting {
            text-align: center;
            margin: 20px 0;
        }

        .sort-button {
            background-color: #4a90e2;
            color: white;
            padding: 8px 16px;
            margin: 0 5px;
            text-decoration: none;
            border-radius: 5px;
        }

        .sort-button:hover {
            background-color: #357ab8;
        }
    </style>
</head>
<body>

<h2>所有大学的投票结果</h2>

<!-- 排序按钮 -->
<div class="sorting">
    <a href="viewVote.jsp?page=<%= pageNum %>&sortOrder=asc" class="sort-button">正序</a>
    <a href="viewVote.jsp?page=<%= pageNum %>&sortOrder=desc" class="sort-button">倒序</a>
</div>

<table>
    <tr>
        <th>序号</th>
        <th>大学名称</th>
        <th>票数</th>
        <th>操作</th>
    </tr>
    <%
        // 计算当前页的起始序号
        int startIndex = (pageNum - 1) * pageSize + 1;

        // 显示大学列表
        for (int i = 0; i < universities.size(); i++) {
            University university = universities.get(i);
            int serialNumber = startIndex + i;  // 序号 = 当前页的起始序号 + 当前项的索引
    %>
    <tr>
        <td><%= serialNumber %></td> <!-- 显示序号 -->
        <td><%= university.getName() %></td>
        <td><%= university.getVoteCount() %></td>
        <td>
            <a href="voteResultDetail.jsp?universityId=<%= university.getId() %>" class="view-details-button">查看详情</a>
        </td>
    </tr>
    <% } %>
</table>

<!-- 分页按钮 -->
<div class="pagination">
    <%-- 如果当前页大于1，显示上一页按钮 --%>
    <%
        if (pageNum > 1) {
    %>
    <a href="viewVote.jsp?page=<%= pageNum - 1 %>&sortOrder=<%= sortOrder %>">上一页</a>
    <% } %>

    <%-- 显示页码 --%>
    <%
        for (int i = 1; i <= totalPages; i++) {
            if (i == pageNum) {
    %>
    <span><%= i %></span>
    <% } else { %>
    <a href="viewVote.jsp?page=<%= i %>&sortOrder=<%= sortOrder %>"><%= i %></a>
    <% }
    }
    %>

    <%-- 如果当前页小于总页数，显示下一页按钮 --%>
    <%
        if (pageNum < totalPages) {
    %>
    <a href="viewVote.jsp?page=<%= pageNum + 1 %>&sortOrder=<%= sortOrder %>">下一页</a>
    <% } %>
</div>

<a href="main.jsp" class="back-home-button">返回首页</a>

</body>
</html>
