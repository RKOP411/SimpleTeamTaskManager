<%-- 
    Document   : mytasks
    Created on : 2026年4月24日, 下午7:02:12
    Author     : micha
--%>

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
            <!-- Header -->
            <div class="row mt-4 mb-4">
                <div class="col">
                    <h1 class="display-6">
                        <i class="bi bi-check2-square"></i> Task Dashboard
                    </h1>
                    <p class="text-muted">Manage and track team tasks</p>
                </div>
                <div class="col text-end">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addTaskModal">
                        <i class="bi bi-plus-circle"></i> Add New Task
                    </button>
                </div>
            </div>
            
            <!-- Tasks Table -->
            <div class="card shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0"><i class="bi bi-table"></i> All Tasks</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Employee Name</th>
                                    <th>Task Name</th>
                                    <th>Due Date</th>
                                    <th>Status</th>
                                    <th>Notes</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Sample Row 1 -->
                                <tr>
                                    <td>1</td>
                                    <td>
                                        <i class="bi bi-person-circle"></i> John Smith
                                        <small class="text-muted d-block">john@example.com</small>
                                    </td>
                                    <td>Fix login bug</td>
                                    <td>2024-01-15</td>
                                    <td>
                                        <span class="badge bg-success">
                                            <i class="bi bi-check-circle"></i> Complete
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#noteModal1">
                                            <i class="bi bi-chat-text"></i> View Note
                                        </button>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-warning" onclick="editTask(1)">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-sm btn-danger" onclick="deleteTask(1)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                
                                <!-- Sample Row 2 -->
                                <tr>
                                    <td>2</td>
                                    <td>
                                        <i class="bi bi-person-circle"></i> Sarah Johnson
                                        <small class="text-muted d-block">sarah@example.com</small>
                                    </td>
                                    <td>Update documentation</td>
                                    <td>2024-01-20</td>
                                    <td>
                                        <span class="badge bg-warning text-dark">
                                            <i class="bi bi-hourglass-split"></i> In Progress
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#noteModal2">
                                            <i class="bi bi-chat-text"></i> View Note
                                        </button>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-warning" onclick="editTask(2)">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-sm btn-danger" onclick="deleteTask(2)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                
                                <!-- Sample Row 3 -->
                                <tr>
                                    <td>3</td>
                                    <td>
                                        <i class="bi bi-person-circle"></i> Mike Chen
                                        <small class="text-muted d-block">mike@example.com</small>
                                    </td>
                                    <td>Database optimization</td>
                                    <td>2024-01-18</td>
                                    <td>
                                        <span class="badge bg-success">
                                            <i class="bi bi-check-circle"></i> Complete
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#noteModal3">
                                            <i class="bi bi-chat-text"></i> View Note
                                        </button>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-warning" onclick="editTask(3)">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-sm btn-danger" onclick="deleteTask(3)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                
                                <!-- Sample Row 4 (Pending) -->
                                <tr class="table-warning">
                                    <td>4</td>
                                    <td>
                                        <i class="bi bi-person-circle"></i> Emily Davis
                                        <small class="text-muted d-block">emily@example.com</small>
                                    </td>
                                    <td>Design new UI</td>
                                    <td>2024-01-25</td>
                                    <td>
                                        <span class="badge bg-danger">
                                            <i class="bi bi-x-circle"></i> Pending
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#noteModal4">
                                            <i class="bi bi-chat-text"></i> View Note
                                        </button>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-warning" onclick="editTask(4)">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-sm btn-danger" onclick="deleteTask(4)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
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
        
        <!-- Add Task Form Modal -->
        <div class="modal fade" id="addTaskModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Add New Task</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="addTaskForm">
                            <div class="mb-3">
                                <label class="form-label">Employee Name</label>
                                <select class="form-select" required>
                                    <option>Select employee...</option>
                                    <option>John Smith</option>
                                    <option>Sarah Johnson</option>
                                    <option>Mike Chen</option>
                                    <option>Emily Davis</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Task Name</label>
                                <input type="text" class="form-control" placeholder="Enter task name" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Due Date</label>
                                <input type="date" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Status</label>
                                <select class="form-select" required>
                                    <option>Pending</option>
                                    <option>In Progress</option>
                                    <option>Complete</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Notes</label>
                                <textarea class="form-control" rows="3" placeholder="Add task notes..."></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" onclick="saveTask()">Save Task</button>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
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
        
    </body>
</html>