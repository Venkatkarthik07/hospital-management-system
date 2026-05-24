package com.hms.servlet;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import javax.servlet.*;
import javax.servlet.http.*;

public class OrderServlet extends HttpServlet {

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

        String user = (String) req.getSession().getAttribute("username");

        try {

            /* SAVE ADDRESS */
            PreparedStatement addr = conn.prepareStatement(
                "INSERT INTO address(username,full_address,city,pincode) VALUES(?,?,?,?)");

            addr.setString(1,user);
            addr.setString(2, req.getParameter("address"));
            addr.setString(3, req.getParameter("city"));
            addr.setString(4, req.getParameter("pincode"));
            addr.executeUpdate();

            /* CALCULATE TOTAL */
            PreparedStatement totalPS = conn.prepareStatement(
                "SELECT SUM(m.price*c.quantity) FROM cart c JOIN medicine m ON c.med_id=m.med_id WHERE username=?");

            totalPS.setString(1,user);
            ResultSet rs = totalPS.executeQuery();
            rs.next();
            double total = rs.getDouble(1);

            /* INSERT ORDER */
            PreparedStatement order = conn.prepareStatement(
                "INSERT INTO orders(username,total,payment_method,order_date) VALUES(?,?,?,?)",
                Statement.RETURN_GENERATED_KEYS);

            order.setString(1,user);
            order.setDouble(2,total);
            order.setString(3, req.getParameter("payment"));
            order.setDate(4, Date.valueOf(LocalDate.now()));

            order.executeUpdate();

            ResultSet keys = order.getGeneratedKeys();
            keys.next();
            int orderId = keys.getInt(1);

            /* INSERT ORDER ITEMS */
            PreparedStatement cartPS = conn.prepareStatement(
                "SELECT * FROM cart WHERE username=?");

            cartPS.setString(1,user);
            ResultSet cart = cartPS.executeQuery();

            while(cart.next()){
                PreparedStatement item = conn.prepareStatement(
                    "INSERT INTO order_items(order_id,med_id,quantity) VALUES(?,?,?)");

                item.setInt(1, orderId);
                item.setInt(2, cart.getInt("med_id"));
                item.setInt(3, cart.getInt("quantity"));
                item.executeUpdate();
            }

            /* CLEAR CART */
            PreparedStatement clear = conn.prepareStatement(
                "DELETE FROM cart WHERE username=?");

            clear.setString(1,user);
            clear.executeUpdate();

            //res.getWriter().println("<script>alert('Order Placed Successfully'); window.location='shop.jsp';</script>");
            
            String payment = req.getParameter("payment");

            if(payment.equals("UPI")){
                req.getSession().setAttribute("orderId", orderId);
                req.getSession().setAttribute("amount", total);
                res.sendRedirect("upiPayment.jsp");
            } else {
                PreparedStatement status = conn.prepareStatement(
                    "UPDATE orders SET payment_status='SUCCESS' WHERE order_id=?");
                status.setInt(1, orderId);
                status.executeUpdate();

                res.getWriter().println("<script>alert('Order Placed Successfully'); window.location='shop.jsp';</script>");
            }


        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
