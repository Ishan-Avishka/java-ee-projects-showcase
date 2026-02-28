<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
     <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }
        
        .dashboard-container {
            display: grid;
            grid-template-areas:
                'header header'
                'nav main'
                'footer footer';
            grid-template-columns: 240px 1fr;
            grid-template-rows: auto 1fr auto;
            min-height: 100vh;
        }
        
        header {
            grid-area: header;
            background: linear-gradient(135deg, #2c3e50, #1a2634);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        header h1 {
            font-size: 1.8rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-info span {
            font-weight: 500;
        }
        
        .logout-btn {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9rem;
            transition: background-color 0.3s ease;
        }
        
        .logout-btn:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }
        
        nav {
            grid-area: nav;
            background-color: #ffffff;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
            padding: 2rem 0;
            position: sticky;
            top: 73px;
            height: calc(100vh - 73px);
            overflow-y: auto;
        }
        
        nav ul {
            list-style: none;
        }
        
        nav ul li {
            padding: 0.5rem 0;
        }
        
        nav ul li a {
            display: block;
            padding: 0.75rem 2rem;
            color: #445669;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }
        
        nav ul li a:hover {
            color: #3498db;
            background-color: #f0f5fa;
            border-left-color: #3498db;
        }
        
        main {
            grid-area: main;
            padding: 2rem;
            overflow-y: auto;
        }
        
        section {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        section h2 {
            color: #2c3e50;
            margin-bottom: 1.2rem;
            padding-bottom: 0.8rem;
            border-bottom: 1px solid #eaeaea;
            font-size: 1.5rem;
        }
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }
        
        .stat-box {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 1.5rem;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        
        .stat-box:hover {
            transform: translateY(-5px);
        }
        
        .stat-box:nth-child(2) {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
        }
        
        .stat-box:nth-child(3) {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
        }
        
        .stat-box:nth-child(4) {
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
        }
        
        .stat-box h3 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }
        
        .stat-box p {
            font-size: 1rem;
            opacity: 0.9;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            border-radius: 4px;
            overflow: hidden;
        }
        
        thead {
            background-color: #f8f9fa;
            color: #344767;
        }
        
        th {
            text-align: left;
            padding: 1rem;
            font-weight: 600;
            border-bottom: 2px solid #eaeaea;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        td {
            padding: 1rem;
            border-bottom: 1px solid #eaeaea;
            font-size: 0.95rem;
            color: #555;
        }
        
        tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .btn {
            padding: 0.5rem 0.8rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.8rem;
            font-weight: 500;
            transition: all 0.2s ease;
            margin-right: 0.3rem;
        }
        
        .approve-btn {
            background-color: #27ae60;
            color: white;
        }
        
        .approve-btn:hover {
            background-color: #2ecc71;
        }
        
        .reject-btn {
            background-color: #e74c3c;
            color: white;
        }
        
        .reject-btn:hover {
            background-color: #f86a5e;
        }
        
        footer {
            grid-area: footer;
            background-color: #2c3e50;
            color: white;
            padding: 1rem 2rem;
            text-align: center;
        }
        
        footer p {
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        @media (max-width: 992px) {
            .dashboard-container {
                grid-template-areas:
                    'header'
                    'nav'
                    'main'
                    'footer';
                grid-template-columns: 1fr;
            }
            
            nav {
                position: static;
                height: auto;
                box-shadow: none;
            }
            
            nav ul {
                display: flex;
                overflow-x: auto;
                padding: 0.5rem;
            }
            
            nav ul li {
                padding: 0;
                margin-right: 1rem;
            }
            
            nav ul li a {
                border-left: none;
                border-bottom: 3px solid transparent;
                padding: 0.75rem 1rem;
            }
            
            nav ul li a:hover {
                border-left-color: transparent;
                border-bottom-color: #3498db;
            }
            
            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            header {
                flex-direction: column;
                gap: 10px;
                padding: 1rem;
            }
            
            .user-info {
                width: 100%;
                justify-content: space-between;
            }
            
            table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
<%
    
    String userRole = (String) session.getAttribute("role");
    Integer userId = (Integer) session.getAttribute("userId");

    if (userId == null || !"Admin".equals(userRole)) {
        response.sendRedirect("login.jsp");
        return;
    }

    String adminName = (String) session.getAttribute("name");

    int totalStudents = 0;
    int totalCompanies = 0;
    int totalInternships = 0;
    int totalApplications = 0;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();

        String sql = "SELECT COUNT(*) as count FROM users WHERE role = 'Student'";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalStudents = rs.getInt("count");
        }
        rs.close();
        pstmt.close();

        sql = "SELECT COUNT(*) as count FROM users WHERE role = 'Company'";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalCompanies = rs.getInt("count");
        }
        rs.close();
        pstmt.close();

        sql = "SELECT COUNT(*) as count FROM internships";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalInternships = rs.getInt("count");
        }
        rs.close();
        pstmt.close();

        sql = "SELECT COUNT(*) as count FROM applications";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalApplications = rs.getInt("count");
        }
        rs.close();
        pstmt.close();

    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<div class="dashboard-container">
    <header>
        <h1>Admin Dashboard</h1>
        <div class="user-info">
            <span>Welcome, <%= adminName %></span>
            <a href="LogoutServlet" class="logout-btn">Logout</a>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="#dashboard">Dashboard</a></li>
            <li><a href="#students">Students</a></li>
            <li><a href="#companies">Companies</a></li>
            <li><a href="#internships">Internships</a></li>
            <li><a href="#applications">Applications</a></li>
        </ul>
    </nav>

    <main>
        <section id="dashboard">
            <h2>System Overview</h2>
            <div class="stats-container">
                <div class="stat-box">
                    <h3><%= totalStudents %></h3>
                    <p>Students</p>
                </div>
                <div class="stat-box">
                    <h3><%= totalCompanies %></h3>
                    <p>Companies</p>
                </div>
                <div class="stat-box">
                    <h3><%= totalInternships %></h3>
                    <p>Internships</p>
                </div>
                <div class="stat-box">
                    <h3><%= totalApplications %></h3>
                    <p>Applications</p>
                </div>
            </div>
        </section>

        <section id="students">
            <h2>Students</h2>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Registration Date</th>
                    <th>Applications</th>
                </tr>
                </thead>
                <tbody>
                <%
                try {
                    String sql = "SELECT u.user_id, u.name, u.email, u.registration_date, " +
                                 "(SELECT COUNT(*) FROM applications a WHERE a.student_id = u.user_id) as app_count " +
                                 "FROM users u WHERE u.role = 'Student' ORDER BY u.registration_date DESC";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    boolean hasStudents = false;
                    while (rs.next()) {
                        hasStudents = true;
                %>
                <tr>
                    <td><%= rs.getInt("user_id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("registration_date") %></td>
                    <td><%= rs.getInt("app_count") %></td>
                </tr>
                <%
                    }
                    if (!hasStudents) {
                %>
                <tr>
                    <td colspan="5">No students registered yet.</td>
                </tr>
                <%
                    }
                    rs.close();
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                %>
                </tbody>
            </table>
        </section>

        <section id="companies">
            <h2>Companies</h2>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Registration Date</th>
                    <th>Internships</th>
                </tr>
                </thead>
                <tbody>
                <%
                try {
                    String sql = "SELECT u.user_id, u.name, u.email, u.registration_date, " +
                                 "(SELECT COUNT(*) FROM internships i WHERE i.company_id = u.user_id) as int_count " +
                                 "FROM users u WHERE u.role = 'Company' ORDER BY u.registration_date DESC";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    boolean hasCompanies = false;
                    while (rs.next()) {
                        hasCompanies = true;
                %>
                <tr>
                    <td><%= rs.getInt("user_id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("registration_date") %></td>
                    <td><%= rs.getInt("int_count") %></td>
                </tr>
                <%
                    }
                    if (!hasCompanies) {
                %>
                <tr>
                    <td colspan="5">No companies registered yet.</td>
                </tr>
                <%
                    }
                    rs.close();
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                %>
                </tbody>
            </table>
        </section>

        <section id="applications">
            <h2>Recent Applications</h2>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Student</th>
                    <th>Internship</th>
                    <th>Company</th>
                    <th>Application Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                try {
                    String sql = "SELECT a.application_id, a.status, a.application_date, " +
                                 "s.name as student_name, i.title, c.name as company_name " +
                                 "FROM applications a " +
                                 "JOIN users s ON a.student_id = s.user_id " +
                                 "JOIN internships i ON a.internship_id = i.internship_id " +
                                 "JOIN users c ON i.company_id = c.user_id " +
                                 "ORDER BY a.application_date DESC LIMIT 20";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    boolean hasApps = false;
                    while (rs.next()) {
                        hasApps = true;
                        int applicationId = rs.getInt("application_id");
                        String student = rs.getString("student_name");
                        String internship = rs.getString("title");
                        String company = rs.getString("company_name");
                        String appDate = rs.getString("application_date");
                        String status = rs.getString("status");
                %>
                <tr>
                    <td><%= applicationId %></td>
                    <td><%= student %></td>
                    <td><%= internship %></td>
                    <td><%= company %></td>
                    <td><%= appDate %></td>
                    <td><%= status %></td>
                    <td>
                        <% if ("Pending".equals(status)) { %>
                        <form action="ApplicationServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="adminUpdateStatus">
                            <input type="hidden" name="applicationId" value="<%= applicationId %>">
                            <input type="hidden" name="status" value="Approved">
                            <input type="submit" value="Approve" class="btn approve-btn">
                        </form>
                        <form action="ApplicationServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="adminUpdateStatus">
                            <input type="hidden" name="applicationId" value="<%= applicationId %>">
                            <input type="hidden" name="status" value="Rejected">
                            <input type="submit" value="Reject" class="btn reject-btn">
                        </form>
                        <% } else { %>
                        <span>No actions available</span>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                    if (!hasApps) {
                %>
                <tr>
                    <td colspan="7">No applications found.</td>
                </tr>
                <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                %>
                </tbody>
            </table>
        </section>
    </main>

    <footer>
        <p>&copy; 2025 Student Internship Management System</p>
    </footer>
</div>
</body>
</html>
