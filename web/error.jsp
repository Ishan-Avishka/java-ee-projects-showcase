<%-- 
    Document   : error
    Created on : Mar 30, 2025, 8:26:48 PM
    Author     : ishanavishka
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            text-align: center;
        }
        .error-container {
            width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #f44336;
            border-radius: 5px;
            background-color: #ffebee;
        }
        h1 {
            color: #d32f2f;
        }
        .message {
            margin: 20px 0;
            color: #333;
        }
        .home-link {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Error</h1>
        <div class="message">
            <p>${error}</p>
        </div>
        <div class="home-link">
            <a href="studentForm.jsp">Go to Home</a>
        </div>
    </div>
</body>
</html>
