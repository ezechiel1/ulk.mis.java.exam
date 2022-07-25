<%-- 
    Document   : mentorController
    Created on : Jan 15, 2020, 5:08:44 PM
    Author     : Ezpk
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
String tableName="ibm_mentor";

//Insert New Admin
if(request.getParameter("validate").equals("Register"))
{
    String f_name=request.getParameter("fname");
    String l_name=request.getParameter("lname");
    String emailAdress=request.getParameter("email");
    String telephone=request.getParameter("phone");
    String address=request.getParameter("address");
    String qualification=request.getParameter("qualification");
    String password=f_name+"@2020";
    int admin_id=(Integer)session.getAttribute("admin_id");
    
    Map Datas=new HashMap();
    Datas.put("fname",f_name);
    Datas.put("lname", l_name);
    Datas.put("email", emailAdress);
    Datas.put("phone", telephone);
    Datas.put("address",address);
    Datas.put("qualification",qualification);
    Datas.put("status", 1);
    Datas.put("password", password);
    Datas.put("registered_by",admin_id);
    Datas.put("c_date", cDatetime);
    
    if(Db.insert(tableName, Datas))
    { 
        session.setAttribute("notification_status","Success");
        session.setAttribute("notification_msg","New Mentor Account has been created successfully!");
    %>
        <script>window.location.href="http://localhost:8080/ibm/admin/execute.jsp?request=training_mentor"; </script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:8080/ibm/admin/execute.jsp?request=training_mentor";</script>
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
    String qualification=request.getParameter("qualification");
    int key=Integer.parseInt(request.getParameter("ID"));

    Map Condition=new HashMap();
    Condition.put("id", key);

    Map Datas=new HashMap();
    Datas.put("fname",f_name);
    Datas.put("lname", l_name);
    Datas.put("email", emailAdress);
    Datas.put("phone", telephone);
    Datas.put("address",address);
    Datas.put("qualification", qualification);
    
    if(Db.update(tableName, Datas, Condition))
    { 
        session.setAttribute("notification_status","Success");
        session.setAttribute("notification_msg","Mentor Account has been updated successfully!");
      %>
        <script>window.location.href="http://localhost:8080/ibm/admin/execute.jsp?request=training_mentor"; </script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:8080/ibm/admin/execute.jsp?request=training_mentor";</script>
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
        session.setAttribute("notification_msg","Mentor Account has been deleted successfully!");
      %>
        <script>window.location.href="http://localhost:8080/ibm/admin/execute.jsp?request=training_mentor";</script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:8080/ibm/admin/execute.jsp?request=training_mentor";</script>
      <%  
    } 
}
%>