<%-- 
    Document   : adminController
    Created on : Jun 26, 2022, 12:51:03 PM
    Author     : Ir.Ezechiel Kalengya - ezechielkalengya@gmail.com
--%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="core.db"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
//Create Object Db
db Db=new db();
Db.GetDrive();
Connection connect= Db.getcon();
session.setAttribute("notification_status","Success");
session.setAttribute("notification_msg","Hello Ezpk");
DateFormat datetimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
Date datetime = new Date();
String cDatetime=datetimeFormat.format(datetime);
DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
Date date = new Date();
String cDate=dateFormat.format(date);

//Table Name
String tableName="bank_admin";

//Insert New Admin
if(request.getParameter("validate").equals("Register"))
{
    String f_name=request.getParameter("fname");
    String l_name=request.getParameter("lname");
    String emailAdress=request.getParameter("email");
    String telephone=request.getParameter("phone");
    String address=request.getParameter("address");
    String password=f_name+"@2020";
    
    Map Datas=new HashMap();
    Datas.put("fname",f_name);
    Datas.put("lname", l_name);
    Datas.put("email", emailAdress);
    Datas.put("phone", telephone);
    Datas.put("address",address);
    Datas.put("password", password);
    Datas.put("c_date", cDatetime);
    
    if(Db.insert(tableName, Datas))
    { 
        session.setAttribute("notification_status","Success");
        session.setAttribute("notification_msg","New Administrator Account has been created successfully!");
    %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=list_admin"; </script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=new_admin";</script>
      <%  
    } 
}
//Update 
else if(request.getParameter("validate").equals("Update"))
{
    String f_name=request.getParameter("fname");
    String l_name=request.getParameter("lname");
    String emailAdress=request.getParameter("email");
    String telephone=request.getParameter("phone");
    String address=request.getParameter("address");
    int key=Integer.parseInt(request.getParameter("ID"));

    Map Condition=new HashMap();
    Condition.put("id", key);

    Map Datas=new HashMap();
    Datas.put("fname",f_name);
    Datas.put("lname", l_name);
    Datas.put("email", emailAdress);
    Datas.put("phone", telephone);
    Datas.put("address",address);
    
    if(Db.update(tableName, Datas, Condition))
    { 
        session.setAttribute("notification_status","Success");
        session.setAttribute("notification_msg","Administrator Account has been updated successfully!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=list_admin"; </script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=list_admin";</script>
      <%  
    } 
}
//Delete 
else if(request.getParameter("validate").equals("Delete"))
{
    int key=Integer.parseInt(request.getParameter("ID"));

    Map Condition=new HashMap();
    Condition.put("id", key);
    
    if(Db.delete(tableName, Condition))
    { 
        session.setAttribute("notification_status","Success");
        session.setAttribute("notification_msg","Administrator Account has been deleted successfully!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=list_admin";</script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=list_admin";</script>
      <%  
    } 
}
//Save Profile 
else if(request.getParameter("validate").equals("Save"))
{
    String f_name=request.getParameter("fname");
    String l_name=request.getParameter("lname");
    String emailAdress=request.getParameter("email");
    String telephone=request.getParameter("phone");
    String address=request.getParameter("address");
    int key=(Integer)session.getAttribute("admin_id");

    Map Condition=new HashMap();
    Condition.put("id", key);

    Map Datas=new HashMap();
    Datas.put("fname",f_name);
    Datas.put("lname", l_name);
    Datas.put("email", emailAdress);
    Datas.put("phone", telephone);
    Datas.put("address",address);
    
    if(Db.update(tableName, Datas, Condition))
    { 
        session.setAttribute("notification_status","Success");
        session.setAttribute("notification_msg","Modoficaction has been saved successfully!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=settings"; </script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=settings";</script>
      <%  
    } 
}
//Change Password
else if(request.getParameter("validate").equals("Change"))
{
    String old_password=request.getParameter("old_password");
    String new_password=request.getParameter("new_password");
    String confirm_password=request.getParameter("confirm_password");
    int key=(Integer)session.getAttribute("admin_id");
    
    Map Condition=new HashMap();
    Condition.put("id", key);
    Map Datas=new HashMap();
    Datas.put("password", new_password);
    
    if(Db.update(tableName, Datas, Condition))
    { 
        session.setAttribute("notification_status","Success");
        session.setAttribute("notification_msg","Modoficaction has been saved successfully!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=settings"; </script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=settings";</script>
      <%  
    } 
}
%>