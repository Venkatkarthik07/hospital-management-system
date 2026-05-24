<%@ page language="java" %>

<!DOCTYPE html>
<html>
<head>
<title>Doctor Login</title>
<link rel="stylesheet" href="css/patientLogin.css">
</head>

<body>

<div class="container">
<h2>Doctor Login</h2>

<% if(request.getAttribute("error") != null){ %>
<div class="error"><%= request.getAttribute("error") %></div>
<% } %>

<form action="DoctorServlet" method="post">

<input type="text" name="username" placeholder="Username" required>
<input type="password" name="password" placeholder="Password" required>

<button type="submit">Login</button>

</form>
</div>

</body>
</html>
