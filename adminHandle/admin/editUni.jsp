        <%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>大学信息管理</title>
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
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
        button {
            padding: 5px 10px;
            font-size: 14px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .action-buttons {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .action-buttons button {
            width: 48px;
        }
        img {
            max-width: 100px;
            height: auto;
        }
        .success-message {
            background-color: #28a745;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }
        .action-buttons > .edit{
            background-color: #28a745;
        }
        .action-buttons > .remove{
            background-color: #dc3545;
        }
    </style>
    <script>
        // 弹出提示框
        function showSuccessMessage(message) {
            alert(message);
        }
    </script>
</head>
<body>
<div class="container">
    <h1>大学信息管理</h1>

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
        int pageSize = 3;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        int totalPages = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // 获取大学总数
            String countSql = "SELECT COUNT(*) FROM universities";
            stmt = conn.prepareStatement(countSql);
            rs = stmt.executeQuery();
            rs.next();
            int totalRecords = rs.getInt(1);

            // 计算总页数
            totalPages = (int) Math.ceil(totalRecords * 1.0 / pageSize);

            // 获取当前页数据
            String sql = "SELECT * FROM universities LIMIT ?, ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, (currentPage - 1) * pageSize);
            stmt.setInt(2, pageSize);
            rs = stmt.executeQuery();
    %>

    <table>
        <thead>
        <tr>
            <th>序号</th>
            <th>大学名称</th>
            <th>大学描述</th>
            <th>大学图片</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            int sequence = (currentPage - 1) * pageSize + 1;  // 当前页的序号从1开始
            while (rs.next()) {
                String universityName = rs.getString("name");
                String description = rs.getString("description");
                String imageUrl = rs.getString("image_url");
                int universityId = rs.getInt("id");
        %>
        <tr>
            <td><%=sequence++%></td>
            <td><%=universityName%></td>
            <td><%=description%></td>
            <td><img src="<%=imageUrl%>" alt="<%=universityName%>"></td>
            <td>
                <div class="action-buttons">
                    <!-- 编辑按钮 -->
                    <button class="edit"  onclick="window.location.href='editUniversity.jsp?id=<%=universityId%>'">编辑</button>
                    <!-- 删除按钮 -->
                    <button class="remove" onclick="window.location.href='deleteUniversity.jsp?id=<%=universityId%>'">删除</button>
                </div>
            </td>
        </tr>
        <%
            }

            if (sequence == (currentPage - 1) * pageSize + 1) {
        %>
        <tr>
            <td colspan="5">未找到大学信息。</td>
        </tr>
        <%
            }
        } catch (Exception e) {
        %>
        <tr>
            <td colspan="5">查询失败：<%=e.getMessage()%></td>
        </tr>
        <%
                e.printStackTrace();
            } finally {
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
        %>
        </tbody>
    </table>

    <!-- 分页 -->
    <div style="text-align: center; margin-top: 20px;">
        <%
            for (int i = 1; i <= totalPages; i++) {
        %>
        <a href="?page=<%=i%>" style="padding: 5px 10px; text-decoration: none; margin: 0 5px; <%
                    if (i == currentPage) { %>background-color: #007bff; color: white;<% } %>"><%=i%></a>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
