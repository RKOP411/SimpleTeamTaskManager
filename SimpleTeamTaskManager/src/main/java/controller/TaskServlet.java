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

import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
