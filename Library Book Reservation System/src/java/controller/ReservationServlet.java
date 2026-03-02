/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookDAO;
import dao.ReservationDAO;
import model.Book;
import model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/reserve")
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;
    private BookDAO bookDAO;
    
    public void init() {
        reservationDAO = new ReservationDAO();
        bookDAO = new BookDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
     
        String bookIdStr = request.getParameter("bookId");
        
        if (bookIdStr != null && !bookIdStr.isEmpty()) {
            try {
                int bookId = Integer.parseInt(bookIdStr);
                Book book = bookDAO.getBookById(bookId);
                
                if (book != null) {
                    request.setAttribute("book", book);
                    request.getRequestDispatcher("reserveForm.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect("searchBook.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
       
        String bookIdStr = request.getParameter("bookId");
        String studentName = request.getParameter("studentName");
        String studentId = request.getParameter("studentId");
        
       
        if (bookIdStr == null || bookIdStr.isEmpty() || 
            studentName == null || studentName.trim().isEmpty() || 
            studentId == null || studentId.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All fields are required");
            request.getRequestDispatcher("reserveForm.jsp").forward(request, response);
            return;
        }
        
        try {
            int bookId = Integer.parseInt(bookIdStr);
            Book book = bookDAO.getBookById(bookId);
            
            if (book != null && "Available".equals(book.getStatus())) {
                
                Reservation reservation = new Reservation();
                reservation.setBookId(bookId);
                reservation.setStudentName(studentName);
                reservation.setStudentId(studentId);
                
              
                boolean reservationCreated = reservationDAO.reserveBook(reservation);
                boolean statusUpdated = bookDAO.updateBookStatus(bookId, "Reserved");
                
                if (reservationCreated && statusUpdated) {
                    
                    request.setAttribute("reservation", reservation);
                    request.setAttribute("book", book);
                    request.getRequestDispatcher("success.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "Book is not available for reservation");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid book ID");
        }
    
        request.getRequestDispatcher("reserveForm.jsp").forward(request, response);
    }
}