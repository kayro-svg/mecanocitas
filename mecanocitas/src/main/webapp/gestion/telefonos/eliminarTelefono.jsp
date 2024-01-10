<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>

<%@include file="../../connect.jsp" %>
<%
String id_telefono = request.getParameter("id_telefono");
String id_cliente = ""; 

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

Statement st = conexion.createStatement();

try {
    // Consulta para obtener el id_cliente asociado al id_telefono
    String sqlIdCliente = "SELECT id_cliente FROM telCliente WHERE id_telefono = '" + id_telefono + "'";
    ResultSet rs = st.executeQuery(sqlIdCliente);

    // Obtener el valor de id_cliente desde el resultado de la consulta
    if (rs.next()) {
        id_cliente = rs.getString("id_cliente");

        // Eliminar el registro de telCliente para desvincular el teléfono con el cliente
        String sqlTelCliente = "DELETE FROM telCliente WHERE id_telefono = '" + id_telefono + "' and id_cliente = '" + id_cliente + "'";
        st.executeUpdate(sqlTelCliente);
    }

    // Eliminar el registro de la tabla telefono
    String sqlTelefono = "DELETE FROM telefono WHERE id_telefono = '" + id_telefono + "'";
    st.executeUpdate(sqlTelefono);

    
    %>
    
    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="initial-scale=1, width=device-width" />

    <link rel="stylesheet" href="../../estilos-crud/estilo_global.css" />
    <link rel="stylesheet"
    	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700&display=swap" />
    <link rel="icon" type="image/x-icon" href="../../favicon/favicon.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

    <title>MecanoCitas - Teléfonos</title>

    </head>
    <body>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
    	
    	<main class="contenedor" style="display: flex; align-items: center;"> 
    	
    	<div style="margin: auto; width: fit-content;"> 
    	
<svg xmlns="http://www.w3.org/2000/svg" class="d-none">
  <symbol id="check-circle-fill" viewBox="0 0 16 16">
    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
  </symbol>
</svg>
<div class="alert alert-success d-flex align-items-center" role="alert" style="width: fit-content;height: 75px;justify-content: center;gap: 15px;">
  <svg style="width: 50px;" class="bi flex-shrink-0 me-2" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
  <div>
    ¡Teléfono Eliminado correctamente!
  </div>
</div>

</div>
    
    <%
    out.println("<script type=\"text/javascript\">");
    out.println("setTimeout(function() { window.location.href = 'telefonos.jsp'; }, 1000);");
    out.println("</script>");
} catch (Exception e) {
    out.println("Ocurrió un fallo al eliminar los datos");
}
%>

    </main>
    </body>
    </html>
