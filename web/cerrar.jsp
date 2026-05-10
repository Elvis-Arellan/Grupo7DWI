<%
    session.invalidate();
    response.sendRedirect("index.jsp?cerrado=true");
    return;
%>