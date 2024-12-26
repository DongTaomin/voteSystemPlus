<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>大学信息查询</title>
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
        form {
            text-align: center;
            margin-bottom: 20px;
        }
        input[type="text"] {
            width: 50%;
            padding: 10px;
            margin-right: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
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
    </style>
</head>
<body>
<div class="container">
    <h1>大学信息查询</h1>
    <form method="get" action="">
        <input type="text" name="query" placeholder="请输入大学名称关键字" value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>" />
        <button type="submit">搜索</button>
    </form>
    <table>
        <thead>
        <tr>
            <th>序号</th>
            <th>大学名称</th>
            <th>描述</th>
            <th>票数</th>
            <th>图片</th>
        </tr>
        </thead>
        <tbody>
        <%
            String query = request.getParameter("query");
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            if (query != null && !query.trim().isEmpty()) {
                try {
                    // 加载数据库驱动
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedb", "root", "dtm20031126");

                    // 查询符合条件的大学信息
                    String sql = "SELECT name, description, vote_count, image_url FROM universities WHERE name LIKE ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, "%" + query + "%");
                    rs = stmt.executeQuery();

                    int sequence = 1; // 序号从 1 开始
                    while (rs.next()) {
                        String name = rs.getString("name");
                        String description = rs.getString("description");
                        int voteCount = rs.getInt("vote_count");
                        String imageUrl = rs.getString("image_url");
        %>
        <tr>
            <td><%= sequence++ %></td>
            <td><%= name %></td>
            <td><%= description %></td>
            <td><%= voteCount %></td>
            <td>
                <% if (imageUrl != null && !imageUrl.trim().isEmpty()) { %>
                <img src="<%= imageUrl %>" alt="<%= name %>" style="width: 100px; height: auto;" />
                <% } else { %>
                无图片
                <% } %>
            </td>
        </tr>
        <%
            }

            if (sequence == 1) {
                // 如果没有任何记录
        %>
        <tr>
            <td colspan="5">未找到符合条件的大学信息。</td>
        </tr>
        <%
            }
        } catch (Exception e) {
        %>
        <tr>
            <td colspan="5">查询失败：<%= e.getMessage() %></td>
        </tr>
        <%
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        } else {
        %>
        <tr>
            <td colspan="5">请输入大学名称关键字进行搜索。</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
