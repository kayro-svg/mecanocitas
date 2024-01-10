<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>


<%@include file="../../connect.jsp"  %>


<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- jQuery UI -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<%
String roltoint = session.getAttribute("idrol").toString();
String user = session.getAttribute("user").toString();

%>

<% if (!("1".equals(roltoint) || "1".equals(roltoint))) { 
out.println("No tienes permitido acceder a este modulo");
	out.println("<script type=\"text/javascript\">");
out.println("setTimeout(function() { window.location.href = 'citas.jsp'; }, 1000);");
out.println("</script>");}else{ %>
<%
String id_citas = " ";
id_citas = (request.getParameter("id_citas") != null) ? request.getParameter("id_citas") : "0"; 

String id_cliente = " ";
id_cliente = (request.getParameter("id_cliente") != null) ? request.getParameter("id_cliente") : "0"; // consulta en la URL es diferente de null

String id_vehiculo = " ";
id_vehiculo = (request.getParameter("id_vehiculo") != null) ? request.getParameter("id_vehiculo") : "0"; // consulta en la URL es diferente de null

String marca = " ";
marca = (request.getParameter("marca") != null) ? request.getParameter("marca") : ""; // consulta en la URL es diferente de null

String modelo = " ";
modelo = (request.getParameter("modelo") != null) ? request.getParameter("modelo") : ""; // consulta en la URL es diferente de null


String id_mecanico = " ";
id_mecanico = (request.getParameter("id_mecanico") != null) ? request.getParameter("id_mecanico") : ""; // consulta en la URL es diferente de null

String nombre = " ";
nombre = (request.getParameter("nombre") != null) ? request.getParameter("nombre") : ""; // consulta en la URL es diferente de null

String apellido = " ";
apellido = (request.getParameter("apellido") != null) ? request.getParameter("apellido") : ""; // consulta en la URL es diferente de null

String observacion = " ";
observacion = (request.getParameter("observacion") != null) ? request.getParameter("observacion") : "";

String fecha= "";
fecha = (request.getParameter("fecha") != null) ? request.getParameter("fecha") : "";

String mecanico= "";
mecanico= (request.getParameter("mecanico") != null) ? request.getParameter("mecanico") : "";

String vehiculo= "";
vehiculo= (request.getParameter("vehiculo") != null) ? request.getParameter("vehiculo") : "";

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

Statement st = conexion.createStatement();


session.setAttribute("id_cliente", id_cliente);




String estadoDesc= "";
estadoDesc = (request.getParameter("descripcion") != null) ? request.getParameter("descripcion") : "";

String query = "SELECT c.id_citas, c.username, cl.nombre, cl.apellido, cl.cedula, DATE(c.fecha_creacion) AS solo_fecha, TIME(c.fecha_creacion) AS solo_hora,  " +
        "(SELECT GROUP_CONCAT(v.marca, ' - ', v.modelo) AS vehiculo FROM clienteVehiculo cv " +
        "LEFT JOIN Vehiculo v ON cv.id_vehiculo = v.id_vehiculo " +
        "WHERE cv.id_cliente = cl.id_cliente AND cv.id_vehiculo = c.id_vehiculo GROUP BY cv.id_cliente) AS vehiculo, " +
        "c.observacion, " +
        "CONCAT(m.nombre, ' ', m.apellido) AS mecanico, " +
        "c.fecha, " +
        "e.descripcion AS estado, " +
        "c.username, " +
        "u.nombre AS nombre_usuario, " +
        "u.apellido AS apellido_usuario " +
        "FROM Citas c " +
        "INNER JOIN clientevehiculo cv ON c.id_vehiculo = cv.id_vehiculo " +
        "INNER JOIN Cliente cl ON cv.id_cliente = cl.id_cliente " +
        "LEFT JOIN citasmecanico cm ON c.id_citas = cm.id_citas " +
        "LEFT JOIN Mecanico m ON cm.id_mecanico = m.id_mecanico " +
        "LEFT JOIN citasestado ce ON c.id_citas = ce.id_citas " +
        "LEFT JOIN Estado e ON ce.id_estado = e.id_estado " +
        "LEFT JOIN usuario u ON c.username = u.username " +
        "WHERE c.id_citas LIKE '%" + id_citas + "%' AND e.descripcion LIKE '%" + estadoDesc + "%'";


ResultSet rs = st.executeQuery(query);


if (rs.next()) {
	    estadoDesc = rs.getString("estado");
	 String observ = rs.getString("observacion");
	 String fechacita = rs.getString("fecha");
	 String mecanicos = rs.getString("mecanico");
	 String vehiculos = rs.getString("vehiculo");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="initial-scale=1, width=device-width" />

<link rel="stylesheet" href="../../estilos-crud/formularios.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700&display=swap" />
<link rel="icon" type="image/x-icon" href="../../favicon/favicon.png">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<title>MecanoCitas - Nueva Cita</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco" style="width: fit-content; height: fit-content; padding: 20px;">

<div class="titulo">
<h1 class="titulo-texto">DETALLE CITA</h1>  
</div>

<div class="contenido" style="height: fit-content;">

<div style="width: 600px; margin-top: 20px;">
<span style="">Cita creada por: <b> <%=rs.getString("nombre_usuario")%> <%=rs.getString("apellido_usuario")%> (<%=rs.getString(2)%>) </b> </span>
  </div>
  <div style="width: 600px; margin-top: 5px;margin-bottom: 20px;">
  <span style="">Creada el día: <b> <%=rs.getString("solo_fecha")%> </b>  a las: <b><%=rs.getString("solo_hora")%> </b></span>
  </div>
  <div style="width: 600px; display: flex;justify-content: center;">
  <table class="table table-striped table-hover" style="width: 100%;">
        <tr>
            <th>Cliente:</th>
            <td><%=rs.getString(3) + " " + rs.getString(4) %></td>
        </tr>
        <tr>
            <th>Cédula del cliente:</th>
            <td><%=rs.getString(5) %></td>
        </tr>
        <tr>
            <th>Vehículo a revisar:</th>
            <td><%=vehiculos %></td>
        </tr>
        <tr>
            <th>Mecánico asignado:</th>
            <td><%=mecanicos %></td>
        </tr>
        <tr>
            <th>Fecha de Cita:</th>
            <td><%=fechacita %></td>
        </tr>
        <tr>
            <th>Estado de la cita:</th>
            <td><%=estadoDesc %></td>
        </tr>
        <tr>
            <th>Observación:</th>
            <td><%=observ %></td>
        </tr>
    </table>
</div>

<div class="cancel-save-boton" style="margin-top:30px; width: 600px;"> 
	<a href="../../principal/citas/citas.jsp" class="boton-cancelar" id="boton-login">
    VOLVER
  </a>
  
</div>

</form> 


<%
     while (rs.next());
} else {
    out.println("No existen registros con este criterio de búsqueda");
}
%>
</div>
</div>
</div>

</main>

<script>
  // Script para el selector de fecha
  $(document).ready(function() {
    $("#datepicker").datepicker({
      dateFormat: 'yy-mm-dd' // Formato de la fecha
    });
  });

  // Script para enviar el formulario 'form' al presionar el botón 'botonForm'
  document.getElementById('botonForm').addEventListener('click', function(event) {
    event.preventDefault(); // Evita el envío del formulario por defecto
    document.getElementById('form').submit(); // Envía el formulario 'form'
  });

  
  
</script>

  <style>
        /* Estilos CSS para la tabla de dos columnas */
        .table-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .column-left {
            flex: 0 0 40%;
            text-align: right;
            padding-right: 10px;
            font-weight: bold;
        }

        .column-right {
            flex: 0 0 60%;
            text-align: left;
        }

        /* Otros estilos */
        /* ... (agrega aquí cualquier otro estilo que desees mantener) */
    </style>


</body>
</html>
        <%
       
            }
        %>