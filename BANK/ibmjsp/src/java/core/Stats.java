
/* Introduction 
  ==============
*db Class
*This class is used for database related (connect, insert, update, and delete) operations , 
* It aims to facilitate the  use of CRUD functions every where they are needed in the project and to avoid multiple CRUD lines of code. 
* by calling this class you can access the databases
* @author Ezechiel Kalengya Ezpk
 */
package core;

import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;

public class Stats {
// General variable for database connection 


    public Connection con = null; 

    private String Username = "root";
    private String Passwword = "";
    private String Url = "jdbc:mysql://localhost:3306/java_course_ass_2_question_6_bank_db";

    private Statement Stmt = null;
    private PreparedStatement psmt = null;
    private String SQL = "";

    public Connection getcon() throws SQLException {
        con = DriverManager.getConnection(Url, Username, Passwword);
        return con;
    }

    public void GetDrive() throws ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
    }

    public String uploadUrl() {
        String url ="/root/NetBeansProjects/ibm/web/admin/images";      
        return url;
    }

    public void connection() throws ClassNotFoundException, SQLException {
        GetDrive();

    }

    /*
     * Insert data into the database
     * @param string name of the tablepsmt.close();
     * @param Map the Data for inserting into the table
     */
    public boolean insert(String Table, Map Data) throws SQLException, ClassNotFoundException {
        connection();
        getcon();
        String Columns = "";
        String Values = "";
        int i = 0;

        String pre = " ";
        if (!Data.isEmpty()) {
            Set<String> keys = Data.keySet();
            for (String key : keys) {
                pre = (i > 0) ? " , " : " ";
                Columns += pre + key;
                Values += pre + "'" + Data.get(key) + "'";
                i++;
            }
            SQL = "insert into " + Table + " (" + Columns + ") values (" + Values + ") ";

            psmt = getcon().prepareStatement(SQL);
            if (psmt.executeUpdate() > 0) {
                return true;
            } else {
                return false;
            }

        }
//           psmt.close();
        getcon().close();
        return false;
    }

    /*
     * Update data into the database
     * @param string name of the table
     * @param Map the data for updating into the table
     * @param Map where condition on updating data
     */
    public boolean update(String Table, Map Data, Map Conditions) throws SQLException, ClassNotFoundException {
        connection();
        getcon();
        String ColValSet = "";
        String WhereSql = "  where   ";
        int i = 0;
        String pre = " ";
        if (!Data.isEmpty()) {
            Set<String> keys = Data.keySet();
            for (String key : keys) {
                pre = (i > 0) ? " , " : " ";
                ColValSet += pre + key + "='" + Data.get(key) + "'";

                i++;
            }
        }
        i = 0;
        if (!Conditions.isEmpty()) {
            Set<String> kys = Conditions.keySet();
            for (String ky : kys) {
                pre = (i > 0) ? " AND " : " ";
                WhereSql += pre + ky + "='" + Conditions.get(ky) + "'";

                i++;
            }
        }
        SQL = " update  " + Table + " set " + ColValSet + WhereSql;

        psmt = getcon().prepareStatement(SQL);
        if (psmt.executeUpdate() > 0) {
            return true;
        }
        getcon().close();
        return false;
    }

    /*
     * Delete data from the database
     * @param string name of the table
     * @param Map  where condition on deleting data
     */
    public boolean delete(String Table, Map Conditions) throws SQLException, ClassNotFoundException {
        connection();
        getcon();
        String WhereSql = "  where   ";
        int i = 0;
        String pre = " ";
        if (!Conditions.isEmpty()) {
            Set<String> keys = Conditions.keySet();
            for (String key : keys) {
                pre = (i > 0) ? " AND " : " ";
                WhereSql += pre + key + "='" + Conditions.get(key) + "'";
                i++;
            }
        }
        SQL = " delete  from   " + Table + "  " + WhereSql;
//                 connection();

        psmt = getcon().prepareStatement(SQL);
        if (psmt.executeUpdate() > 0) {
            return true;
        }
        psmt.close();
        getcon().close();
        return false;

    }

    
    
    
    public ResultSet getrows(String Table, Map Conditions) throws SQLException, ClassNotFoundException {
        connection();
        getcon();
        ResultSet rows = null;
        String sql = "SELECT  ";

        if (!Conditions.isEmpty()) {
            int i = 0;
            sql += (Conditions.containsKey("select") ? Conditions.get("select") : " * ");
            sql += " FROM  " + Table;

            if (Conditions.containsKey("where")) {
                sql += " WHERE ";
                Map where = (Map) Conditions.get("where");
                Set<String> keys = where.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " = '" + where.get(key) + "'";
                    i++;
                }
            }
               if (Conditions.containsKey("where_or")) {
                sql += " WHERE ";
                Map where = (Map) Conditions.get("where_or");
                Set<String> keys = where.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " OR  " : " ";
                    sql += pre + key + " = '" + where.get(key) + "'";
                    i++;
                }
            }

            if (Conditions.containsKey("wherelike")) {
                sql += " WHERE ";
                Map wherelike = (Map) Conditions.get("wherelike");
                Set<String> keys = wherelike.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " OR " : " ";
                    sql += pre + key + " LIKE '%" + wherelike.get(key) + "%'";
                    i++;
                }
            }

            if (Conditions.containsKey("order_by")) {
                sql += " ORDER BY      " + Conditions.get("order_by");

            }

            if (Conditions.containsKey("start") && Conditions.containsKey("limit")) {
                sql += " LIMIT   " + Conditions.get("start") + ", " + Conditions.get("limit");

            } else if (!Conditions.containsKey("start") && Conditions.containsKey("limit")) {
                sql += " LIMIT   " + Conditions.get("limit");

            }
//                   connection();
            psmt = getcon().prepareStatement(sql);
            rows = psmt.executeQuery();
             
            getcon().close();
        }
        return rows;

    }

    /*
     * Returns a  Max value of specific column   from the database table  
     * @param String Object is the name of the specific  column   of the table
     * @param String Table  is the name of the target table
     * @param array Conditions :  select, where, order_by, limit, whereless, wheregreater, wheregreaterequal, wherelessequal,Conditions
     */
    public double GetMax(String Object, String Table, Map Conditions) throws SQLException, ClassNotFoundException {
        String sql = "SELECT  MAX(" + Object + ")   FROM " + Table + "";
        double max = 0.0;
        ResultSet data = null;

        int i = 0;

        if (!Conditions.isEmpty()) {

            if (Conditions.containsKey("where")) {
                sql += " WHERE ";
                Map where = (Map) Conditions.get("where");
                Set<String> keys = where.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " = '" + where.get(key) + "'";
                    i++;
                }
            }

            if (Conditions.containsKey("whereless")) {
                sql += " WHERE ";
                Map whereless = (Map) Conditions.get("whereless");
                Set<String> keys = whereless.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " < '" + whereless.get(key) + "'";
                    i++;
                }
            }

            if (Conditions.containsKey("wheregreater")) {
                sql += " WHERE ";
                Map wheregreater = (Map) Conditions.get("wheregreater");
                Set<String> keys = wheregreater.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " > '" + wheregreater.get(key) + "'";
                    i++;
                }
            }

            if (Conditions.containsKey("wheregreaterequal")) {
                sql += " WHERE ";
                Map wheregreaterequal = (Map) Conditions.get("wheregreaterequal");
                Set<String> keys = wheregreaterequal.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " >= '" + wheregreaterequal.get(key) + "'";
                    i++;
                }
            }

            if (Conditions.containsKey("wherelessequal")) {
                sql += " WHERE ";
                Map wherelessequal = (Map) Conditions.get("wherelessequal");
                Set<String> keys = wherelessequal.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " <= '" + wherelessequal.get(key) + "'";
                    i++;
                }
            }

        }

        connection();
        psmt = getcon().prepareStatement(sql);
        data = psmt.executeQuery();
        if (data.next()) {
            max = data.getDouble(1);
        }
        data.close();
        getcon().close();
        //psmt.close();
        return max;

    }
    
    
    
    
        public int Getmax(String Table) throws SQLException, ClassNotFoundException {
        String sql = "SELECT  MAX(id)   FROM " + Table ;
        int max = 0;
        ResultSet data = null;
        connection();
        psmt = getcon().prepareStatement(sql);
        data = psmt.executeQuery();
        if (data.next()) {
            max = data.getInt(1);
        }
        data.close();
        getcon().close();
        return max;
    }
    
    

    /*
     * Returns the Summation  value of   specific column    from the database table  
     * @param String Object is the name of the specific  column   of the table
     * @param String Table  is the name of the target table
     * @param array Conditions : select, where, order_by, limit, whereless, wheregreater, wheregreaterequal, wherelessequal,Conditions
     */
    public double GetSum(String Object, String Table, Map Conditions) throws SQLException, ClassNotFoundException {
        String sql = "SELECT  SUM(" + Object + ")   FROM " + Table + "";
        double sum = 0.0;
        ResultSet data = null;

        int i = 0;

        if (!Conditions.isEmpty()) {

            if (Conditions.containsKey("where")) {
                sql += " WHERE ";
                Map where = (Map) Conditions.get("where");
                Set<String> keys = where.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " = '" + where.get(key) + "'";
                    i++;
                }
            }

            if (Conditions.containsKey("whereless")) {
                sql += " WHERE ";
                Map whereless = (Map) Conditions.get("whereless");
                Set<String> keys = whereless.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " < '" + whereless.get(key) + "'";
                    i++;
                }
            }

            if (Conditions.containsKey("wheregreater")) {
                sql += " WHERE ";
                Map wheregreater = (Map) Conditions.get("wheregreater");
                Set<String> keys = wheregreater.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " > '" + wheregreater.get(key) + "'";
                    i++;
                }
            }

            if (Conditions.containsKey("wheregreaterequal")) {
                sql += " WHERE ";
                Map wheregreaterequal = (Map) Conditions.get("wheregreaterequal");
                Set<String> keys = wheregreaterequal.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " >= '" + wheregreaterequal.get(key) + "'";
                    i++;
                }
            }

            if (Conditions.containsKey("wherelessequal")) {
                sql += " WHERE ";
                Map wherelessequal = (Map) Conditions.get("wherelessequal");
                Set<String> keys = wherelessequal.keySet();
                for (String key : keys) {

                    String pre = (i > 0) ? " AND " : " ";
                    sql += pre + key + " <= '" + wherelessequal.get(key) + "'";
                    i++;
                }
            }

        }

        connection();
        psmt = getcon().prepareStatement(sql);
        data = psmt.executeQuery();
        if (data.next()) {
            sum = data.getDouble(1);
        }
        data.close();
        getcon().close();
        return sum;
    }
    
    
    
      /*
     * Returns The average  value of specific column   from the database table  
     * @param String Object is the name of the specific  column   of the table
     * @param String Table  is the name of the target table
     * @param array Conditions : select, where, order_by, limit, whereless, wheregreater, wheregreaterequal, wherelessequal,Conditions
     */
     
       public double GetAvg(String Object, String Table, Map Conditions) throws SQLException, ClassNotFoundException
    {
         String sql="SELECT  AVG("+Object+")   FROM "+Table+"";
        double avg = 0.0;
        ResultSet data =null;
       
        int i=0; 
       
            
        if (!Conditions.isEmpty())
                {
                
                    
                    
                        if (Conditions.containsKey("where"))
                        {
                                    sql+= " WHERE ";
                                    Map where= (Map) Conditions.get("where");
                                    Set <String> keys =  where.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" = '"+where.get(key)+"'";
                                            i++;
                                        }     
                        } 
                    
                    
                       if (Conditions.containsKey("whereless"))
                        {
                                    sql+= " WHERE ";
                                    Map whereless= (Map) Conditions.get("whereless");
                                    Set <String> keys =  whereless.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" < '"+whereless.get(key)+"'";
                                            i++;
                                        }     
                        } 
                    
                           if (Conditions.containsKey("wheregreater"))
                        {
                                    sql+= " WHERE ";
                                    Map wheregreater= (Map) Conditions.get("wheregreater");
                                    Set <String> keys =  wheregreater.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" > '"+wheregreater.get(key)+"'";
                                            i++;
                                        }     
                        } 
                           
                           
                                  if (Conditions.containsKey("wheregreaterequal"))
                        {
                                    sql+= " WHERE ";
                                    Map wheregreaterequal= (Map) Conditions.get("wheregreaterequal");
                                    Set <String> keys =  wheregreaterequal.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" >= '"+wheregreaterequal.get(key)+"'";
                                            i++;
                                        }     
                        }
                                  
                               if (Conditions.containsKey("wherelessequal"))
                        {
                                    sql+= " WHERE ";
                                    Map wherelessequal= (Map) Conditions.get("wherelessequal");
                                    Set <String> keys =  wherelessequal.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" <= '"+wherelessequal.get(key)+"'";
                                            i++;
                                        }     
                        }
                    
                        
                }
        
                connection();
                psmt=getcon().prepareStatement(sql);
                data =psmt.executeQuery(); 
                if (data.next())
                    {
                        avg=data.getDouble(1);
                    } 
                data.close();
        getcon().close();
        return avg;
    }
       
        public double GetRows(String Table, Map Conditions) throws SQLException, ClassNotFoundException
    {
         String sql="SELECT  COUNT(id)  AS NUMBER  FROM "+Table+"";
        double avg = 0.0;
        ResultSet data =null;
       
        int i=0; 
       
            
        if (!Conditions.isEmpty())
                {
                
                    
                    
                        if (Conditions.containsKey("where"))
                        {
                                    sql+= " WHERE ";
                                    Map where= (Map) Conditions.get("where");
                                    Set <String> keys =  where.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" = '"+where.get(key)+"'";
                                            i++;
                                        }     
                        } 
                    
                    
                       if (Conditions.containsKey("whereless"))
                        {
                                    sql+= " WHERE ";
                                    Map whereless= (Map) Conditions.get("whereless");
                                    Set <String> keys =  whereless.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" < '"+whereless.get(key)+"'";
                                            i++;
                                        }     
                        } 
                    
                           if (Conditions.containsKey("wheregreater"))
                        {
                                    sql+= " WHERE ";
                                    Map wheregreater= (Map) Conditions.get("wheregreater");
                                    Set <String> keys =  wheregreater.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" > '"+wheregreater.get(key)+"'";
                                            i++;
                                        }     
                        } 
                           
                           
                                  if (Conditions.containsKey("wheregreaterequal"))
                        {
                                    sql+= " WHERE ";
                                    Map wheregreaterequal= (Map) Conditions.get("wheregreaterequal");
                                    Set <String> keys =  wheregreaterequal.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" >= '"+wheregreaterequal.get(key)+"'";
                                            i++;
                                        }     
                        }
                                  
                               if (Conditions.containsKey("wherelessequal"))
                        {
                                    sql+= " WHERE ";
                                    Map wherelessequal= (Map) Conditions.get("wherelessequal");
                                    Set <String> keys =  wherelessequal.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" <= '"+wherelessequal.get(key)+"'";
                                            i++;
                                        }     
                        }
                    
                        
                }
        
                connection();
                psmt=getcon().prepareStatement(sql);
                data =psmt.executeQuery(); 
                if (data.next())
                    {
                        avg=data.getDouble(1);
                    } 
                data.close();
        getcon().close();
        return avg;
    }
       
       

       
       /*
     * Returns a  Min value of specific column   from the database table  
     * @param String Object is the name of the specific  column   of the table
     * @param String Table  is the name of the target table
     * @param array Conditions : select, where, order_by, limit, whereless, wheregreater, wheregreaterequal, wherelessequal,Conditions
     */
   
    
     public double GetMin(String Object, String Table, Map Conditions) throws SQLException, ClassNotFoundException
    {
         String sql="SELECT  MIN("+Object+")   FROM "+Table+"";
        double min = 0.0;
        ResultSet data =null;
       
        int i=0; 
       
            
        if (!Conditions.isEmpty())
                {
                
                    
                    
                        if (Conditions.containsKey("where"))
                        {
                                    sql+= " WHERE ";
                                    Map where= (Map) Conditions.get("where");
                                    Set <String> keys =  where.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" = '"+where.get(key)+"'";
                                            i++;
                                        }     
                        } 
                    
                    
                       if (Conditions.containsKey("whereless"))
                        {
                                    sql+= " WHERE ";
                                    Map whereless= (Map) Conditions.get("whereless");
                                    Set <String> keys =  whereless.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" < '"+whereless.get(key)+"'";
                                            i++;
                                        }     
                        } 
                    
                           if (Conditions.containsKey("wheregreater"))
                        {
                                    sql+= " WHERE ";
                                    Map wheregreater= (Map) Conditions.get("wheregreater");
                                    Set <String> keys =  wheregreater.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" > '"+wheregreater.get(key)+"'";
                                            i++;
                                        }     
                        } 
                           
                           
                                  if (Conditions.containsKey("wheregreaterequal"))
                        {
                                    sql+= " WHERE ";
                                    Map wheregreaterequal= (Map) Conditions.get("wheregreaterequal");
                                    Set <String> keys =  wheregreaterequal.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" >= '"+wheregreaterequal.get(key)+"'";
                                            i++;
                                        }     
                        }
                                  
                               if (Conditions.containsKey("wherelessequal"))
                        {
                                    sql+= " WHERE ";
                                    Map wherelessequal= (Map) Conditions.get("wherelessequal");
                                    Set <String> keys =  wherelessequal.keySet();
                                    for(String key: keys) 
                                        {
                                           
                                           String pre  =(i>0)?" AND ":" ";
                                           sql+= pre+key +" <= '"+wherelessequal.get(key)+"'";
                                            i++;
                                        }     
                        }
                    
                        
                }
        
                connection();
                psmt=getcon().prepareStatement(sql);
                data =psmt.executeQuery(); 
                if (data.next())
                    {
                        min=data.getDouble("NUMBER");
                    }  
                data.close();
        getcon().close();
        return min;
    }
     
     
     /*
     * Returns a specific element  from the database table  based on the ID 
     * @param String Object is the name of the specific wanted element  of the table
     * @param String Table is the name of the target table
     * @param int  id  the Id of the target element in the table
     */
    
    public String get_tblelmt_by_id(String Object, String Table, int id) throws SQLException, ClassNotFoundException
    {
        String elmt="";
        ResultSet data =null;
         String sql="SELECT  "+Object+" FROM "+Table+" where id = '"+id+"'";
                   connection();
                   psmt=getcon().prepareStatement(sql);
                   data =psmt.executeQuery(); 
                   if (data.next())
                        {
                            elmt=data.getString(Object);
                        } 
                   data.close();
        getcon().close();
        return elmt;
    }
    
    
    
    /*
     *Returns a false or true if an element already existe a certain table 
     *@param String Object is Value that you want to check in a table
     *@param String Table is the name of the target table
    */
    
    public boolean  checkElment(String Table, String Column ,String Object ) throws SQLException, ClassNotFoundException
    {
        
        ResultSet data =null;
        String sql="SELECT  "+Column+" FROM "+Table+" where "+Column+" = '"+Object+"'";
                   connection();
                   psmt=getcon().prepareStatement(sql);
                   data =psmt.executeQuery(); 
                   if (data.next())
                        {
                           return true;
                        } 
        data.close();
        getcon().close();
        return false;
    }
    
    public int usingThreadLocalClass() {
		int randomInt = ThreadLocalRandom.current().nextInt(1000, 9999);
                
                return randomInt;
	}

    public int from0to50() {
		int randInt = ThreadLocalRandom.current().nextInt(0, 50);
                
                return randInt;
	}
    
    public String currentDateTime(String type){
        String dt="";
        if(type.equals("date")){
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
            Date date = new Date();
            System.out.println(dateFormat.format(date));
            dt+=dateFormat.format(date);
        }else{
            if(type.equals("datetime")){
                DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Date date = new Date();
                System.out.println(dateFormat.format(date));
                dt+=dateFormat.format(date);
            }
        }
        return dt;
    }
    public Date currentDate(){
        String dt="";
                DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Date date = new Date();
                System.out.println(dateFormat.format(date));
//                dt+=(String)dateFormat.format(date);
          
        return date;
    }   
}