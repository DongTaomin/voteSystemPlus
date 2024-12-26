<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>大学信息展示</title>
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
        img {
            width: 100px;
            height: auto;
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
    <h1>大学信息展示</h1>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>名称</th>
            <th>票数</th>
            <th>描述</th>
            <th>图片</th>
        </tr>
        </thead>
        <tbody>
        <%
            // 获取当前页码和每页显示数量
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            int recordsPerPage = 4; // 每页显示记录数

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            int totalRecords = 0;

            try {
                // 加载数据库驱动
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedb", "root", "dtm20031126");

                // 查询总记录数
                String countSql = "SELECT COUNT(*) FROM universities";
                stmt = conn.prepareStatement(countSql);
                rs = stmt.executeQuery();
                if (rs.next()) {
                    totalRecords = rs.getInt(1);
                }

                // 查询当前页数据
                int start = (currentPage - 1) * recordsPerPage;
                String sql = "SELECT id, name, vote_count, description, image_url FROM universities LIMIT ?, ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, start);
                stmt.setInt(2, recordsPerPage);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    int voteCount = rs.getInt("vote_count");
                    String description = rs.getString("description");
                    String imageUrl = rs.getString("image_url");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td><%= voteCount %></td>
            <td><%= description %></td>
            <td>
                <% if (imageUrl != null && !imageUrl.isEmpty()) { %>
                <img src="<%= imageUrl %>" alt="<%= name %>">
                <% } else { %>
                无图片
                <% } %>
            </td>
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
