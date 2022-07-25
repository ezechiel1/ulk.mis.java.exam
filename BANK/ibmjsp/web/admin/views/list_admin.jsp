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
%>
        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>List of Administrators </h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_content">
                    <div class="row">
                      <div class="clearfix"></div>
<%
Map Condition=new HashMap();
Map ConditionWhere=new HashMap();
ConditionWhere.put("id", 1);
Condition.put("select", "id, fname, lname, email, phone, address");
Condition.put("where", ConditionWhere);
ResultSet result=Db.getrows(tableName, Condition);
if(result.next()){ result.beforeFirst();
    while(result.next()){
        int key=result.getInt("id");
%>                     
                      <div class="col-md-4 col-sm-4 col-xs-12 profile_details">
                        <div class="well profile_view">
                          <div class="col-sm-12">
                            <h4 class="brief"><i> IBM Bank Administrator</i></h4>
                            <div class="left col-xs-7">
                                <h2> <%= result.getString("fname") + " " + result.getString("lname")%></h2>
                              <p><strong>E-mail Address :</strong> <%= result.getString("email")%></p>
                              <ul class="list-unstyled">
                                <li><i class="fa fa-building"></i> Address: <%= result.getString("address")%></li>
                                <li><i class="fa fa-phone"></i> Phone #: <%= result.getString("phone")%></li>
                              </ul>
                            </div>
                            <div class="right col-xs-5 text-center">
                              <img src="images/user.png" alt="" class="img-circle img-responsive">
                            </div>
                          </div>
                          <div class="col-xs-12 bottom text-center">
                            <div class="col-xs-12 col-sm-6 emphasis">
                              <p class="ratings">
                                <a>4.0</a>
                                <a href="#"><span class="fa fa-star"></span></a>
                                <a href="#"><span class="fa fa-star"></span></a>
                                <a href="#"><span class="fa fa-star"></span></a>
                                <a href="#"><span class="fa fa-star"></span></a>
                                <a href="#"><span class="fa fa-star-o"></span></a>
                              </p>
                            </div>
                            <div class="col-xs-12 col-sm-6 emphasis">
                              <button type="button" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#delete<%=key%>ezpk"> <i class="fa fa-trash-o"></i> Delete </button>
                              <button type="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#update<%=key%>ezpk">
                                <i class="fa fa-edit"> </i> Update
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>

                      <!--Modal-->
                  <div class="modal fade" id="delete<%=key%>ezpk" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                          </button>
                            <h4 class="modal-title" id="myModalLabel"> IBM Bank <span class="text-muted"> | Administrator</span></h4>
                        </div>
                          <form action="control/adminController.jsp" method="post">
                        <div class="modal-body">
                            <center>
                                <p>Do you want to delete this Administrator's Account : <%=result.getString("fname")+ " "+ result.getString("lname")%> ?</p>
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
                            <h4 class="modal-title" id="myModalLabel"> IBM Bank <span class="text-muted"> | Administrator</span></h4>
                        </div>
                 <form action="control/adminController.jsp" method="post" id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
                    <div class="modal-body">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">First Name <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="fname" value="<%= result.getString("fname")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Last Name <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                          <input type="text" id="last-name" name="lname" value="<%= result.getString("lname")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">E-mail Address</label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                          <input id="middle-name" class="form-control col-md-7 col-xs-12" value="<%= result.getString("email")%>" type="text" name="email">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Telephone<span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input id="birthday" class="date-picker form-control col-md-7 col-xs-12" value="<%= result.getString("phone")%>" name="phone" required="required" type="text">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Address<span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input id="birthday" class="date-picker form-control col-md-7 col-xs-12" value="<%= result.getString("address")%>" name="address" required="required" type="text">
                        </div>
                      </div>
                   
                        </div>
                        <div class="modal-footer">
                          <input type="hidden" name="ID" value="<%=key%>">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                          <input type="submit" class="btn btn-primary" name="validate" value="Update">
                        </div>
                        </form>
                      </div>
                    </div>
                  </div>
                      <!--End Modal-->
<% } 
}
%>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->