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

//DateFormat datetimeFormat = new SimpleDateFormat("yyyyMMddHHmmss");
//Date datetimestamp = new Date();
String timestamp=new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

//Table Name
String tableName="bank_account_transaction_cashin";

//Insert New Customer Account
if(request.getParameter("validate").equals("Register"))
{
    
    double transaction_amount = Double.parseDouble(request.getParameter("transaction_amount"));
    String account_number     = request.getParameter("account_number");
    
    int admin_id=1;//(Integer)session.getAttribute("admin_id");
   
    // Check If Customer NUmber Exists
    Map WhereCNB = new HashMap();
    WhereCNB.put("account_number", account_number);
    Map Condition_3 = new HashMap();
    Condition_3.put("where", WhereCNB);
    ResultSet resultCheckIfAccountNumberExists = Db.getrows("bank_customers_accounts", Condition_3);
    
    // If Account Holder At Account Order Number Exists 
    if( transaction_amount < 100 || transaction_amount > 1000000)
    {
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg", "Minimum amount is RWF 100 and Maximum Amount is 1,000,000");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_transactions_in";</script>
      <% 
    }
    // If Account  Number Exists 
    else if(resultCheckIfAccountNumberExists.next())
    {
        // Auto generate transaction Id 
        String transaction_id = "IBM_TrX_IN_00" + timestamp;
        // Data Transaction To Recored
        Map Datas=new HashMap();
        Datas.put("account_number", account_number);
        Datas.put("transaction_id",transaction_id);
        Datas.put("amount", transaction_amount);
        Datas.put("transaction_status", "ACTIVE");
        Datas.put("transaction_datetime", cDatetime);

        if(Db.insert(tableName, Datas))
        { 
            // Get Account Balance
            int accountID = resultCheckIfAccountNumberExists.getInt("id");
            double previous_balance = resultCheckIfAccountNumberExists.getDouble("account_balance");
            double new_balane = previous_balance + transaction_amount; 

            // Update New Balance
            Map Condition = new HashMap();
            Condition.put("id", accountID);

            Map DataBalance = new HashMap();
            DataBalance.put("account_balance", new_balane);

            if(Db.update("bank_customers_accounts", DataBalance, Condition))
            { 
                session.setAttribute("notification_status","Success");
                session.setAttribute("notification_msg","New Customer Bank Account Transaction Cash In has been recorded successfully!");
                %>
                  <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_transactions_in"; </script>
                <%  
            }
            else 
            { 
                session.setAttribute("notification_status","Error");
                session.setAttribute("notification_msg","Some errors occured. Please try again later!");
                %>
                  <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_transactions_in";</script>
                <%  
            } 
            

          %>
            <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_transactions_in"; </script>
          <%  
        }
        else { 
               session.setAttribute("notification_status","Error");
               session.setAttribute("notification_msg","Some errors occured. try again later!");
             %>
               <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_transactions_in";</script>
             <%  
        } 
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Account number not found");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_transactions_in";</script>
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
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_transactions_in"; </script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_transactions_in";</script>
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
        session.setAttribute("notification_msg","Bank Transaction Cash In has been deleted successfully!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_transactions_in";</script>
      <%  
    }
    else 
    { 
        session.setAttribute("notification_status","Error");
        session.setAttribute("notification_msg","Some errors occured. Please try again later!");
      %>
        <script>window.location.href="http://localhost:81/ibm/admin/execute.jsp?request=bank_transactions_in";</script>
      <%  
    } 
}
%>