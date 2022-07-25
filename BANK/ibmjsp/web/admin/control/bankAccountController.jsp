<%-- 
    Document   : bankAccountController
    Created on : Jun 26, 2022, 12:51:03 PM
    Author     : Ir.Ezechiel Kalengya - ezechielkalengya@gmail.com
--%>
<%@page import="java.sql.ResultSet"%>
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
DateFormat datetimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
Date datetime = new Date();
String cDatetime=datetimeFormat.format(datetime);
DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
Date date = new Date();
String cDate=dateFormat.format(date);

//Table Name
String tableName="bank_customers_accounts";

//Insert New Customer Account
if(request.getParameter("validate").equals("Register"))
{
    String account_holder=request.getParameter("account_holder");
    String account_type=request.getParameter("account_type");
    String account_email=request.getParameter("account_email");
    String account_telephone=request.getParameter("account_telephone");

    String account_number = request.getParameter("account_number");
    int admin_id=1;//(Integer)session.getAttribute("admin_id");
    
    int account_order_number = 1;
    if(account_type.equals("Current"))
        account_order_number = 2;
    
    Map Datas=new HashMap();
    Datas.put("account_number", account_number);
    Datas.put("account_holder",account_holder);
    Datas.put("account_type", account_type);
    Datas.put("account_order_number", account_order_number);
    Datas.put("account_email", account_email);
    Datas.put("account_telephone",account_telephone);
    Datas.put("creation_datetime", cDatetime);
    
    // Check If Customer Name Alreay Used And Account Order Number Is Same
    Map WhereCN_AON =new HashMap();
    WhereCN_AON.put("account_holder", account_holder);
    WhereCN_AON.put("account_order_number", account_order_number);
    Map Condition_1 = new HashMap();
    Condition_1.put("where", WhereCN_AON);
    ResultSet resultCheckIfAccountHolderAndOrderNumberExists = Db.getrows(tableName, Condition_1);
    
    // Check If Customer Name Alreay Used And Account Type Is Same
    Map WhereCN_AT =new HashMap();
    WhereCN_AT.put("account_holder", account_holder);
    WhereCN_AT.put("account_type", account_type);
    Map Condition_2 = new HashMap();
    Condition_2.put("where", WhereCN_AT);
    ResultSet resultCheckIfAccountHolderAndTypeExists = Db.getrows(tableName, Condition_2);
    
    // Check If Customer NUmber Exists
    Map WhereCNB = new HashMap();
    WhereCNB.put("account_number", account_number);
    Map Condition_3 = new HashMap();
    Condition_3.put("where", WhereCNB);
    ResultSet resultCheckIfAccountNumberExists = Db.getrows(tableName, Condition_3);
    
    // If Account Holder At Account Order Number Exists 
    if(resultCheckIfAccountHolderAndOrderNumberExists.next())
    {
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","This Account Holder With Account Order Number exists." + account_holder + " - " + account_order_number);
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_accounts";</script>
      <% 
    }
    // If Account Holder At Account Type Number Exists 
    else if(resultCheckIfAccountHolderAndTypeExists.next())
    {
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","This Account Holder With Account Type exists.");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_accounts";</script>
      <% 
    }
    // If Account  Number Exists 
    else if(resultCheckIfAccountNumberExists.next())
    {
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","This Account Number exists.");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_accounts";</script>
      <% 
    }
    else if(Db.insert(tableName, Datas))
    { 
        session.setAttribute("notification_status","Success");
        session.setAttribute("notification_msg","New Customer Bank Account has been registered successfully!");
    %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_accounts"; </script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_accounts";</script>
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
    int training_program_id=Integer.parseInt(request.getParameter("training_program"));
    int key=Integer.parseInt(request.getParameter("ID"));

    Map Condition=new HashMap();
    Condition.put("id", key);

    Map Datas=new HashMap();
    Datas.put("training_program_id", training_program_id);
    Datas.put("fname",f_name);
    Datas.put("lname", l_name);
    Datas.put("email", emailAdress);
    Datas.put("phone", telephone);
    Datas.put("address",address);
    
    if(Db.update(tableName, Datas, Condition))
    { 
        session.setAttribute("notification_status","Success");
        session.setAttribute("notification_msg","Participant Information has been updated successfully!");
      %>
        <script>window.location.href="http://localhost:8080/ibm/admin/execute.jsp?request=training_participant"; </script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:8080/ibm/admin/execute.jsp?request=training_participant";</script>
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
        session.setAttribute("notification_msg","Participant has been deleted successfully!");
      %>
        <script>window.location.href="http://localhost:8080/ibm/admin/execute.jsp?request=training_participant";</script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:8080/ibm/admin/execute.jsp?request=training_participant";</script>
      <%  
    } 
}
%>