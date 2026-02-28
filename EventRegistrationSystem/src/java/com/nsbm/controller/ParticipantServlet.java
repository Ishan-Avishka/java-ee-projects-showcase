/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.nsbm.controller;

import com.nsbm.dao.ParticipantDAO;
import com.nsbm.model.Participant;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ParticipantServlet")
public class ParticipantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ParticipantDAO participantDAO;
    
    public void init() {
        participantDAO = new ParticipantDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String event = request.getParameter("event");
        
        
        Participant newParticipant = new Participant(name, email, event);
        
      
        participantDAO.insertParticipant(newParticipant);
        
     
        response.sendRedirect("ParticipantServlet");
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
       
        List<Participant> participantList = participantDAO.listParticipants();
        
        
        request.setAttribute("participantList", participantList);
        
       
        RequestDispatcher dispatcher = request.getRequestDispatcher("participantList.jsp");
        dispatcher.forward(request, response);
    }
}