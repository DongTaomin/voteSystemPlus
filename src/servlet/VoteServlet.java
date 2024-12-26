package servlet;

import model.User;
import model.VoteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

public class VoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        // 确保用户已登录
        if (user == null) {
            response.sendRedirect("voteSystem/login.jsp");
            return;
        }

        // 检查用户是否已经投过票
        if (user.hasVoted()) {
            // 如果已经投票，跳转到提示页面
            response.sendRedirect("voteSystem/voteError.jsp");
            return;
        }

        // 获取用户选择的大学ID
        int universityId = Integer.parseInt(request.getParameter("university"));

        // 使用 VoteDAO 来存储投票，并更新票数
        if (VoteDAO.recordVote(user.getId(), universityId)) {
            // 更新用户投票状态（在数据库中设置 has_voted = true）
            VoteDAO.updateUserHasVoted(user.getId(), true);

            // 更新用户对象中的投票状态
            user.setHasVoted(true);

            // 保存更新后的用户对象回 session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // 增加大学的票数
            VoteDAO.incrementVoteCount(universityId);

            response.sendRedirect("voteSystem/main.jsp"); // 投票成功，重定向到结果页面
        } else {
            response.sendRedirect("voteSystem/fail.jsp"); // 投票失败，跳转到错误页面
        }
    }
}
