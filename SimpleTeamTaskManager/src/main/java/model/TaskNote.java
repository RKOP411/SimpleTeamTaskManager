/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;

/**
 *
 * @author micha
 */
public class TaskNote {
    private int id;
    private int taskId;
    private int userId;
    private String note;
    private Timestamp createdAt;
    
    // Constructors
    public TaskNote() {}
    
    public TaskNote(int taskId, int userId, String note) {
        this.taskId = taskId;
        this.userId = userId;
        this.note = note;
    }
    
    // Getters
    public int getId() {
        return id;
    }
    
    public int getTaskId() {
        return taskId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public String getNote() {
        return note;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    // Setters
    public void setId(int id) {
        this.id = id;
    }
    
    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "TaskNote{" + "id=" + id + ", taskId=" + taskId + 
               ", userId=" + userId + ", note=" + note + 
               ", createdAt=" + createdAt + '}';
    }
}
