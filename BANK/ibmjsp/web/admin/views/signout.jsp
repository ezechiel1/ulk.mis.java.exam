<%-- 
    Document   : signout
    Created on : Mar 3, 2020, 3:06:53 PM
    Author     : root
--%>

<%
HttpSession newsession = request.getSession(false);
    if (newsession != null) 
    {
         newsession.invalidate();

    }

   response.sendRedirect("../index.jsp");


%>