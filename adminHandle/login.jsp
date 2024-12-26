<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>投票系统后台</title>
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .login-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 350px;
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        .form-control {
            width: 90%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn-primary {
            width: 97%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 15px;
        }
        .title {
            text-align: center;
            margin-bottom: 70px;
            font-size: 30px;
            font-family: 楷体;
            font-weight: bold;
            color: #007bff;
        }
    </style>
</head>
<body>
<div class="title">投票系统后台</div>
<div class="login-container">
    <h2>管理员登录</h2>
    <form action="login.jsp" method="post">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary">登录</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            boolean isValidAdmin = false;

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // 加载数据库驱动
                Class.forName("com.mysql.cj.jdbc.Driver");
                // 连接数据库
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/votedb", "root", "dtm20031126");

                // 查询管理员用户
                String sql = "SELECT * FROM users WHERE name = ? AND password = ? AND role = 'admin'";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);
                rs = stmt.executeQuery();

                // 验证管理员登录
                if (rs.next()) {
                    isValidAdmin = true;
                    // 设置 Session
                    session.setAttribute("username", username);
                    session.setAttribute("role", "admin");
                    // 跳转到管理员面板
                    response.sendRedirect("./adminDashboard/adminDashboard.jsp");
                } else {
                    out.println("<div class='error-message'>用户名或密码错误，或非管理员身份</div>");
                }
            } catch (Exception e) {
                out.println("<div class='error-message'>系统错误，请稍后再试</div>");
                e.printStackTrace();
            } finally {
                // 关闭资源
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
</div>
<script>
    let id = "1.23452384164.123412415";
    let can = document.createElement("canvas"); // 创建一个画布
    can.width = 500; // 设置宽度
    can.height = 200; // 高度

    let cans = can.getContext("2d");
    cans.rotate((-15 * Math.PI) / 180); // 水印旋转角度    0 水平
    cans.font = "14px Vedana"; // 字体大小
    cans.fillStyle = "#EAB943"; // 水印的颜色
    cans.textAlign = "left"; // 设置文本内容的当前对齐方式
    cans.textBaseline = "Middle"; // 设置在绘制文本时使用的当前文本基线
    cans.globalAlpha = 0.5; // 透明度
    cans.fillText("长安大学", can.width / 3, can.height / 2); // 在画布上绘制填色的文本（输出的文本，开始绘制文本的X坐标位置，开始绘制文本的Y坐标位置）
    cans.fillText("董陶民 万青龄", can.width / 3, can.height / 2.5); // 在画布上绘制填色的文本（输出的文本，开始绘制文本的X坐标位置，开始绘制文本的Y坐标位置）
    let div = document.createElement("div");
    div.id = id;
    div.style.pointerEvents = "none";
    div.style.top = "70px";
    div.style.left = "0px";
    div.style.position = "fixed";
    div.style.zIndex = "100000";
    div.style.width = document.documentElement.clientWidth - 30 + "px";
    div.style.height = document.documentElement.clientHeight + "px";
    div.style.background =
        "url(" + can.toDataURL("image/png") + ") left top repeat";
    document.body.appendChild(div);
</script>


</body>
</html>
