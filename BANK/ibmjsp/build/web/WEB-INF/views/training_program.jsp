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
String tableName="ibm_training_program";
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
                            Register New Training Program
                        </button>
            <div class="row">

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
                          <th>Program Code</th>
                          <th>Training Course</th>
                          <th>Mentor</th>
                          <th>Date</th>
                          <th>Registered by</th>
                          <th>Date</th>
                          <th>Action</th>
                        </tr>
                      </thead>
                      <tbody>
<%
Map Condition=new HashMap();
Condition.put("select", "id, program_code, training_course_id, mentor_id, program_from_date, program_to_date, registered_by, c_date");
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
            Map Wher=new HashMap();
            Wher.put("id", result.getInt("training_course_id"));
            Map Cond=new HashMap();
            Cond.put("where", Wher);
            ResultSet infoCourse=Db.getrows("ibm_training_course", Cond);
            if(infoCourse.next()){
                Map Whe=new HashMap();
                Whe.put("id", result.getInt("mentor_id"));
                Map Con=new HashMap();
                Con.put("where", Whe);
                ResultSet infoMentor=Db.getrows("ibm_mentor", Con);
                if(infoMentor.next()){
%>
                          <tr>
                              <td><%=count%></td>
                              <td><%=result.getString("program_code")%></td>
                              <td><%=infoCourse.getString("name")%></td>
                              <td><%=infoMentor.getString("fname")+" "+infoMentor.getString("lname")%></td>
                              <td><%=result.getString("program_from_date")+" -to- "+result.getString("program_to_date")%></td>
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
                            <h4 class="modal-title" id="myModalLabel"> IBM Company <span class="text-muted"> | Training Program</span></h4>
                        </div>
                          <form action="control/trainingcourseController.jsp" method="post">
                        <div class="modal-body">
                            <center>
                                <p>Do you want to delete this Training Program : <%=result.getString("program_code")%> [ <%=infoCourse.getString("name")%> ] ?</p>
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
                            <h4 class="modal-title" id="myModalLabel"> IBM Company <span class="text-muted"> | Training Program</span></h4>
                        </div>
                <form action="control/trainingprogramController.jsp" method="post">
                     <div class="modal-body">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Training Course <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <select  id="first-name" name="training_course" required="required" class="form-control col-md-7 col-xs-12">
                                <option hidden value="<%=infoCourse.getInt("id")%>"><%=infoCourse.getString("name")%></option>
<%
Map Conditions=new HashMap(); Conditions.put("select", "id, name");
ResultSet TrainingCourse=Db.getrows("ibm_training_course", Conditions);
if(TrainingCourse.next()){ TrainingCourse.beforeFirst();
    while(TrainingCourse.next()){
%>  
                                <option value="<%=TrainingCourse.getInt("id")%>"><%=TrainingCourse.getString("name")%></option>
<%} }%>
                            </select>
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Training Mentor <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <select  id="first-name" name="training_mentor" required="required" class="form-control col-md-7 col-xs-12">
                                <option  hidden="" value="<%=infoMentor.getInt("id")%>"><%=infoMentor.getString("fname")+" "+infoMentor.getString("lname")%></option>
<%
Map Conditionss=new HashMap(); Conditionss.put("select", "id, fname, lname");
ResultSet TrainingMentor=Db.getrows("ibm_mentor", Conditionss);
if(TrainingMentor.next()){  TrainingMentor.beforeFirst();
    while(TrainingMentor.next()){
%>  
                                <option value="<%=TrainingMentor.getInt("id")%>"><%=TrainingMentor.getString("fname")+" "+TrainingMentor.getString("lname")%></option>
<%} }%>
                            </select>
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Starting Date <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="date" id="start_date" name="from_date" value="<%=result.getString("program_from_date")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Ending Date <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="date" id="end_date" name="to_date" value="<%=result.getString("program_to_date")%>"  required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                     </div><br>
                        <div class="modal-footer">
                          <input type="number"  hidden name="ID" value="">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                          <input type="submit" class="btn btn-primary" name="validate" value="Update">
                        </div>
                          </form>
                      </div>
                    </div>
                  </div>
                      <!--End Modal-->
<%              }
            }
        }
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
                            <h4 class="modal-title" id="myModalLabel"> IBM Company <span class="text-muted"> | Training Program</span></h4>
                        </div>
                   <form action="control/trainingprogramController.jsp" method="post">
                     <div class="modal-body">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Training Course <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <select  id="first-name" name="training_course" required="required" class="form-control col-md-7 col-xs-12">
                                <option hidden value="">--[Select Training Course]--</option>
<%
Map Conditions=new HashMap(); Conditions.put("select", "id, name");
ResultSet TrainingCourse=Db.getrows("ibm_training_course", Conditions);
if(TrainingCourse.next()){ TrainingCourse.beforeFirst();
    while(TrainingCourse.next()){
%>  
                                <option value="<%=TrainingCourse.getInt("id")%>"><%=TrainingCourse.getString("name")%></option>
<%} }%>
                            </select>
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Training Mentor <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <select  id="first-name" name="training_mentor" required="required" class="form-control col-md-7 col-xs-12">
                                <option  hidden="" value="">--[Select Training Mentor]--</option>
<%
Map Conditionss=new HashMap(); Conditionss.put("select", "id, fname, lname");
ResultSet TrainingMentor=Db.getrows("ibm_mentor", Conditionss);
if(TrainingMentor.next()){  TrainingMentor.beforeFirst();
    while(TrainingMentor.next()){
%>  
                                <option value="<%=TrainingMentor.getInt("id")%>"><%=TrainingMentor.getString("fname")+" "+TrainingMentor.getString("lname")%></option>
<%} }%>
                            </select>
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Starting Date <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="date" id="start_date" name="from_date"  required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Ending Date <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="date" id="end_date" name="to_date"  required="required" class="form-control col-md-7 col-xs-12">
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