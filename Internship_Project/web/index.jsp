<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Internship Management System</title>
    <style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f5f7fa;
    color: #333;
    line-height: 1.6;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 600px;
    margin: 80px auto;
    padding: 40px;
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
    text-align: center;
}

h1 {
    margin-bottom: 25px;
    font-size: 2em;
    color: #0062cc;
}

p {
    margin-bottom: 20px;
    color: #555;
}

.center-box {
    margin-top: 20px;
    font-size: 1em;
    color: #555;
}

.button,
button {
    background-color: #1976d2;
    color: #fff;
    padding: 14px 28px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 17px;
    text-align: center;
    text-decoration: none;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    transition: background-color 0.3s ease, transform 0.2s ease;
    min-width: 120px;
    display: inline-block;
    font-weight: 600;
}

.button:hover,
button:hover {
    background-color: #005bb5;
    transform: translateY(-2px);
}

.button-group {
    margin-top: 30px;
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 20px;
}

.success-message,
.error-message {
    padding: 12px 15px;
    border-radius: 6px;
    margin-bottom: 20px;
    font-weight: 500;
    text-align: left;
}

.success-message {
    background-color: #d4edda;
    color: #155724;
    border-left: 4px solid #28a745;
}

.error-message {
    background-color: #f8d7da;
    color: #721c24;
    border-left: 4px solid #dc3545;
}

.form-container {
    text-align: left;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 500;
    color: #444;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 1em;
    background-color: #f9f9f9;
}

.form-group input:focus,
.form-group select:focus {
    outline: none;
    border-color: #0062cc;
    box-shadow: 0 0 0 3px rgba(0, 98, 204, 0.2);
}

.center-box a {
    color: #0062cc;
    text-decoration: none;
    font-weight: 500;
}

.center-box a:hover {
    text-decoration: underline;
}

@media screen and (max-width: 480px) {
    .container {
        margin: 30px 15px;
        padding: 20px;
    }

    .button {
        width: 100%;
        min-width: auto;
    }

    .button-group {
        flex-direction: column;
        gap: 15px;
    }
}

</style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Student Internship Management System</h1>
        <div class="center-box">
            <p>This system helps students find internships and companies to manage their internship programs.</p>
            <div class="button-group">
                <a href="login.jsp" class="button">Login</a>
                <a href="registerStudent.jsp" class="button">Register</a>
            </div>
        </div>
    </div>
</body>
</html>