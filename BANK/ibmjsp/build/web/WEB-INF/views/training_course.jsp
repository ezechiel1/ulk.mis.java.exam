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
String tableName="ibm_training_course";
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
                            Register New Training Course 
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
                          <th>Course Name</th>
                          <th>Description</th>
                          <th>Registered by</th>
                          <th>Date</th>
                          <th>Action</th>
                        </tr>
                      </thead>
                      <tbody>
<%
Map Condition=new HashMap();
Condition.put("select", "id, name, description, registered_by, c_date");
ResultSet result=Db.getrows(tableName, Condition);
if(result.next()){ result.beforeFirst(); int count=0;
    while(result.next()){ count++;
        int key=result.getInt("id");
        Map Where=new HashMap(); 
        Where.put("id", result.getInt("registered_by"));
        Map Condit=new HashMap();
        Condit.put("where", Where);
        ResultSet infoAdmin=Db.getrows("ibm_admin", Condit);
        if(infoAdmin.next()){
%>
                          <tr>
                              <td><%=count%></td>
                              <td><%=result.getString("name")%></td>
                              <td><%=result.getString("description")%></td>
                              <td><%=infoAdmin.getString("fname")+" "+infoAdmin.getString("lname")%></td>
                              <td><%=result.getString("c_date")%></td>
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
                            <h4 class="modal-title" id="myModalLabel"> IBM Company <span class="text-muted"> | Training Course</span></h4>
                        </div>
                          <form action="control/trainingcourseController.jsp" method="post">
                        <div class="modal-body">
                            <center>
                                <p>Do you want to delete this Training Course : <%=result.getString("name")%> ?</p>
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
                            <h4 class="modal-title" id="myModalLabel"> IBM Company <span class="text-muted"> | Training Course</span></h4>
                        </div>
                 <form action="control/trainingcourseController.jsp" method="post">
                     <div class="modal-body">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Training Course <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="training_course" value="<%=result.getString("name")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Description <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <textarea id="last-name" name="description" required="required" value="<%=result.getString("description")%>" class="form-control col-md-7 col-xs-12"><%=result.getString("description")%></textarea>
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
<%      }
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
                            <h4 class="modal-title" id="myModalLabel"> IBM Company <span class="text-muted"> | Training Course</span></h4>
                        </div>
                   <form action="control/trainingcourseController.jsp" method="post">
                     <div class="modal-body">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Training Course <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="training_course" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Description <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <textarea id="last-name" name="description" required="required" class="form-control col-md-7 col-xs-12"></textarea>
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