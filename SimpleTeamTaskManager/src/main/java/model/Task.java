/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author micha
 */
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class Task {

    private int id;
    private String title;
    private String description;
    private Date dueDate;
    private String status;  // "pending", "in_progress", "complete"
    private int assignedTo;
    private int createdBy;
    private Timestamp createdAt;

    // Constructors
    public Task() {
    }

    public Task(String title, String description, Date dueDate, String status, int assignedTo, int createdBy) {
        this.title = title;
        this.description = description;
        this.dueDate = dueDate;
        this.status = status;
        this.assignedTo = assignedTo;
        this.createdBy = createdBy;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(int assignedTo) {
        this.assignedTo = assignedTo;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    // Add to Task.java
    private List<TaskNote> notes;

// Add getters and setters
    public List<TaskNote> getNotes() {
        return notes;
    }

    public void setNotes(List<TaskNote> notes) {
        this.notes = notes;
    }
}
