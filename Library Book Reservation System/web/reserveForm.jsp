<%-- 
    Document   : reserveForm
    Created on : Apr 11, 2025, 2:29:09 PM
    Author     : ishanavishka
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reserve Book</title>
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
        }
        h1 {
            color: #333;
        }
        .book-info {
            background-color: #f9f9f9;
            padding: 15px;
            margin-bottom: 20px;
            border-left: 4px solid #4CAF50;
        }
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #2196F3;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Reserve Book</h1>
        
        <c:if test="${not empty book}">
            <div class="book-info">
                <h2>${book.title}</h2>
                <p><strong>Author:</strong> ${book.author}</p>
                <p><strong>Status:</strong> ${book.status}</p>
            </div>
            
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    ${errorMessage}
                </div>
            </c:if>
            
            <form action="reserve" method="post">
                <input type="hidden" name="bookId" value="${book.id}"/>
                
                <div>
                    <label for="studentName">Student Name:</label>
                    <input type="text" id="studentName" name="studentName" required/>
                </div>
                
                <div>
                    <label for="studentId">Student ID:</label>
                    <input type="text" id="studentId" name="studentId" required/>
                </div>
                
                <div>
                    <input type="submit" value="Reserve"/>
                </div>
            </form>
        </c:if>
        
        <a href="search" class="back-link">Back to Book List</a>
    </div>
</body>
</html>
