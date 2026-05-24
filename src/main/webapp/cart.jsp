<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<%
String user = (String) session.getAttribute("username");
if(user == null){
    response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Your Cart</title>
<link rel="stylesheet" href="css/cart.css">
</head>

<body>

<h2 style="text-align:center;">Your Shopping Cart</h2>

<table>

<tr>
<th>Medicine</th>
<th>Price</th>
<th>Quantity</th>
<th>Total</th>
<th>Action</th>
</tr>

<%
Connection conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/hospital_db","root","Vasanth@15591");

PreparedStatement ps = conn.prepareStatement(
"SELECT c.cart_id,m.med_name,m.price,c.quantity " +
"FROM cart c JOIN medicine m ON c.med_id=m.med_id WHERE username=?");

ps.setString(1,user);
ResultSet rs = ps.executeQuery();

double grandTotal = 0;

while(rs.next()){
double total = rs.getDouble("price") * rs.getInt("quantity");
grandTotal += total;
%>

<tr>
<td><%= rs.getString("med_name") %></td>
<td>₹ <%= rs.getDouble("price") %></td>
<td><%= rs.getInt("quantity") %></td>
<td>₹ <%= total %></td>

<td>
<form action="CartServlet" method="post">
<input type="hidden" name="deleteId" value="<%= rs.getInt("cart_id") %>">
<button class="delete">Remove</button>
</form>
</td>

</tr>

<% } %>

<tr>
<td colspan="3"><b>Grand Total</b></td>
<td colspan="2"><b>₹ <%= grandTotal %></b></td>
</tr>

</table>

<a href="shop.jsp" class="btn">Continue Shopping</a>
<a href="checkout.jsp" class="btn">Proceed to Checkout</a>
</body>
</html>
