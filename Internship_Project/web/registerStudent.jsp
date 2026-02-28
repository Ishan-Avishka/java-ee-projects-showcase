<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - Internship Management System</title>
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
    max-width: 450px;
    margin: 60px auto;
    padding: 30px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    text-align: center;
}

h1 {
    margin-bottom: 25px;
    font-size: 1.8em;
    color: #0062cc;
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

.button {
    width: 100%;
    background-color: #0062cc;
    color: white;
    border: none;
    padding: 12px;
    border-radius: 5px;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.2s ease, transform 0.1s ease;
}

.button:hover {
    background-color: #004e9e;
    transform: translateY(-2px);
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

.center-box {
    margin-top: 20px;
    font-size: 0.95em;
    color: #555;
    text-align: center;
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
}
</style>
    <script src="js/validations.js"></script>
</head>
<body>
    <div class="container">
        <h1>Register</h1>
        
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <div class="form-container">
            <form action="register" method="post" onsubmit="return validateRegistration()">
                <div class="form-group">
                    <label for="name">Full Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                
                <div class="form-group">
                    <label>I am a:</label>
                    <select name="role" required>
                        <option value="Student">Student</option>
                        <option value="Company">Company</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="button">Register</button>
                </div>
            </form>
        </div>
        
        <div class="center-box">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
            <p><a href="index.jsp">Back to Home</a></p>
        </div>
    </div>
</body>
</html>