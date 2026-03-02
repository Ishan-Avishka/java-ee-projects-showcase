/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;


import dao.BookDAO;
import model.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    
    public void init() {
        bookDAO = new BookDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Book> allBooks = bookDAO.getAllBooks();
        request.setAttribute("bookList", allBooks);
        request.getRequestDispatcher("bookList.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
      
        String title = request.getParameter("title");
        
        
        if (title == null || title.trim().isEmpty()) {
           
            doGet(request, response);
            return;
        }
        
      
        List<Book> bookList = bookDAO.searchBooks(title);
  
        request.setAttribute("bookList", bookList);
        request.setAttribute("searchTitle", title);
        request.getRequestDispatcher("bookList.jsp").forward(request, response);
    }
}

