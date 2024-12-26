<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户信息展示（分页）</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            margin: 30px auto;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: center;
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
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 5px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            color: #007bff;
            text-decoration: none;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }
        .pagination a:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>用户信息展示</h1>
    <table>
        <thead>
        <tr>
            <th>序号</th>
            <th>姓名</th>
            <th>性别</th>
            <th>投票状态</th>
            <th>密码</th>
        </tr>
        </thead>
        <tbody>
        <%
            // 获取当前页码和每页显示数量
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            int recordsPerPage = 5; // 每页显示记录数

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            int totalRecords = 0;

            try {
                // 加载数据库驱动
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedb", "root", "dtm20031126");

                // 查询总记录数（排除管理员）
                String countSql = "SELECT COUNT(*) FROM users WHERE role != 'admin'";
                stmt = conn.prepareStatement(countSql);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    totalRecords = rs.getInt(1);
                }

                // 查询当前页数据（排除管理员）
                int start = (currentPage - 1) * recordsPerPage;
                String sql = "SELECT name, sex, has_voted, password FROM users WHERE role != 'admin' LIMIT ?, ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, start);
                stmt.setInt(2, recordsPerPage);
                rs = stmt.executeQuery();

                int sequenceNumber = start + 1; // 计算当前页第一个序号
                while (rs.next()) {
                    String name = rs.getString("name");
                    String sex = rs.getString("sex");
                    boolean hasVoted = rs.getBoolean("has_voted");
                    String passwordMasked = "***";
        %>
        <tr>
            <td><%= sequenceNumber++ %></td>
            <td><%= name %></td>
            <td><%= sex %></td>
            <td class="<%= hasVoted ? "status-voted" : "status-not-voted" %>">
                <%= hasVoted ? "已投" : "未投" %>
            </td>
            <td><%= passwordMasked %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>加载数据失败：" + e.getMessage() + "</td></tr>");
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        </tbody>
    </table>

    <div class="pagination">
        <%
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

            for (int i = 1; i <= totalPages; i++) {
                if (i == currentPage) {
        %>
        <a href="?page=<%= i %>" class="active"><%= i %></a>
        <%
        } else {
        %>
        <a href="?page=<%= i %>"><%= i %></a>
        <%
                }
            }
        %>
    </div>
</div>
</body>
</html>
