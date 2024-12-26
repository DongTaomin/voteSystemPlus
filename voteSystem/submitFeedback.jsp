
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>问题反馈 - 查看和管理</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .content {
            width: 80%;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #4a90e2;
            color: white;
        }
        .status-resolved {
            color: green;
        }
        .status-pending {
            color: red;
        }
        .btn {
            display: flex;
            justify-content: space-between;
            margin-left: 102px;
            margin-right: 102px;
        }
        .btn > button {
            background-color: #4a90e2;
            margin-left: 30px;
            margin-right: 30px;
        }
         a {
        text-decoration: none;
        }

    </style>
</head>
<body>
<div class="btn">

    <button><a href="main.jsp" class="back-home-button">返回首页</a></button>
    <button><a href="submit.jsp">提交问题反馈</a></button>
</div>
<div class="content">
    <h2>问题反馈</h2>

    <%
        // 获取登录用户信息
        User user = (User) session.getAttribute("user");

        if (user == null) {
            out.println("<p>请先登录后查看问题反馈。</p>");
            out.println("<a href='login.jsp'>登录</a>");
        } else {
            // 数据库连接信息
            String dbUrl = "jdbc:mysql://localhost:3306/votedb";
            String dbUser = "root";
            String dbPassword = "dtm20031126";

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                // 查询用户提交的问题
                String query = "SELECT id, description, status, create_time, update_time FROM issue WHERE user_id = ? ORDER BY create_time DESC";
                stmt = conn.prepareStatement(query);
                stmt.setInt(1, user.getId());
                rs = stmt.executeQuery();

                if (!rs.isBeforeFirst()) {
                    // 如果没有问题记录
    %>


    <%
    } else {
    %>
    <table>
        <thead>
        <tr>
            <th>问题描述</th>
            <th>状态</th>
            <th>时间</th>
        </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
                String problem = rs.getString("description");
                String status = rs.getString("status");
                Timestamp submissionTime = rs.getTimestamp("create_time");
                Timestamp updateTime = rs.getTimestamp("update_time");
        %>
        <tr>
            <td><%= problem %></td>
            <td class="<%= "已解决".equals(status) ? "status-resolved" : "status-pending" %>">
                <%= status %>
            </td>
            <td>
                <% if ("已解决".equals(status)) { %>
                <%= updateTime %>
                <% } else { %>
                <%= submissionTime %>
                <% } %>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
                }
            } catch (Exception e) {
                out.println("<p>查询失败：" + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                // 关闭资源
                if (rs != null) try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (stmt != null) try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (conn != null) try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</div>


</body>
</html>
