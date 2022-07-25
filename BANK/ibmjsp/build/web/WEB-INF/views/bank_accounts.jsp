 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="core.db"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
//Create Object Db
db Db=new db();
Db.GetDrive();
Connection connect= Db.getcon();
//Table Name
String tableName="bank_customers_accounts";

DateFormat datetimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
Date datetime = new Date();
String cDatetime=datetimeFormat.format(datetime);
DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
Date date = new Date();
String cDate=dateFormat.format(date);
%>       
<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
           
            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>
                        <button type="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#register"> <i class="fa fa-plus"></i> 
                            Register New Customer Bank Account
                        </button>
                    </h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    		
                    <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                      <thead>
                        <tr>
                          <th>No#.</th>
                          <th>Account Number</th>
                          <th>Account Holder</th>
                          <th>  Type</th>>
                          <th>  Order</th>
                          <th>Balance(RWF)</th>
                          <th>Email</th>
                          <th>Telephone</th>
                          <th>Action</th>
                        </tr>
                      </thead>
                      <tbody>
<%
Map Condition=new HashMap();
Condition.put("select", "id, account_number, account_holder, account_type, account_order_number, account_email, account_balance, account_telephone, creation_datetime");
ResultSet result=Db.getrows(tableName, Condition);
if(result.next()){ result.beforeFirst(); int count=0;
    while(result.next()){ count++;
        int key=result.getInt("id");
%>
                          <tr>
                              <td><%=count%></td>
                              <td><%=result.getString("account_number")%></td></td>
                              <td><%=result.getString("account_holder")%></td>
                              <td><%=result.getString("account_type")%></td>
                              <td><%=result.getInt("account_order_number")%></td>
                              <td><%=result.getDouble("account_balance")%></td>
                              <td><%=result.getString("account_email")%></td>
                              <td><%=result.getString("account_telephone")%></td>
                              <td><button type="button" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#delete<%=key%>ezpk"> <i class="fa fa-trash-o"></i> Delete </button>
                              <button type="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#update<%=key%>ezpk">
                                <i class="fa fa-edit"> </i> Update
                              </button></td>
                          </tr>
                          
                      <!--Modal-->
                  <div class="modal fade" id="delete<%=key%>ezpk" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                          </button>
                            <h4 class="modal-title" id="myModalLabel"> IBM Bank <span class="text-muted"> | Customer Bank Account</span></h4>
                        </div>
                          <form action="control/mentorController.jsp" method="post">
                        <div class="modal-body">
                            <center>
                                <p>Do you want to delete this Customer Bank Account : <%=result.getString("account_number")+" "+result.getString("account_holder")%> ?</p>
                            </center>
                        </div>
                        <div class="modal-footer">
                          <input type="number"  hidden name="ID" value="<%=key%>">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                          <input type="submit" class="btn btn-primary" name="validate" value="Delete">
                        </div>
                          </form>
                      </div>
                    </div>
                  </div>
                   
            <div class="modal fade" id="update<%=key%>ezpk" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                          </button>
                            <h4 class="modal-title" id="myModalLabel"> IBM Bank <span class="text-muted"> | Customer Bank Account</span></h4>
                        </div>
                <form action="control/mentorController.jsp" method="post">
                     <div class="modal-body">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Type <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <select  id="account_type" name="account_type" required="required" class="form-control col-md-7 col-xs-12">
                                <option hidden value="<%=result.getString("account_number")%>"><%=result.getString("account_number")%> Account</option>
                                <option value="Saving">Saving Account</option>
                                <option value="Current">Current Account</option>
                            </select>
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Order Number <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <select  id="account_order_number" name="account_order_number" required="required" class="form-control col-md-7 col-xs-12">
                                <option hidden value="<%=result.getString("account_order_number")%>">Account <%=result.getString("account_order_number")%></option>
                                <option value="1"> Account 01</option>
                                <option value="2"> Account 02</option>
                            </select>
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Number <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="account_number" name="account_number" value="<%=result.getString("account_number")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Holder <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="account_holder" name="account_holder" value="<%=result.getString("account_holder")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Email <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="email" id="account_email" name="account_email" value="<%=result.getString("account_email")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Telephone <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="account_telephone" name="account_telephone" value="<%=result.getString("account_telephone")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                     </div><br>
                        <div class="modal-footer">
                          <input type="number"  hidden name="ID" value="<%=key%>">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                          <input type="submit" class="btn btn-primary" name="validate" value="Update">
                        </div>
                          </form>
                      </div>
                    </div>
                  </div>
                      <!--End Modal-->
<%        
   }
}%>          
                      </tbody>
                    </table>
					
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->
       <!--Modals-->
                <div class="modal fade" id="register" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                          </button>
                            <h4 class="modal-title" id="myModalLabel"> IBM Bank <span class="text-muted"> | Customer Account</span></h4>
                        </div>
                   <form action="control/bankAccountController.jsp" method="post">
                     <div class="modal-body">
                       <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Type <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <select  id="account_type" name="account_type" required="required" class="form-control col-md-7 col-xs-12">
                                <option hidden value="">--[Select Account Type]--</option>
                                <option value="Saving">Saving Account</option>
                                <option value="Current">Current Account</option>
                            </select>
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Order Number <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <select  id="account_order_number" name="account_order_number" required="required" class="form-control col-md-7 col-xs-12">
                                <option hidden value="">--[Select Account Type]--</option>
                                <option value="1"> Account 01</option>
                                <option value="2"> Account 02</option>
                            </select>
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Number <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="account_number" name="account_number" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Holder <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="account_holder" name="account_holder" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Email <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="email" id="account_email" name="account_email" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Account Telephone <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="account_telephone" name="account_telephone" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                     </div><br>
                        <div class="modal-footer">
                          <input type="number"  hidden name="ID" value="">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                          <input type="submit" class="btn btn-primary" name="validate" value="Register">
                        </div>
                          </form>
                      </div>
                    </div>
                  </div>