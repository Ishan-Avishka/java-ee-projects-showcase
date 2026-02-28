package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        if (name == null || name.isEmpty() || email == null || email.isEmpty() || 
            password == null || password.isEmpty() || role == null || role.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("registerStudent.jsp").forward(request, response);
            return;
        }
        
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);  
        user.setRole(role);
        
        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.registerUser(user);
        
        if (success) {
            request.setAttribute("message", "Registration successful! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("registerStudent.jsp").forward(request, response);
        }
    }
}