<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Crear usuario</h1>
        <form method="post" action="middelware.jsp">
            Usuario: <input name="username" type="text" placeholder="ingrese su usuario" />
            <br/>
            Clave <input name="clave" type="password" placeholder="clave de 10 caracteres" />
            <br/>
            <button type="submit">Crear cuenta</button>
        </form>
        <%
            String obtenerCerrado = request.getParameter("cerrado");
            String obtenerDirecto = request.getParameter("directo");
            String obtenerEmpty = request.getParameter("empty");

            if (obtenerCerrado != null && obtenerCerrado.equals("true")) {
        %>
        <p style="color: red">Cerraste sesion correctamente</p>
        <%
            }
        %>
        <%
            if (obtenerDirecto != null && obtenerDirecto.equals("true")) {
                %>
        <p style="color: green">Primero ingrese sus datos</p>
        <%
            }
        %>
        <%
            if (obtenerEmpty != null && obtenerEmpty.equals("true")) {
                %>
        <p style="color: gray">Llene los campos</p>
        <%
            }
        %>
    </body>
</html>
