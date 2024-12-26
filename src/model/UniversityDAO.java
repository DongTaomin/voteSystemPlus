package model;

import util.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;




import java.sql.*;

public class UniversityDAO {

    // 根据大学ID获取大学信息
    public static University getUniversityById(int id) {
        University university = null;
        String sql = "SELECT * FROM universities WHERE id = ?";
        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    university = new University();
                    university.setId(rs.getInt("id"));
                    university.setName(rs.getString("name"));
                    university.setVoteCount(rs.getInt("vote_count"));
                    university.setDescription(rs.getString("description"));
                    university.setImageUrl(rs.getString("image_url"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return university;
    }

    // 获取所有大学信息
    public static List<University> getAllUniversities() {
        List<University> universities = new ArrayList<>();
        String sql = "SELECT * FROM universities";
        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                University university = new University();
                university.setId(rs.getInt("id"));
                university.setName(rs.getString("name"));
                university.setVoteCount(rs.getInt("vote_count"));
                university.setDescription(rs.getString("description"));
                university.setImageUrl(rs.getString("image_url"));
                universities.add(university);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return universities;
    }

    // 获取大学的总数（用于计算分页的总页数）
    public static int getTotalUniversityCount() {
        String sql = "SELECT COUNT(*) FROM universities";
        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);  // 返回大学总数
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /// 获取带分页和排序的大学列表
    public static List<University> getUniversitiesWithPagination(int pageNum, int pageSize, String sortOrder) {
        List<University> universities = new ArrayList<>();
        String sql = "SELECT * FROM universities ORDER BY vote_count " + (sortOrder.equals("asc") ? "ASC" : "DESC") + " LIMIT ?, ?";

        try (Connection conn = DBHelper.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 设置分页参数
            pstmt.setInt(1, (pageNum - 1) * pageSize);
            pstmt.setInt(2, pageSize);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                University university = new University();
                university.setId(rs.getInt("id"));
                university.setName(rs.getString("name"));
                university.setDescription(rs.getString("description"));
                university.setImageUrl(rs.getString("image_url"));
                university.setVoteCount(rs.getInt("vote_count"));
                universities.add(university);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return universities;
    }

}

