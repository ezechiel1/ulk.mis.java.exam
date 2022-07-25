<%-- 
    Document   : dashboard
    Created on : Jun 26, 2022, 12:51:03 PM
    Author     : Ir.Ezechiel Kalengya - ezechielkalengya@gmail.com
--%>
<%
    if(session.getAttribute("admin_names") == null || session.getAttribute("admin_names") == "_INVALID_")
    {
        //redirect url
        %>
        <script> window.location.href="http://localhost:81/ibm/admin/";</script>
        <%
    }
%>
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
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>IBM Online Training MIS | </title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
    <!-- bootstrap-wysiwyg -->
    <link href="../vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="../vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- starrr -->
    <link href="../vendors/starrr/dist/starrr.css" rel="stylesheet">
    <!-- bootstrap-daterangepicker -->
    <link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    
    <!-- PNotify -->
    <link href="../vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="../vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="../vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
    <style>
        .modal-content {
            position: relative;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #999;
            border: 1px solid rgba(0,0,0,.2);
            border-radius: 0px;
            -webkit-box-shadow: 0 3px 9px rgba(0,0,0,.5);
            box-shadow: 0 3px 9px rgba(0,0,0,.5);
            outline: 0;
        }
    </style>
  </head>
<% if(session.getAttribute("notification_status") != null || session.getAttribute("notification_status") != "_INVALID_"  || session.getAttribute("notification_status") != ""){ 
        String pnotify="";
        String msg=(String)session.getAttribute("notification_msg");
        if(session.getAttribute("notification_status") == "Success"){ pnotify="success";
   
        
%>
  <body  onpageshow="new PNotify({
                                  title: 'Notification',
                                  text: '<%=msg%>',
                                  type: '<%=pnotify%>',
                                  styling: 'bootstrap3'
                              });"></button>
  </body>
  <% }
else if(session.getAttribute("notification_status") == "Error"){ pnotify="error";
        %>
  <body  onpageshow="new PNotify({
                                  title: 'Notification',
                                  text: '<%=msg%>',
                                  type: '<%=pnotify%>',
                                  styling: 'bootstrap3'
                              });"></button>
  </body>
  <% 
    }
}
%>
  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="" class="site_title"><i class="fa fa-paw"></i> <span>IBM Bank MIS</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="images/user.png" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome, </span>
                <h2><%= session.getAttribute("admin_names") %> </h2>
              </div>
            </div>
            <!-- /menu profile quick info -->
            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
                    <li><a href="execute.jsp?request=dashboard"><i class="fa fa-home"></i> Dashboard </a></li>
                  <li><a><i class="fa fa-users"></i> Administrators <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="execute.jsp?request=new_admin">Register Admin</a></li>
                      <li><a href="execute.jsp?request=list_admin">List Admin</a></li>
                    </ul>
                  </li>
                  <li>
                      <a href="execute.jsp?request=bank_accounts"><i class="fa fa-desktop"></i> Bank Accounts <span class=""></span></a>
                  </li>
                  <li>
                      <a href="execute.jsp?request=bank_transactions_in"><i class="fa fa-arrow-left"></i> Transactions In <span class=""></span></a>
                  </li>
                  <li>
                      <a href="execute.jsp?request=bank_transactions_out"><i class="fa fa-arrow-right"></i> Transactions Out <span class=""></span></a>
                  </li>
                  <li>
                      <a href="execute.jsp?request=settings"><i class="fa fa-cogs"></i> Settings </a>
                  </li>
                  <li><a href="views/signout.jsp"><i class="fa fa-power-off"></i>Sign out </a>
                    
                  </li>
                </ul>
              </div>
            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
                <a data-toggle="tooltip" data-placement="top" title="Settings" href="execute.jsp?request=settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout" href="views/signout.jsp">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="images/user.png" alt=""><%= session.getAttribute("admin_names") %>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
           
                    <li>
                      <a href="execute.jsp?request=settings">
                        <span class="badge bg-red pull-right">50%</span>
                        <span>Settings</span>
                      </a>
                    </li>
                    <!--<li><a href="javascript:;">Help</a></li>-->
                    <li><a href="views/signout.jsp"><i class="fa fa-power-off pull-right"></i> Sign Out</a></li>
                  </ul>
                </li>

                <li role="presentation" class="dropdown">
                  <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope-o"></i>
                    <span class="badge bg-green">0</span>
                  </a>
                  <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">

              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->
        
        <!-- Links Control-->
        <% if(request.getParameter("request").equals("")){%>
        <jsp:include page="views/dashboard.jsp"/>
        <%}%>
        <% if(request.getParameter("request").equals("dashboard")){%>
        <jsp:include page="views/dashboard.jsp"/>
        <%}%>
        <% if(request.getParameter("request").equals("new_admin")){%>
        <jsp:include page="views/new_admin.jsp"/>
        <%}%>
        <% if(request.getParameter("request").equals("list_admin")){%>
        <jsp:include page="views/list_admin.jsp"/>
        <%}%>
        <% if(request.getParameter("request").equals("bank_accounts")){%>
        <jsp:include page="views/bank_accounts.jsp"/>
        <%}%>
        <% if(request.getParameter("request").equals("bank_transactions_in")){%>
        <jsp:include page="views/bank_transaction_in.jsp"/>
        <%}%>
        <% if(request.getParameter("request").equals("bank_transactions_out")){%>
        <jsp:include page="views/bank_transaction_out.jsp"/>
        <%}%>
       
        
        <% if(request.getParameter("request").equals("settings")){%>
        <jsp:include page="views/settings.jsp"/>
        <%}%>
        <!--End Links Control-->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
            IBM Bank MIS - Powered  by <a href="mailto:ezechielkalengya@gmail.com">ezechielkalengya@gmail.com</a>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>
    <!-- Chart.js -->
    <script src="../vendors/Chart.js/dist/Chart.min.js"></script>
    <!-- iCheck -->
    <script src="../vendors/iCheck/icheck.min.js"></script>
    <!-- jQuery Tags Input -->
    <script src="../vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
    <!-- Switchery -->
    <script src="../vendors/switchery/dist/switchery.min.js"></script>
    <!-- jQuery Sparklines -->
    <script src="../vendors/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
    <!-- Flot -->
    <script src="../vendors/Flot/jquery.flot.js"></script>
    <script src="../vendors/Flot/jquery.flot.pie.js"></script>
    <script src="../vendors/Flot/jquery.flot.time.js"></script>
    <script src="../vendors/Flot/jquery.flot.stack.js"></script>
    <script src="../vendors/Flot/jquery.flot.resize.js"></script>
    <!-- Flot plugins -->
    <script src="../vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
    <script src="../vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
    <script src="../vendors/flot.curvedlines/curvedLines.js"></script>
    <!-- DateJS -->
    <script src="../vendors/DateJS/build/date.js"></script>
    
    <!-- bootstrap-daterangepicker -->
    <script src="../vendors/moment/min/moment.min.js"></script>
    <script src="../vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
       <!-- Datatables -->
    <script src="../vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="../vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
    <script src="../vendors/jszip/dist/jszip.min.js"></script>
    <script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="../vendors/pdfmake/build/vfs_fonts.js"></script>

    <!-- PNotify -->
    <script src="../vendors/pnotify/dist/pnotify.js"></script>
    <script src="../vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="../vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
  </body>
  <% session.setAttribute("notification_status","");%>
  <% session.setAttribute("notification_msg","");%>
</html>