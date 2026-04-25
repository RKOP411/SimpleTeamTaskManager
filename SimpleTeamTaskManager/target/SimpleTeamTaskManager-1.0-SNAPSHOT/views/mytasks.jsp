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
        <div class="container-fluid px-4">
            <div class="container mt-4 mb-4">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h1 class="display-6">
                                <i class="bi bi-check2-square"></i> Task Dashboard
                            </h1>
                            <p class="text-muted">Manage and track team tasks</p>
                        </div>
                        <div>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addTaskModal">
                                <i class="bi bi-plus-circle"></i> Add New Task
                            </button>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm">
                    <div class="card-header bg-white">
                        <h5 class="mb-0"><i class="bi bi-table"></i> All Tasks</h5>
                    </div>
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
                                        <%= task.getStatus().equals("complete") ? " <i class='bi bi-check-circle'></i> Complete" : task.getStatus().equals("in_progress") ? "<i class='bi bi-hourglass-split'></i> In Progress" : "<i class='bi bi-x-circle'></i> Pending"%>
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#noteModal<%= task.getId()%>">
                                        <i class="bi bi-chat-text"></i> View Note 
                                    </button>
                                </td>
                                <td>
                                    <!-- EDIT BUTTON - Calls editTask with task ID -->
                                    <button class="btn btn-sm btn-warning" onclick='editTask(<%= task.getId()%>, "<%= task.getDescription()%>", "<%= task.getStatus()%>", "<%= noteText%>", "<%= task.getAssignedTo()%>")'>
                                        <i class="bi bi-pencil"></i> Edit
                                    </button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteTask(<%= task.getId()%>)">
                                        <i class="bi bi-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>

                            <!-- Note Modal for this task -->
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
                                        <strong>Description:</strong> <%= task.getDescription()%><br>
                                        <strong>Note:</strong> <%= noteText%><br>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center">No tasks found</td>
                        </tr>
                        <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- EDIT TASK MODAL -->
        <div class="modal fade" id="editTaskModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="bi bi-pencil-square"></i> Edit Task
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="edit_task_id">

                        <!-- Task Description -->
                        <div class="mb-3">
                            <label class="form-label">Task Description</label>
                            <textarea class="form-control" id="edit_description" rows="3" required></textarea>
                        </div>
                        <!-- Hidden User ID -->
                        <input type="hidden" id="edit_user_id">
                        <!-- Task Status -->
                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <select class="form-select" id="edit_status" required>
                                <option value="pending">Pending</option>
                                <option value="in_progress">In Progress</option>
                                <option value="complete">Complete</option>
                            </select>
                        </div>

                        <!-- Task Note -->
                        <div class="mb-3">
                            <label class="form-label">Task Note</label>
                            <textarea class="form-control" id="edit_note" rows="3" placeholder="Add notes about this task..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" onclick="updateTask()">Update Task</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            // Edit Task - Uses data from table row (NO fetch needed!)
                            function editTask(id, description, status, note, userid) {
                                // Populate the edit form with current values from table
                                console.log(id);
                                console.log(userid);
                                console.log(description);
                                console.log(status);
                                console.log(note);
                                document.getElementById('edit_task_id').value = id;
                                document.getElementById('edit_user_id').value = userid;
                                document.getElementById('edit_description').value = description;
                                document.getElementById('edit_status').value = status;
                                document.getElementById('edit_note').value = note;

                                // Show the modal
                                new bootstrap.Modal(document.getElementById('editTaskModal')).show();
                            }

                            function updateTask() {
                                const taskData = {
                                    id: parseInt(document.getElementById('edit_task_id').value),
                                    user_id: parseInt(document.getElementById('edit_user_id').value),
                                    description: document.getElementById('edit_description').value,
                                    status: document.getElementById('edit_status').value,
                                    note: document.getElementById('edit_note').value
                                };

                                // Send ONLY the updated data to servlet
                                fetch('mytasks', {
                                    method: 'POST', // or 'PUT' - both work
                                    headers: {
                                        'Content-Type': 'application/json',
                                    },
                                    body: JSON.stringify(taskData)
                                })
                                        .then(response => response.json())
                                        .then(data => {
                                            if (data.success) {
                                                alert('Task updated!');
                                                location.reload(); // Refresh to show changes
                                            }
                                        });
                            }
                            function deleteTask(taskId) {
                                if (confirm('Are you sure you want to delete this task?')) {
                                    alert('Delete task ' + taskId + ' - Will remove from database');
                                    // Later: send DELETE request to servlet
                                }
                            }
        </script>
    </body>
</html>