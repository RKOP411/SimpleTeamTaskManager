/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author micha
 */
public class TaskDAO {
    
    // Get tasks assigned to a specific user
    public List<Task> getTasksByUser(int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE assigned_to = ? ORDER BY id ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setDueDate(rs.getDate("due_date"));
                task.setStatus(rs.getString("status"));
                task.setAssignedTo(rs.getInt("assigned_to"));
                task.setCreatedBy(rs.getInt("created_by"));
                task.setCreatedAt(rs.getTimestamp("created_at"));
                tasks.add(task);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
    
    // Get all tasks (for manager)
    public List<Task> getAllTasks() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT t.*, u.name as assignee_name FROM tasks t " +
                     "LEFT JOIN users u ON t.assigned_to = u.id " +
                     "ORDER BY t.id ASC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setDueDate(rs.getDate("due_date"));
                task.setStatus(rs.getString("status"));
                task.setAssignedTo(rs.getInt("assigned_to"));
                task.setCreatedBy(rs.getInt("created_by"));
                task.setCreatedAt(rs.getTimestamp("created_at"));
                tasks.add(task);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
    
    // Add new task
    public boolean addTask(Task task) {
        String sql = "INSERT INTO tasks (title, description, due_date, status, assigned_to, created_by) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, task.getTitle());
            pstmt.setString(2, task.getDescription());
            pstmt.setDate(3, task.getDueDate());
            pstmt.setString(4, task.getStatus());
            pstmt.setInt(5, task.getAssignedTo());
            pstmt.setInt(6, task.getCreatedBy());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update task status
    public boolean updateTaskStatus(int taskId, String status) {
        String sql = "UPDATE tasks SET status = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, taskId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete task
    public boolean deleteTask(int taskId) {
        String sql = "DELETE FROM tasks WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, taskId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
