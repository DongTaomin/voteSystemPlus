<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
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
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .status-voted {
            color: green;
            font-weight: bold;
        }
        .status-not-voted {
            color: red;
            font-weight: bold;
        }
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        button {
            padding: 5px 10px;
            font-size: 14px;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .edit {
            background-color: #28a745;
        }
        .edit:hover {
            background-color: #218838;
        }
        .remove {
            background-color: #dc3545;
        }
        .remove:hover {
            background-color: #c82333;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            padding: 5px 10px;
            margin: 0 5px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>用户管理</h1>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>用户名</th>
            <th>性别</th>
            <th>投票状态</th>
            <th>密码</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            // 数据库连接信息
            String url = "jdbc:mysql://localhost:3306/votedb";
            String username = "root";
            String password = "dtm20031126";

            // 获取当前页码，默认第一页
            int currentPage = 1;
            if (request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }

            // 每页显示的记录数
            int pageSize = 5;

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            int totalPages = 0;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

                // 获取用户总数（不包括管理员）
                String countSql = "SELECT COUNT(*) FROM users WHERE name != 'admin'";
                stmt = conn.prepareStatement(countSql);
                rs = stmt.executeQuery();
                rs.next();
                int totalRecords = rs.getInt(1);

                // 计算总页数
                totalPages = (int) Math.ceil(totalRecords * 1.0 / pageSize);

                // 获取当前页数据
                String sql = "SELECT * FROM users WHERE name != 'admin' LIMIT ?, ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, (currentPage - 1) * pageSize);
                stmt.setInt(2, pageSize);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int userId = rs.getInt("id");
                    String name = rs.getString("name");
                    String sex = rs.getString("sex");
                    boolean hasVoted = rs.getBoolean("has_voted");
        %>
        <tr>
            <td><%= userId %></td>
            <td><%= name %></td>
            <td><%= sex %></td>
            <td>
                <span class="<%= hasVoted ? "status-voted" : "status-not-voted" %>">
                    <%= hasVoted ? "已投" : "未投" %>
                </span>
            </td>
            <td>******</td>
            <td>
                <div class="action-buttons">
                    <button class="edit" onclick="window.location.href='editUser.jsp?id=<%= userId %>'">编辑</button>
                    <button class="remove" onclick="if (confirm('确定删除该用户吗？')) window.location.href='deleteUser.jsp?id=<%= userId %>'">删除</button>
                </div>
            </td>
        </tr>
        <%
            }

            if (!rs.isBeforeFirst()) {
        %>

        <%
            }
        } catch (Exception e) {
        %>
        <tr>
            <td colspan="6">查询失败：<%= e.getMessage() %></td>
        </tr>
        <%
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        </tbody>
    </table>

    <!-- 分页 -->
    <div class="pagination">
        <%
            for (int i = 1; i <= totalPages; i++) {
        %>
        <a href="?page=<%= i %>" class="<%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
