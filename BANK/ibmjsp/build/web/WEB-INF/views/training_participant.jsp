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
String tableName="ibm_participant";

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
                            Register New Training Participant 
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
                          <th>Names</th>
                          <th>Email</th>
                          <th>Telephone</th>
                          <th>Address</th>
                          <th>Training Program</th>
                          <th>Training Course</th>
                          <!--<th>Registered by</th>-->
                          <!--<th>Date</th>-->
                          <th>Action</th>
                        </tr>
                      </thead>
                      <tbody>
<%
Map Condition=new HashMap();
Condition.put("select", "id, training_program_id, fname, lname, email, phone, address, status, registered_by, c_date");
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
            Map whereP=new HashMap(); whereP.put("id", result.getInt("training_program_id"));
            Map conditP=new HashMap(); conditP.put("where", whereP);
            ResultSet infoProgram=Db.getrows("ibm_training_program", conditP);
            if(infoProgram.next()){
                Map whereC=new HashMap(); whereC.put("id", infoProgram.getInt("training_course_id"));
                Map conditC=new HashMap(); conditC.put("where", whereC);
                ResultSet infoCourse=Db.getrows("ibm_training_course", conditC);
                if(infoCourse.next()){
%>
                          <tr>
                              <td><%=count%></td>
                              <td><%=result.getString("fname")+" "+result.getString("lname")%></td></td>
                              <td><%=result.getString("email")%></td>
                              <td><%=result.getString("phone")%></td>
                              <td><%=result.getString("address")%></td>
                              <td><%=infoProgram.getString("program_code")%></td>
                              <td><%=infoCourse.getString("name")%></td>
                              <!--<td><%=infoAdmin.getString("fname")+" "+infoAdmin.getString("lname")%></td>-->
                              <!--<td><%=result.getString("c_date")%></td>-->
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
                            <h4 class="modal-title" id="myModalLabel"> IBM Company <span class="text-muted"> | Training Participant</span></h4>
                        </div>
                          <form action="control/mentorController.jsp" method="post">
                        <div class="modal-body">
                            <center>
                                <p>Do you want to delete this Training Participant : <%=result.getString("fname")+" "+result.getString("lname")%> ?</p>
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
                            <h4 class="modal-title" id="myModalLabel"> IBM Company <span class="text-muted"> | Training Participant</span></h4>
                        </div>
                <form action="control/mentorController.jsp" method="post">
                     <div class="modal-body">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> First Name <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="fname" value="<%=result.getString("fname")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Last Name <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="lname" value="<%=result.getString("lname")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Email <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="email" id="first-name" name="email" value="<%=result.getString("email")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Telephone <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="phone" value="<%=result.getString("phone")%>" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Address <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="address" value="<%=result.getString("address")%>" required="required" class="form-control col-md-7 col-xs-12">
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
                            <h4 class="modal-title" id="myModalLabel"> IBM Company <span class="text-muted"> | Training Participant</span></h4>
                        </div>
                   <form action="control/participantController.jsp" method="post">
                     <div class="modal-body">
                       <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Training Program <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <select  id="first-name" name="training_program" required="required" class="form-control col-md-7 col-xs-12">
                                <option hidden value="">--[Select Training Program]--</option>
<%
Map Conditions=new HashMap(); Conditions.put("select", "id, program_code, training_course_id, program_from_date, program_to_date");
ResultSet TrainingProgram=Db.getrows("ibm_training_program", Conditions);
if(TrainingProgram.next()){ TrainingProgram.beforeFirst();
    while(TrainingProgram.next()){ int cid=TrainingProgram.getInt("training_course_id");
        Map Wh=new HashMap(); Wh.put("id", cid);
        Map Co=new HashMap(); Co.put("where", Wh);
        ResultSet relatedCourse=Db.getrows("ibm_training_course", Co);
        if(relatedCourse.next()){ 
%>  
                                <option value="<%=TrainingProgram.getInt("id")%>"><%=TrainingProgram.getString("program_code")+" [ "+relatedCourse.getString("name")+" ] [ <small> "+TrainingProgram.getString("program_from_date")+" -to- "+TrainingProgram.getString("program_to_date")+" </small> ]"%></option>
<%} }   }   %>
                            </select>
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> First Name <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="fname" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Last Name <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="lname" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Email <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="email" id="first-name" name="email" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Telephone <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="phone" required="required" class="form-control col-md-7 col-xs-12">
                        </div>
                      </div><br><br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name"> Address <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-6 col-xs-12">
                            <input type="text" id="first-name" name="address" required="required" class="form-control col-md-7 col-xs-12">
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