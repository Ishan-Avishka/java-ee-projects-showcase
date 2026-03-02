<%-- 
    Document   : searchBook
    Created on : Apr 11, 2025, 2:28:03 PM
    Author     : ishanavishka
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Book Reservation System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .search-form {
            display: flex;
            margin: 20px 0;
        }
        .search-form input[type="text"] {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
        }
        .search-form input[type="submit"] {
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
        }
        .view-all {
            text-align: center;
            margin-top: 20px;
        }
        .view-all a {
            display: inline-block;
            padding: 10px 20px;
            background: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Library Book Reservation System</h1>
        
        <div class="search-form">
            <form action="search" method="post">
                <input type="text" name="title" placeholder="Enter book title" required/>
                <input type="submit" value="Search"/>
            </form>
        </div>
        
        <div class="view-all">
            <a href="search">View All Books</a>
        </div>
    </div>
</body>
</html>