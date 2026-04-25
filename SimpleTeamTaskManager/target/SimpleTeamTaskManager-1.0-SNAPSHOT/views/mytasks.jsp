<%@page import="java.util.List"%>
<%@page import="model.Task"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Tasks - TaskFlow</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-4">
            <h1>Task Dashboard</h1>

            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Task Name</th>
                        <th>Due Date</th>
                        <th>Status</th>
                        <th>Notes</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                        if (tasks != null && !tasks.isEmpty()) {
                            for (Task task : tasks) {
                    %>
                    <tr>
                        <td><%= task.getId()%></td>
                        <td><%= task.getTitle()%></td>
                        <td><%= task.getDueDate()%></td>
                        <td>
                            <span class="badge <%= task.getStatus().equals("complete") ? "bg-success" : task.getStatus().equals("in_progress") ? "bg-warning" : "bg-danger"%>">
                                <%= task.getStatus().equals("complete") ? "Complete" : task.getStatus().equals("in_progress") ? "In Progress" : "Pending"%>
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#noteModal1">
                                <i class="bi bi-chat-text"></i> View Note
                            </button>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-warning" onclick="editTask(<%= task.getId()%>)">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <button class="btn btn-sm btn-danger" onclick="deleteTask(<%= task.getId()%>)">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" class="text-center">No tasks found</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
        <!-- Note Modal 1 -->
        <div class="modal fade" id="noteModal1" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Task Note</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <strong>Task:</strong> Fix login bug<br>
                        <strong>Note:</strong> Fixed null pointer exception in authentication service.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        // JavaScript functions for task management
        function editTask(taskId) {
            alert('Edit task ' + taskId + ' - Will connect to database');
            // Later: fetch task data and populate edit form
        }

        function deleteTask(taskId) {
            if (confirm('Are you sure you want to delete this task?')) {
                alert('Delete task ' + taskId + ' - Will remove from database');
                // Later: send DELETE request to servlet
            }
        }

        function saveTask() {
            alert('Task saved - Will insert into database');
            // Later: collect form data and send to servlet via AJAX
            // Close modal and refresh table
        }
    </script>
</html>