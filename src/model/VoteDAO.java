package model;

import util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VoteDAO {
    // 根据用户ID获取用户投票的大学ID
    public static int getUserVote(int userId) {
        String sql = "SELECT university_id FROM votes WHERE user_id = ?";
        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("university_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // 如果用户没有投票，返回-1
    }

    // 记录用户的投票
    public static boolean recordVote(int userId, int universityId) {
        String sql = "INSERT INTO votes (user_id, university_id) VALUES (?, ?)";
        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, universityId);
            pstmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 增加大学的票数
    public static void incrementVoteCount(int universityId) {
        String sql = "UPDATE universities SET vote_count = vote_count + 1 WHERE id = ?";
        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, universityId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 更新用户的投票状态
    public static boolean updateUserHasVoted(int userId, boolean hasVoted) {
        String sql = "UPDATE users SET has_voted = ? WHERE id = ?";
        try (Connection connection = DBHelper.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setBoolean(1, hasVoted);
            ps.setInt(2, userId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // 如果更新了记录，则返回 true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // 如果没有更新记录，则返回 false
    }
}
