/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.TaskDAO;
import model.Task;
import model.TaskNote;
import model.TaskNoteDAO;
import model.User;
import model.UserDAO;
import model.UpdateTask;

import java.io.*;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

/**
 *
 * @author micha
 */
@WebServlet(name = "TaskServlet", urlPatterns = {"/mytasks"})
public class TaskServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private TaskDAO TaskDAO = new TaskDAO();
    private TaskNoteDAO TaskNoteDAO = new TaskNoteDAO();
    private UserDAO UserDAO = new UserDAO();
    private UpdateTask updateTask = new UpdateTask();

    private Gson gson = new Gson();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get all tasks from database
        List<Task> tasks = TaskDAO.getAllTasks();

        // For each task, load its notes
        for (Task task : tasks) {
            List<TaskNote> notes = TaskNoteDAO.getNotesByTaskId(task.getId());
            task.setNotes(notes);

            // Load assigned user
            User assignedUser = UserDAO.getUserById(task.getAssignedTo());
            task.setAssignedUser(assignedUser);
        }

        // Send tasks to JSP
        request.setAttribute("tasks", tasks);
        for (int i = 0; i < tasks.size(); i++) {
            System.out.println(tasks.get(i));
        }
        // Go to Task Page
        request.getRequestDispatcher("/views/mytasks.jsp")
                .forward(request, response);

    }

    // Get all tasks from database
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String contentType = request.getContentType();

        // If JSON, it's an update request
        if (contentType != null && contentType.contains("application/json")) {
            // Read and update
            StringBuilder sb = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }

            Task task = gson.fromJson(sb.toString(), Task.class);
            System.out.println("=== PARSED TASK OBJECT ===");
            System.out.println("Task ID: " + task.getId());
            System.out.println("Task user_id: " + task.getUser_id());  // Should show 1, not 0
            System.out.println("Description: " + task.getDescription());
            System.out.println("Status: " + task.getStatus());
            System.out.println("Note: " + task.getNote());
            boolean updated = updateTask.update(task);

            response.setContentType("application/json");
            if (updated) {
                response.getWriter().write("{\"success\":true}");
            } else {
                response.getWriter().write("{\"success\":false}");
            }
        } else {
            // Normal page load - show the table
            processRequest(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");

        try {
            // Read JSON from request body
            StringBuilder sb = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }

            // Parse JSON to Task object
            Task task = gson.fromJson(sb.toString(), Task.class);

            // Validate
            if (task.getId() == 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"Task ID required\"}");
                return;
            }

            // Update the task
            boolean updated = updateTask.update(task);

            if (updated) {
                response.getWriter().write("{\"success\":true,\"message\":\"Task updated successfully\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Task not found\"}");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
