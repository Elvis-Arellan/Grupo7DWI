<%
    String user = (String) session.getAttribute("userDeFormulario");
    String clave = (String) session.getAttribute("claveDeFormulario");
    
    if (user == null | clave == null) {
        response.sendRedirect("index.jsp?directo=true");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>perfil</title>
    </head>
    <body>
        <h1>Página del perfil</h1>

        <p>Bienvenido <%= user%></p>
        <p>clave: <%= clave%></p>
      
        <a href="cerrar.jsp">Cerrar sesion</a>
    </body>
</html>
