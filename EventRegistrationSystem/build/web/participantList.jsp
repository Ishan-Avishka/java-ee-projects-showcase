<%-- 
    Document   : partcipantList
    Created on : Apr 8, 2025, 11:55:43 AM
    Author     : ishanavishka
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Participants List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        .footer {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Registered Participants</h1>
    
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Event</th>
        </tr>
        <c:forEach var="participant" items="${participantList}">
            <tr>
                <td>${participant.id}</td>
                <td>${participant.name}</td>
                <td>${participant.email}</td>
                <td>${participant.event}</td>
            </tr>
        </c:forEach>
    </table>
    
    <div class="footer">
        <a href="eventForm.jsp">Register New Participant</a>
    </div>
</body>
</html>
