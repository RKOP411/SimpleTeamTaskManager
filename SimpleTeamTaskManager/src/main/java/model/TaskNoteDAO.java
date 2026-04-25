/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author micha
 */
public class TaskNoteDAO {
    
    // Get all notes for a specific task
    public List<TaskNote> getNotesByTaskId(int taskId) {
        List<TaskNote> notes = new ArrayList<>();
        String sql = "SELECT * FROM task_notes WHERE task_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, taskId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                TaskNote note = new TaskNote();
                note.setId(rs.getInt("id"));
                note.setTaskId(rs.getInt("task_id"));
                note.setUserId(rs.getInt("user_id"));
                note.setNote(rs.getString("note"));
                note.setCreatedAt(rs.getTimestamp("created_at"));
                notes.add(note);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return notes;
    }
    
    // Get a single note by its ID
    public TaskNote getNoteById(int noteId) {
        String sql = "SELECT * FROM task_notes WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, noteId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                TaskNote note = new TaskNote();
                note.setId(rs.getInt("id"));
                note.setTaskId(rs.getInt("task_id"));
                note.setUserId(rs.getInt("user_id"));
                note.setNote(rs.getString("note"));
                note.setCreatedAt(rs.getTimestamp("created_at"));
                return note;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Add a new note to a task
    public boolean addNote(TaskNote note) {
        String sql = "INSERT INTO task_notes (task_id, user_id, note) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, note.getTaskId());
            pstmt.setInt(2, note.getUserId());
            pstmt.setString(3, note.getNote());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update an existing note
    public boolean updateNote(int noteId, String newNote) {
        String sql = "UPDATE task_notes SET note = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, newNote);
            pstmt.setInt(2, noteId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete a note
    public boolean deleteNote(int noteId) {
        String sql = "DELETE FROM task_notes WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, noteId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get the latest note for a task
    public TaskNote getLatestNoteByTaskId(int taskId) {
        String sql = "SELECT * FROM task_notes WHERE task_id = ? ORDER BY created_at DESC LIMIT 1";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, taskId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                TaskNote note = new TaskNote();
                note.setId(rs.getInt("id"));
                note.setTaskId(rs.getInt("task_id"));
                note.setUserId(rs.getInt("user_id"));
                note.setNote(rs.getString("note"));
                note.setCreatedAt(rs.getTimestamp("created_at"));
                return note;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}