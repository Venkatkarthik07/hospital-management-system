package com.hms.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CartServlet extends HttpServlet {

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

            /* ADD TO CART */
            if(req.getParameter("medId") != null){

                int medId = Integer.parseInt(req.getParameter("medId"));
                int qty = Integer.parseInt(req.getParameter("qty"));

                PreparedStatement check = conn.prepareStatement(
                    "SELECT * FROM cart WHERE username=? AND med_id=?");

                check.setString(1, user);
                check.setInt(2, medId);

                ResultSet rs = check.executeQuery();

                if(rs.next()){
                    PreparedStatement update = conn.prepareStatement(
                        "UPDATE cart SET quantity=quantity+? WHERE username=? AND med_id=?");

                    update.setInt(1, qty);
                    update.setString(2, user);
                    update.setInt(3, medId);
                    update.executeUpdate();
                }
                else{
                    PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO cart(username,med_id,quantity) VALUES(?,?,?)");

                    ps.setString(1, user);
                    ps.setInt(2, medId);
                    ps.setInt(3, qty);
                    ps.executeUpdate();
                }

                res.sendRedirect("shop.jsp");
            }

            /* DELETE FROM CART */
            else if(req.getParameter("deleteId") != null){

                PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM cart WHERE cart_id=?");

                ps.setInt(1, Integer.parseInt(req.getParameter("deleteId")));
                ps.executeUpdate();

                res.sendRedirect("cart.jsp");
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
