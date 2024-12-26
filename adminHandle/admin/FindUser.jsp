<%@ page import="java.sql.*" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>查询用户信息</title>
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
            width: 30%;
            padding: 10px;
            margin-right: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        select {
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
        .voted {
            background-color: #28a745;
            color: white;
            padding: 5px;
            border-radius: 3px;
        }
        .not-voted {
            background-color: #dc3545;
            color: white;
            padding: 5px;
            border-radius: 3px;
        }
        .admin {
            background-color: #ffc107;
            color: black;
            padding: 5px;
            border-radius: 3px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>查询用户信息</h1>
    <form method="get" action="">
        <input type="text" name="name" placeholder="请输入用户名" value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>" />
        <select name="gender">
            <option value="">选择性别</option>
            <option value="男" <%= "男".equals(request.getParameter("sex")) ? "selected" : "" %>>男</option>
            <option value="女" <%= "女".equals(request.getParameter("sex")) ? "selected" : "" %>>女</option>
        </select>
        <button type="submit">查询</button>
    </form>
    <table>
        <thead>
        <tr>
            <th>序号</th>
            <th>用户名</th>
            <th>性别</th>
            <th>状态</th>
        </tr>
        </thead>
        <tbody>
        <%
            String name = request.getParameter("name");
            String gender = request.getParameter("sex");
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // 加载数据库驱动
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedb", "root", "dtm20031126");

                // 构建查询条件
                StringBuilder sql = new StringBuilder("SELECT id, name, sex, has_voted, role FROM users WHERE 1=1");

                if (name != null && !name.trim().isEmpty()) {
                    sql.append(" AND name LIKE ?");
                }
                if (gender != null && !gender.trim().isEmpty()) {
                    sql.append(" AND sex = ?");
                }

                stmt = conn.prepareStatement(sql.toString());

                int index = 1;
                if (name != null && !name.trim().isEmpty()) {
                    stmt.setString(index++, "%" + name + "%");
                }
                if (gender != null && !gender.trim().isEmpty()) {
                    stmt.setString(index++, gender);
                }

                rs = stmt.executeQuery();
                int sequence = 1; // 序号从 1 开始
                while (rs.next()) {
                    String userName = rs.getString("name");
                    String userSex = rs.getString("sex");
                    boolean hasVoted = rs.getBoolean("has_voted");
                    String isAdmin = rs.getString("role");
        %>
        <tr>
            <td><%= sequence++ %></td>
            <td><%= userName %></td>
            <td><%= userSex %></td>
            <td>
                <%
                    if (Objects.equals(isAdmin, "admin")) {
                %>
                <span class="admin">管理员</span>
                <%
                } else {
                    if (hasVoted) {
                %>
                <span class="voted">已投</span>
                <%
                } else {
                %>
                <span class="not-voted">未投</span>
                <%
                        }
                    }
                %>
            </td>
        </tr>
        <%
            }

            if (sequence == 1) {
                // 如果没有任何记录
        %>
        <tr>
            <td colspan="4">未找到符合条件的用户信息。</td>
        </tr>
        <%
            }
        } catch (Exception e) {
        %>
        <tr>
            <td colspan="4">查询失败：<%= e.getMessage() %></td>
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
</div>
</body>
</html>
