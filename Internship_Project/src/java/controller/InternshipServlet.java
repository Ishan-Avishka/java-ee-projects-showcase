package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.InternshipDAO;
import model.Internship;

@WebServlet("/internship")
public class InternshipServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            createInternship(request, response);
        } else if ("update".equals(action)) {
            updateInternship(request, response);
        } else if ("delete".equals(action)) {
            deleteInternship(request, response);
        } else {
            response.sendRedirect("dashboardCompany.jsp");
        }
    }
    
    private void createInternship(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int companyId = (int) session.getAttribute("userId");
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String deadlineStr = request.getParameter("deadline");
        
        if (title == null || title.isEmpty() || description == null || description.isEmpty() ||
            deadlineStr == null || deadlineStr.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("postInternship.jsp").forward(request, response);
            return;
        }
        
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date deadline = sdf.parse(deadlineStr);
            
            Internship internship = new Internship();
            internship.setTitle(title);
            internship.setDescription(description);
            internship.setCompanyId(companyId);
            internship.setDeadline(deadline);
            
            InternshipDAO internshipDAO = new InternshipDAO();
            boolean success = internshipDAO.createInternship(internship);
            
            if (success) {
                request.setAttribute("message", "Internship posted successfully!");
            } else {
                request.setAttribute("error", "Failed to post internship");
            }
            
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format");
        }
        
        request.getRequestDispatcher("dashboardCompany.jsp").forward(request, response);
    }
    
    private void updateInternship(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int companyId = (int) session.getAttribute("userId");
        
        String idStr = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String deadlineStr = request.getParameter("deadline");
        
        if (idStr == null || idStr.isEmpty() || title == null || title.isEmpty() || 
            description == null || description.isEmpty() || deadlineStr == null || deadlineStr.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("dashboardCompany.jsp").forward(request, response);
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date deadline = sdf.parse(deadlineStr);
            
            Internship internship = new Internship();
            internship.setId(id);
            internship.setTitle(title);
            internship.setDescription(description);
            internship.setCompanyId(companyId);
            internship.setDeadline(deadline);
            
            InternshipDAO internshipDAO = new InternshipDAO();
            boolean success = internshipDAO.updateInternship(internship);
            
            if (success) {
                request.setAttribute("message", "Internship updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update internship");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid internship ID");
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format");
        }
        
        request.getRequestDispatcher("dashboardCompany.jsp").forward(request, response);
    }
    
    private void deleteInternship(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int companyId = (int) session.getAttribute("userId");
        
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.isEmpty()) {
            request.setAttribute("error", "Internship ID is required");
            request.getRequestDispatcher("dashboardCompany.jsp").forward(request, response);
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            
            InternshipDAO internshipDAO = new InternshipDAO();
            boolean success = internshipDAO.deleteInternship(id, companyId);
            
            if (success) {
                request.setAttribute("message", "Internship deleted successfully!");
            } else {
                request.setAttribute("error", "Failed to delete internship");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid internship ID");
        }
        
        request.getRequestDispatcher("dashboardCompany.jsp").forward(request, response);
    }
}