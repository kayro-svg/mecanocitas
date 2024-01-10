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

if (!("1".equals(roltoint) || "4".equals(roltoint))) { 
out.println("No tienes permitido acceder a este modulo");
	out.println("<script type=\"text/javascript\">");
out.println("setTimeout(function() { window.location.href = 'citas.jsp'; }, 1000);");
out.println("</script>");}else{

String id_orden = request.getParameter("id_orden");

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
Statement sql = conexion.createStatement();

String queryEstados = "SELECT id_estado , descripcion FROM estado"; // Consulta para obtener los estados

ResultSet rsEstados = sql.executeQuery(queryEstados);

HashMap<String, String> estadosMap = new HashMap<String, String>();

while (rsEstados.next()) {
	 String estadoId = rsEstados.getString("id_estado");
	    String estadoDesc = rsEstados.getString("descripcion");
	    estadosMap.put(estadoDesc, estadoId);
}


String query = "SELECT ot.id_orden, ";
query += "(SELECT CONCAT(m.nombre, ' ', m.apellido) FROM Mecanico m WHERE m.id_mecanico = ot.id_mecanico) AS mecanico, ";
query += "(SELECT CONCAT(v.modelo, ' - ', v.matricula) FROM Vehiculo v WHERE v.id_vehiculo = ot.id_vehiculo) AS vehiculo, ";
query += "(SELECT GROUP_CONCAT(s.descripcion) FROM servicio s WHERE s.id_servicio IN (SELECT id_servicio FROM OrdenServicio os WHERE os.id_orden = ot.id_orden)) AS servicio, ";
query += "(SELECT GROUP_CONCAT(r.descripcion) FROM repuesto r WHERE r.id_repuesto IN (SELECT id_repuesto FROM OrdenRepuesto orp WHERE orp.id_orden = ot.id_orden)) AS repuesto, ";
query += "(SELECT GROUP_CONCAT(h.descripcion) FROM herramienta h WHERE h.id_herramienta IN (SELECT id_herramienta FROM OrdenHerramienta oh WHERE oh.id_orden = ot.id_orden)) AS herramienta, ";
query += "ot.fecha, ot.fecha_entrega, ";
query += "(SELECT e.descripcion FROM Estado e WHERE e.id_estado = ot.id_estado) AS estado ";
query += "FROM OrdenTaller ot ";


// Consulta para obtener el estado actual de la orden
String queryEstadoActual = "SELECT e.descripcion AS estado_desc FROM Estado e JOIN OrdenTaller ot ON e.id_estado = ot.id_estado WHERE ot.id_orden = '" + id_orden + "'";
ResultSet rsEstadoActual = sql.executeQuery(queryEstadoActual);

String estadoActual = "";
if (rsEstadoActual.next()) {
    estadoActual = rsEstadoActual.getString("estado_desc");
} else {
    out.println("No se encontró el estado para la orden con ID: " + id_orden);
}



ResultSet rs = sql.executeQuery(query);


if (rs.next()) {
	 String idOrden = rs.getString("id_orden");
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

<title>MecanoCitas - Editar Orden</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco" style="height: 335px; max-width: 720px;">

<div class="titulo">
<h1 class="titulo-texto">ACTUALIZAR ORDEN</h1>  
</div>

<div class="contenido">

<div class="form_box1" style="margin-top: 70px;">
    <form action="actualizarEstado.jsp" method="post">
        <input type="hidden" name=id_orden value="<%= id_orden %>">
        <h3 style="margin: 10px; margin-bottom: 20px">Estado Actual: <br> <b><%= estadoActual %></b></h3>    
        <label class="label" for="nuevo_estado">Selecciona un nuevo estado:</label><br>
          <div  class="form form_texto-estado form_texto" style="width: 119px;">
     
    <select class="btn-estado estado" name="id_estado" id="id_estado" style="text-transform: uppercase; width: 100% !important; text-align: left;">
       <% 
            // Iterar sobre el HashMap para mostrar los estados y sus descripciones
            for (Map.Entry<String, String> entry : estadosMap.entrySet()) {
                String estadoDesc = entry.getKey();
                String estadoId = entry.getValue();
        %>
            <option class="estado" value="<%= estadoId %>"><%= estadoDesc %></option>
           
        <%
       
            }
        %>
    </select> 
    </div>
        <br>
  
</div>

<div class="cancel-save-boton"> 
	<a href="ordentaller.jsp" class="boton-cancelar" id="boton-login">
    CANCELAR
  </a>
  
   <button type="submit" class="btn-guardar" id="botonForm">
  	<span >GUARDAR</span>
  </button>
</div>

  </form>
<%
} else {
    out.println("No existen registros con este criterio de búsqueda");
}
%>
</div>
</div>
</div>

</main>
</body>
</html>
        <%
       
            }
        %>