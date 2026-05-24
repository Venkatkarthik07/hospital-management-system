<%@ page import="java.sql.*" %>

<%
String admin = (String) session.getAttribute("admin");
String role = (String) session.getAttribute("role");

if(admin == null || !role.equals("PHARMACY_ADMIN")){
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Pharmacy Dashboard</title>
<link rel="stylesheet" href="css/pharmacy.css">
</head>

<body>

<div class="navbar">
    Welcome Pharmacy Admin: <%= admin %>
    <a href="AdminServlet?action=logout" style="color:white;">Logout</a>
</div>

<h2>Add Medicine</h2>

<form action="PharmacyServlet" method="post" class="form">

<input type="text" name="name" placeholder="Medicine Name" required>
<input type="text" name="company" placeholder="Company" required>
<input type="number" step="0.01" name="price" placeholder="Price" required>
<input type="number" name="stock" placeholder="Stock" required>

<button type="submit" name="action" value="add">Add Medicine</button>

</form>

<h2>Medicine Inventory</h2>

<table>
<tr>
<th>ID</th>
<th>Name</th>
<th>Company</th>
<th>Price</th>
<th>Stock</th>
<th>Action</th>
</tr>

<%
Connection conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hospital_db","root","Vasanth@15591");

PreparedStatement ps = conn.prepareStatement("SELECT * FROM medicine");
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%= rs.getInt("med_id") %></td>
<td><%= rs.getString("med_name") %></td>
<td><%= rs.getString("company") %></td>
<td><%= rs.getDouble("price") %></td>
<td><%= rs.getInt("stock") %></td>

<td>
<form action="PharmacyServlet" method="post">
<input type="hidden" name="deleteId" value="<%= rs.getInt("med_id") %>">
<button class="delete">Delete</button>
</form>
</td>

</tr>

<% } %>

</table>

</body>
</html>
