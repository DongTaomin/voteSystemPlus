<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UniversityDAO" %>
<%@ page import="model.University" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>投票结果</title>
    <style>
        /* 页面样式 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .content {
            text-align: center;
            margin-top: 50px;
        }

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
    </style>
</head>
<body>

<div class="content">
    <h2>投票结果</h2>
    <table>
        <tr>
            <th>大学名称</th>
            <th>票数</th>
        </tr>
        <%
            List<University> universities = UniversityDAO.getAllUniversities();
            for (University university : universities) {
        %>
        <tr>
            <td><%= university.getName() %></td>
            <td><%= university.getVoteCount() %></td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>
