<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Application" %>
<%@ page import="dao.ApplicationDAO" %>
<%@ page import="model.Internship" %>
<%@ page import="dao.InternshipDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard - Internship Management System</title>
    <style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f5f7fa;
    color: #333;
    line-height: 1.6;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    box-sizing: border-box;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: linear-gradient(135deg, #0062cc, #0097a7);
    color: white;
    padding: 15px 25px;
    border-radius: 8px;
    margin-bottom: 25px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.header h1 {
    margin: 0;
    font-weight: 600;
    letter-spacing: 0.5px;
}

.user-info {
    display: flex;
    align-items: center;
    gap: 15px;
}

.user-info p {
    margin: 0;
    font-weight: 500;
}

.button {
    background-color: #0062cc;
    color: white;
    border: none;
    padding: 10px 18px;
    border-radius: 5px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s, transform 0.1s;
    text-decoration: none;
    display: inline-block;
}

.button:hover {
    background-color: #004e9e;
    transform: translateY(-2px);
}

.button.small {
    padding: 8px 12px;
    font-size: 0.9em;
    background-color: rgba(255, 255, 255, 0.2);
}

.button.small:hover {
    background-color: rgba(255, 255, 255, 0.3);
}

.success-message, .error-message {
    padding: 12px 15px;
    border-radius: 6px;
    margin-bottom: 20px;
    font-weight: 500;
}

.success-message {
    background-color: #d4edda;
    color: #155724;
    border-left: 4px solid #28a745;
}

.error-message {
    background-color: #f8d7da;
    color: #721c24;
    border-left: 4px solid #dc3545;
}

.dashboard-sections {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 25px;
}

.section {
    background-color: white;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.section h2 {
    color: #0062cc;
    border-bottom: 2px solid #eaeaea;
    padding-bottom: 12px;
    margin-top: 0;
    margin-bottom: 20px;
    font-weight: 600;
}

.form-container {
    margin-top: 15px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 500;
    color: #444;
}

.form-group input, 
.form-group select {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 1em;
    color: #333;
    background-color: #f9f9f9;
}

.form-group input:focus, 
.form-group select:focus {
    outline: none;
    border-color: #0062cc;
    box-shadow: 0 0 0 3px rgba(0, 98, 204, 0.2);
}

.data-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    box-shadow: 0 1px 5px rgba(0, 0, 0, 0.05);
}

.data-table th,
.data-table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #eaeaea;
}

.data-table th {
    background-color: #f5f7fa;
    font-weight: 600;
    color: #444;
}

.data-table tr:last-child td {
    border-bottom: none;
}

.data-table tr:hover {
    background-color: #f9f9f9;
}

.status-pending {
    color: #f39c12;
    font-weight: 500;
}

.status-approved {
    color: #27ae60;
    font-weight: 500;
}

.status-rejected {
    color: #e74c3c;
    font-weight: 500;
}

@media screen and (max-width: 768px) {
    .header {
        flex-direction: column;
        text-align: center;
        gap: 10px;
    }
    
    .dashboard-sections {
        grid-template-columns: 1fr;
    }
    
    .data-table {
        display: block;
        overflow-x: auto;
    }
}
    </style>
</head>
<body>
    <%
        if (session.getAttribute("userId") == null || !"Student".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int studentId = (int) session.getAttribute("userId");
        String studentName = (String) session.getAttribute("name");
        
        ApplicationDAO applicationDAO = new ApplicationDAO();
        List<Application> applications = applicationDAO.getApplicationsByStudent(studentId);
        
        InternshipDAO internshipDAO = new InternshipDAO();
        List<Internship> internships = internshipDAO.getAllInternships();
    %>

    <div class="container">
        <div class="header">
            <h1>Student Dashboard</h1>
            <div class="user-info">
                <p>Welcome, <%= studentName %></p>
                <a href="logout" class="button small">Logout</a>
            </div>
        </div>
        
        <%-- Display messages if any --%>
        <% if (request.getAttribute("message") != null) { %>
            <div class="success-message">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <div class="dashboard-sections">
            <div class="section">
                <h2>Apply for Internship</h2>
                
                <div class="form-container">
                    <form action="application" method="post">
                        <input type="hidden" name="action" value="apply">
                        
                        <div class="form-group">
                            <label for="internshipId">Select Internship:</label>
                            <select id="internshipId" name="internshipId" required>
                                <option value="">-- Select an Internship --</option>
                                <% for (Internship internship : internships) { %>
                                    <option value="<%= internship.getId() %>">
                                        <%= internship.getTitle() %> - <%= internship.getCompanyName() %>
                                    </option>
                                <% } %>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <button type="submit" class="button">Apply</button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="section">
                <h2>My Applications</h2>
                
                <% if (applications.isEmpty()) { %>
                    <p>You haven't applied for any internships yet.</p>
                <% } else { %>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Internship Title</th>
                                <th>Company</th>
                                <th>Apply Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Application app : applications) { %>
                                <tr>
                                    <td><%= app.getInternshipTitle() %></td>
                                    <td><%= app.getCompanyName() %></td>
                                    <td><%= app.getApplyDate() %></td>
                                    <td class="status-<%= app.getStatus().toLowerCase() %>"><%= app.getStatus() %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>