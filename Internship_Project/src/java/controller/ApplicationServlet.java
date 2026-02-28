package controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ApplicationDAO;
import model.Application;

@WebServlet("/application")
public class ApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("apply".equals(action)) {
            applyInternship(request, response);
        } else if ("updateStatus".equals(action)) {
            updateApplicationStatus(request, response);
        } else {
            response.sendRedirect("dashboardStudent.jsp");
        }
    }
    
    private void applyInternship(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int studentId = (int) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");
        
        if (!"Student".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String internshipIdStr = request.getParameter("internshipId");
        
        if (internshipIdStr == null || internshipIdStr.isEmpty()) {
            request.setAttribute("error", "Internship ID is required");
            request.getRequestDispatcher("applyInternship.jsp").forward(request, response);
            return;
        }
        
        try {
            int internshipId = Integer.parseInt(internshipIdStr);
            
            ApplicationDAO applicationDAO = new ApplicationDAO();
            
            if (applicationDAO.hasApplied(studentId, internshipId)) {
                request.setAttribute("error", "You have already applied for this internship");
                request.getRequestDispatcher("applyInternship.jsp").forward(request, response);
                return;
            }
            
            Application application = new Application();
            application.setInternshipId(internshipId);
            application.setStudentId(studentId);
            application.setStatus("Pending");
            application.setApplyDate(new Date());
            
            boolean success = applicationDAO.createApplication(application);
            
            if (success) {
                request.setAttribute("message", "Application submitted successfully!");
            } else {
                request.setAttribute("error", "Failed to submit application");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid internship ID");
        }
        
        request.getRequestDispatcher("dashboardStudent.jsp").forward(request, response);
    }
    
    private void updateApplicationStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!"Admin".equals(role) && !"Company".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String applicationIdStr = request.getParameter("applicationId");
        String status = request.getParameter("status");
        
        if (applicationIdStr == null || applicationIdStr.isEmpty() || status == null || status.isEmpty()) {
            request.setAttribute("error", "Application ID and status are required");
            
            if ("Admin".equals(role)) {
                request.getRequestDispatcher("dashboardAdmin.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("dashboardCompany.jsp").forward(request, response);
            }
            
            return;
        }
        
        try {
            int applicationId = Integer.parseInt(applicationIdStr);
            
            ApplicationDAO applicationDAO = new ApplicationDAO();
            boolean success = applicationDAO.updateApplicationStatus(applicationId, status);
            
            if (success) {
                request.setAttribute("message", "Application status updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update application status");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid application ID");
        }
        
        if ("Admin".equals(role)) {
            request.getRequestDispatcher("dashboardAdmin.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("dashboardCompany.jsp").forward(request, response);
        }
    }
}