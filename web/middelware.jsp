<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String user = request.getParameter("username");
    String clave = request.getParameter("clave");
    
     if (user.isEmpty() | clave.isEmpty()) {
        response.sendRedirect("index.jsp?empty=true");
        return;
    }
     
    session.setAttribute("userDeFormulario", user);
    session.setAttribute("claveDeFormulario", clave);

    response.sendRedirect("perfil.jsp");
    return;

%>