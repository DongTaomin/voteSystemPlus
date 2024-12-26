<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2024/12/25
  Time: 18:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户问题管理</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 30px auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .action-button {
            padding: 5px 10px;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .unsolved {
            background-color: #dc3545;
        }
        .solved {
            background-color: #28a745;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>用户问题管理</h1>

    <%
        request.setCharacterEncoding("utf-8");
        // 数据库连接信息
        String url = "jdbc:mysql://localhost:3306/votedb";
        String dbUser = "root";
        String dbPassword = "dtm20031126";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // 获取所有问题
            String sql = "SELECT issue.id, issue.user_id, users.name AS user_name, issue.description, issue.status, issue.create_time " +
                    "FROM issue " +
                    "JOIN users ON issue.user_id = users.id " +
                    "ORDER BY issue.create_time DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
    %>

    <table>
        <thead>
        <tr>
<%--            <th>问题ID</th>--%>
            <th>提交用户</th>
            <th>问题描述</th>
            <th>提交时间</th>
            <th>状态</th>
        </tr>
        </thead>
        <tbody>
        <%
            request.setCharacterEncoding("utf-8");
            boolean hasIssues = false;
            while (rs.next()) {
                hasIssues = true;
                int issueId = rs.getInt("id");
                String userName = rs.getString("user_name");
                String problem = rs.getString("description");
                String status = rs.getString("status");
                Timestamp submissionTime = rs.getTimestamp("create_time");
        %>
        <tr>
<%--            <td><%= issueId %></td>--%>
            <td><%= userName %></td>
            <td><%= problem %></td>
            <td><%= submissionTime %></td>
            <td>
                <%
                    if ("待解决".equals(status)) {
                %>
                <a href="updateIssueStatus.jsp?id=<%= issueId %>&status=已解决" class="action-button unsolved">待解决</a>
                <%
                } else {
                %>
                <span class="action-button solved">已解决</span>
                <%
                    }
                %>
            </td>
        </tr>
        <%
            }

            if (!hasIssues) {
        %>
        <tr>
            <td colspan="5" style="text-align: center;">没有用户提交的问题。</td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.print("<tr><td colspan='5' style='text-align: center;'>查询失败：" + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>

