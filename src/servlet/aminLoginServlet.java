package servlet;

import model.User;
import model.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class aminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        User user = UserDAO.login(name, password);
        if (user != null && "admin".equals(user.getRole())) {
            // 设置管理员角色到 session 中
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("admin.jsp");  // 登录成功后跳转到管理员页面
        } else {
            response.sendRedirect("adminLogin.jsp?error=invalid");  // 登录失败，返回管理员登录页面
        }
    }
}
