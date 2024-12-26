package model;

import util.DBHelper;

import java.sql.*;

public class UserDAO {

    // 登录方法，读取 has_voted 和 role 字段
    public static User login(String name, String password) {
        String sql = "SELECT * FROM users WHERE name = ? AND password = ?";
        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, name);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setSex(rs.getString("sex"));
                user.setHasVoted(rs.getBoolean("has_voted"));  // 读取 has_voted 字段
                user.setRole(rs.getString("role"));  // 读取角色字段
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 注册方法，插入新用户并将 has_voted 默认设置为 false，角色默认为普通用户
    public static boolean register(String name, String password, String sex) {
        String sql = "INSERT INTO users (name, password, sex, has_voted) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, name);
            pstmt.setString(2, password);
            pstmt.setString(3, sex);
            pstmt.setBoolean(4, false);  // 新注册用户默认未投票
            pstmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 更新用户投票状态
    public static boolean updateUserHasVoted(int userId, boolean hasVoted) {
        String sql = "UPDATE users SET has_voted = ? WHERE id = ?";
        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setBoolean(1, hasVoted);
            pstmt.setInt(2, userId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;  // 如果更新了记录，返回 true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // 如果没有更新记录，返回 false
    }

    // 根据用户名获取用户角色
    public static String getUserRole(int userId) {
        String sql = "SELECT role FROM users WHERE id = ?";
        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getString("role");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;  // 如果没有找到，返回 null
    }
}
