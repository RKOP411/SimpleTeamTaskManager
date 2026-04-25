/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;
import java.util.*;
/**
 *
 * @author micha
 */
import java.sql.*;

public class UpdateTask {

    private String url = "jdbc:mysql://localhost:3306/taskflow";
    private String username = "root";
    private String password = "";

    // Single update method - updates description, status, and note
    public boolean update(Task task) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
            conn.setAutoCommit(false);

            System.out.println("=== Update Debug ===");
            System.out.println("Task ID: " + task.getId());
            System.out.println("Description: " + task.getDescription());
            System.out.println("Status: " + task.getStatus());
            System.out.println("Note: " + task.getNote());
            System.out.println("User_id: " + task.getUser_id());

            // 1. Update tasks table
            String updateTaskSQL = "UPDATE tasks SET description = ?, status = ? WHERE id = ?";
            pstmt = conn.prepareStatement(updateTaskSQL);
            pstmt.setString(1, task.getDescription());
            pstmt.setString(2, task.getStatus());
            pstmt.setInt(3, task.getId());

            int rowsUpdated = pstmt.executeUpdate();
            pstmt.close();

            if (rowsUpdated == 0) {
                conn.rollback();
                System.out.println("Task not found");
                return false;
            }

            // 2. Update or insert note - FIXED VERSION
            String upsertNoteSQL = "INSERT INTO task_notes (task_id, note, user_id) VALUES (?, ?, ?) "
                    + "ON DUPLICATE KEY UPDATE note = VALUES(note), user_id = VALUES(user_id)";
            pstmt = conn.prepareStatement(upsertNoteSQL);
            pstmt.setInt(1, task.getId());
            pstmt.setString(2, task.getNote());
            pstmt.setInt(3, task.getUser_id());
            pstmt.executeUpdate();

            conn.commit();
            System.out.println("Update successful!");
            return true;

        } catch (Exception e) {
            System.err.println("Error in update: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
