package com.hms.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class PaymentServlet extends HttpServlet {

    Connection conn;

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital_db",
                "root","Vasanth@15591");
        } catch(Exception e){
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));

            PreparedStatement ps = conn.prepareStatement(
                "UPDATE orders SET payment_status='SUCCESS' WHERE order_id=?");

            ps.setInt(1, orderId);
            ps.executeUpdate();

            res.getWriter().println("<script>alert('Payment Successful!'); window.location='shop.jsp';</script>");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
