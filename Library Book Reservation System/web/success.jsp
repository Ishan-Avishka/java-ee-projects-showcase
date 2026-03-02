<%-- 
    Document   : success
    Created on : Apr 11, 2025, 2:29:47 PM
    Author     : ishanavishka
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reservation Successful</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 {
            color: #4CAF50;
        }
        .success-icon {
            font-size: 64px;
            color: #4CAF50;
            margin-bottom: 20px;
        }
        .reservation-details {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 20px 0;
            text-align: left;
            border-radius: 4px;
        }
        .reservation-details p {
            margin: 10px 0;
        }
        .buttons {
            margin-top: 30px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 0 10px;
            background: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">✓</div>
        <h1>Reservation Successful!</h1>
        
        <div class="reservation-details">
            <p><strong>Book Title:</strong> ${book.title}</p>
            <p><strong>Author:</strong> ${book.author}</p>
            <p><strong>Reserved By:</strong> ${reservation.studentName}</p>
            <p><strong>Student ID:</strong> ${reservation.studentId}</p>
            <p><strong>Reservation Date:</strong> 
                <fmt:formatDate value="${reservation.reservationDate}" pattern="dd-MM-yyyy HH:mm:ss" />
            </p
