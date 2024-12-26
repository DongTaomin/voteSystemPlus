<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>编辑用户</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 50px auto;
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
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        label {
            font-size: 14px;
            color: #555;
        }
        input, select, button {
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>编辑用户信息</h1>
    <%
        request.setCharacterEncoding("utf-8");
        String url = "jdbc:mysql://localhost:3306/votedb";
        String dbUser = "root";
        String dbPassword = "dtm20031126";
        int userId = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String userName = "", userSex = "", userPassword = "";
        boolean hasVoted = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // 获取用户信息
            String sql = "SELECT * FROM users WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                userName = rs.getString("name");
                userSex = rs.getString("sex");
                userPassword = rs.getString("password");
                hasVoted = rs.getBoolean("has_voted");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    %>
    <form method="post" action="editUser.jsp">
        <input type="hidden" name="id" value="<%= userId %>">
        <label for="name">姓名:</label>
        <input type="text" id="name" name="name" value="<%= userName %>">
        <label for="sex">性别:</label>
        <select id="sex" name="sex">
            <option value="男" <%= "男".equals(userSex) ? "selected" : "" %>>男</option>
            <option value="女" <%= "女".equals(userSex) ? "selected" : "" %>>女</option>
        </select>
        <label for="password">密码:</label>
        <input type="password" id="password" name="password" value="<%= userPassword %>">
        <label for="hasVoted">是否已投票:</label>
        <select id="hasVoted" name="hasVoted">
            <option value="true" <%= hasVoted ? "selected" : "" %>>已投</option>
            <option value="false" <%= !hasVoted ? "selected" : "" %>>未投</option>
        </select>
        <button type="submit">保存修改</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String updatedName = request.getParameter("name");
            String updatedSex = request.getParameter("sex");
            String updatedPassword = request.getParameter("password");
            boolean updatedHasVoted = Boolean.parseBoolean(request.getParameter("hasVoted"));

            try {
                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                // 更新用户表
                String updateSql = "UPDATE users SET name = ?, sex = ?, password = ?, has_voted = ? WHERE id = ?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setString(1, updatedName);
                stmt.setString(2, updatedSex);
                stmt.setString(3, updatedPassword);
                stmt.setBoolean(4, updatedHasVoted);
                stmt.setInt(5, userId);
                stmt.executeUpdate();

                // 如果用户投票状态更新为未投票，删除 votes 表中的相关记录
                if (!updatedHasVoted) {
                    String deleteVoteSql = "DELETE FROM votes WHERE user_id = ?";
                    stmt = conn.prepareStatement(deleteVoteSql);
                    stmt.setInt(1, userId);
                    stmt.executeUpdate();
                }

                out.print("<script>alert('用户信息更新成功！');window.location.href='editUs.jsp';</script>");
            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>alert('更新失败：" + e.getMessage() + "');</script>");
            } finally {
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        }
    %>
</div>
</body>
</html>
