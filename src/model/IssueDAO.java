package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import util.DBHelper;
public class IssueDAO {

    // 提交问题反馈
    public static boolean submitFeedback(int userId, String description) throws SQLException {
        String sql = "INSERT INTO issue (user_id, description, status) VALUES (?, ?, '待解决')";

        try (Connection conn = DBHelper.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, description);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
