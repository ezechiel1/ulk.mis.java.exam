<%-- 
    Document   : loginController
    Created on : Jun 26, 2022, 12:51:03 PM
    Author     : Ir.Ezechiel Kalengya - ezechielkalengya@gmail.com
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="core.db"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
//Create Object Db
db Db=new db();
Db.GetDrive();
Connection connect= Db.getcon();

//Table Name
String tableName="bank_admin";

if(request.getParameter("action").equals("signin"))
{
    String email=request.getParameter("email");
    String password=request.getParameter("password");
    
    Map Where=new HashMap();
    Where.put("email", email);
    Where.put("password", password);
    
    Map Condition=new HashMap();
    Condition.put("where", Where);
    
    ResultSet result=Db.getrows(tableName, Condition);
    
    //iF Information valid
    if(result.next())
    {
        int adminID=result.getInt("id");
        String adminNames=result.getString("fname")+ " "+ result.getString("lname"); 
        //Put value id in session
        session.setAttribute("admin_id", adminID);
        session.setAttribute("admin_names", adminNames);
        session.setAttribute("notification_status","Success");
        session.setAttribute("notification_msg","Hello Ezpk");
        //redirect url
        %>
        <script> window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=dashboard";</script>
        <%
    }
    else
    {
        %>
        <script>
            alert("Invalid Email or Password. Please enter correct information!");
            window.location.href="http://localhost:81/ibm/admin/index.jsp";
        </script>
      <%  
    }
}
%>
