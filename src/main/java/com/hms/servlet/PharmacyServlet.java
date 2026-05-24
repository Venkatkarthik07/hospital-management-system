package com.hms.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class PharmacyServlet extends HttpServlet {

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

            // ADD MEDICINE
            if("add".equals(req.getParameter("action"))){

                PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO medicine(med_name,company,price,stock) VALUES(?,?,?,?)");

                ps.setString(1, req.getParameter("name"));
                ps.setString(2, req.getParameter("company"));
                ps.setDouble(3, Double.parseDouble(req.getParameter("price")));
                ps.setInt(4, Integer.parseInt(req.getParameter("stock")));

                ps.executeUpdate();
                res.sendRedirect("pharmacyDashboard.jsp");
            }

            // DELETE MEDICINE
            else if(req.getParameter("deleteId") != null){

                PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM medicine WHERE med_id=?");

                ps.setInt(1, Integer.parseInt(req.getParameter("deleteId")));
                ps.executeUpdate();

                res.sendRedirect("pharmacyDashboard.jsp");
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
