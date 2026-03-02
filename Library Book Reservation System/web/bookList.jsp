<%-- 
    Document   : bookList
    Created on : Apr 11, 2025, 2:28:34 PM
    Author     : ishanavishka
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Search Results</title>
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
        h1, h2 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .reserve-btn {
            display: inline-block;
            padding: 8px 12px;
            background: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .status-available {
            color: green;
            font-weight: bold;
        }
        .status-reserved {
            color: red;
            font-weight: bold;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #2196F3;
            text-decoration: none;
        }
        .no-books {
            text-align: center;
            padding: 20px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Book Search Results</h1>
        
        <c:if test="${not empty searchTitle}">
            <h2>Search results for: "${searchTitle}"</h2>
        </c:if>
        
        <c:choose>
            <c:when test="${empty bookList}">
                <div class="no-books">
                    <p>No books found. Please try a different search term.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="book" items="${bookList}">
                            <tr>
                                <td>${book.title}</td>
                                <td>${book.author}</td>
                                <td class="${book.status == 'Available' ? 'status-available' : 'status-reserved'}">
                                    ${book.status}
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${book.status == 'Available'}">
                                            <a href="reserve?bookId=${book.id}" class="reserve-btn">Reserve</a>
                                        </c:when>
                                        <c:otherwise>
                                            Not Available
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
        
        <a href="searchBook.jsp" class="back-link">Back to Search</a>
    </div>
</body>
</html>
