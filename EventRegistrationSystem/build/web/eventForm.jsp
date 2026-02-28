<%-- 
    Document   : eventForm
    Created on : Apr 8, 2025, 11:54:55 AM
    Author     : ishanavishka
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        form {
            width: 400px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .footer {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Event Registration Form</h1>
    
    <form action="ParticipantServlet" method="post">
        <div>
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required/>
        </div>
        
        <div>
            <label for="email">Email:</label>
            <input type="text" id="email" name="email" required/>
        </div>
        
        <div>
            <label for="event">Event:</label>
            <input type="text" id="event" name="event" required/>
        </div>
        
        <div>
            <input type="submit" value="Register"/>
        </div>
    </form>
    
    <div class="footer">
        <a href="ParticipantServlet">View All Participants</a>
    </div>
</body>
</html>