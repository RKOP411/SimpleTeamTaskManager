<%@page import="java.util.List"%>
<%@page import="model.Task"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Tasks - TaskFlow</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    </head>
    <body class="bg-light">
        <div class="container mt-4">
            <h1>Task Dashboard</h1>

            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Employee Name</th>
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
                                // Get the note for this task
                                String noteText = "No notes available";
                                if (task.getNotes() != null && !task.getNotes().isEmpty()) {
                                    noteText = task.getNotes().get(0).getNote();
                                }
                                String assignedName = task.getAssignedUser() != null ? task.getAssignedUser().getName() : "Unassigned";
                                String assignedEmail = task.getAssignedUser() != null ? task.getAssignedUser().getEmail() : "N/A";
                    %>
                    <!-- Task Row -->
                    <tr>
                        <td><%= task.getId()%></td>
                        <td>
                            <i class="bi bi-person-circle"></i> <%= assignedName%>
                            <small class="text-muted d-block"><%= assignedEmail%></small>
                        </td>
                        <td><%= task.getTitle()%></td>
                        <td><%= task.getDueDate()%></td>
                        <td>
                            <span class="badge <%= task.getStatus().equals("complete") ? "bg-success" : task.getStatus().equals("in_progress") ? "bg-warning" : "bg-danger"%>">
                                <%= task.getStatus().equals("complete") ? " <i class='bi bi-check-circle'></i> Complete" : task.getStatus().equals("in_progress") ? " <i class='bi bi-hourglass-split'></i> In Progress" : "<i class='bi bi-x-circle'></i> Pending"%>
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#noteModal<%= task.getId()%>">
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

                    <!-- Note Modal  -->
                <div class="modal fade" id="noteModal<%= task.getId()%>" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Task Note: <%= task.getTitle()%></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <strong>Task ID:</strong> <%= task.getId()%><br>
                                <strong>Task Title:</strong> <%= task.getTitle()%><br>
                                <strong>Due Date:</strong> <%= task.getDueDate()%><br>
                                <strong>Status:</strong> <%= task.getStatus()%><br>
                                <hr>

                                <strong>Detail:</strong> <%= task.getDescription()%><br>
                                <small class="text-muted">Note: <%= noteText%></small><br>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Note Modal  -->

                <!-- END of LOOP-->
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="6" class="text-center">No tasks found</td>
                </tr>
                <% }%>
                </tbody>
            </table>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                function editTask(taskId) {
                                    alert('Edit task ' + taskId + ' - Will connect to database');
                                }

                                function deleteTask(taskId) {
                                    if (confirm('Are you sure you want to delete this task?')) {
                                        alert('Delete task ' + taskId + ' - Will remove from database');
                                    }
                                }

                                function saveTask() {
                                    alert('Task saved - Will insert into database');
                                }
        </script>
    </body>
</html>