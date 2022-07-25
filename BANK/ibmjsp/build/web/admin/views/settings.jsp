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
int key=(Integer)session.getAttribute("admin_id");
Map Where=new HashMap();
Where.put("id", key);
Map Condition= new HashMap();
Condition.put("where", Where);
ResultSet result=Db.getrows(tableName, Condition);
result.next();
    String fname=result.getString("fname");
    String lname=result.getString("lname");
    String email=result.getString("email");
    String phone=result.getString("phone");
    String address=result.getString("address");
    String password=result.getString("password");
%>

<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Administrator Profile</h3>
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
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>User Report <small>Activity report</small></h2>
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
                    <div class="col-md-3 col-sm-3 col-xs-12 profile_left">
                      <div class="profile_img">
                        <div id="crop-avatar">
                          <!-- Current avatar -->
                          <img class="img-responsive avatar-view" src="images/user.png" alt="Avatar" title="Change the avatar">
                        </div>
                      </div>
                      <h3><%=fname+" "+lname%></h3>

                      <ul class="list-unstyled user_data">
                        <li><i class="fa fa-map-marker user-profile-icon"></i> <%=address%>
                        </li>

                        <li>
                          <i class="fa fa-briefcase user-profile-icon"></i> IBM Bank Administrator
                        </li>
                      </ul>

                      <a class="btn btn-success"><i class="fa fa-edit m-right-xs"></i>Edit Profile</a>
                      <br />

                      

                    </div>
                    <div class="col-md-9 col-sm-9 col-xs-12">

                     
                     
                      <div class="" role="tabpanel" data-example-id="togglable-tabs">
                        <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                          <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">Personnel Information</a>
                          </li>
                          <li role="presentation" class=""><a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">Password Update</a>
                          </li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                          <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">

                           <form action="control/adminController.jsp" method="post" id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
                             <div class="form-group">
                               <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">First Name <span class="required">*</span>
                               </label>
                               <div class="col-md-6 col-sm-6 col-xs-12">
                                   <input type="text" id="first-name" name="fname" value="<%=fname%>" required="required" class="form-control col-md-7 col-xs-12">
                               </div>
                             </div>
                             <div class="form-group">
                               <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Last Name <span class="required">*</span>
                               </label>
                               <div class="col-md-6 col-sm-6 col-xs-12">
                                 <input type="text" id="last-name" name="lname" value="<%=lname%>" required="required" class="form-control col-md-7 col-xs-12">
                               </div>
                             </div>
                             <div class="form-group">
                               <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">E-mail Address</label>
                               <div class="col-md-6 col-sm-6 col-xs-12">
                                 <input id="middle-name" value="<%=email%>" class="form-control col-md-7 col-xs-12" type="text" name="email">
                               </div>
                             </div>
                             <div class="form-group">
                               <label class="control-label col-md-3 col-sm-3 col-xs-12">Telephone<span class="required">*</span>
                               </label>
                               <div class="col-md-6 col-sm-6 col-xs-12">
                                   <input id="birthday" value="<%=phone%>" class="date-picker form-control col-md-7 col-xs-12" name="phone" required="required" type="text">
                               </div>
                             </div>
                             <div class="form-group">
                               <label class="control-label col-md-3 col-sm-3 col-xs-12">Address<span class="required">*</span>
                               </label>
                               <div class="col-md-6 col-sm-6 col-xs-12">
                                   <input id="birthday" value="<%=address%>" class="date-picker form-control col-md-7 col-xs-12" name="address" required="required" type="text">
                               </div>
                             </div>
                             <div class="ln_solid"></div>
                             <div class="form-group">
                               <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                 <button class="btn btn-primary" type="button">Cancel</button>
                                                         <input type="submit" class="btn btn-success" name="validate" value="Save"> 
                               </div>
                             </div>
                           </form>

                          </div>
                          <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">

                     <form action="control/adminController.jsp" method="post" id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Current Password <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="password" id="first-name" name="old_password" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">New Password <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="password" id="last-name" name="new_password" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Confirm Password</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="middle-name" class="form-control col-md-7 col-xs-12" type="password" name="confirm_password">
                        </div>
                      </div>
                     
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          <button class="btn btn-primary" type="button">Cancel</button>
                                                  <input type="submit" class="btn btn-success" name="validate" value="Change"> 
                        </div>
                      </div>
                    </form>

                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->
        