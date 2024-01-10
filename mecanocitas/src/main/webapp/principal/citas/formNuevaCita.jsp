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

<% if (!("1".equals(roltoint) || "4".equals(roltoint))) { 
out.println("No tienes permitido acceder a este modulo");
	out.println("<script type=\"text/javascript\">");
out.println("setTimeout(function() { window.location.href = 'citas.jsp'; }, 1000);");
out.println("</script>");}else{ %>
<%
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


Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

Statement st = conexion.createStatement();

String queryEstados = "SELECT id_estado , descripcion FROM estado"; // Consulta para obtener los estados

ResultSet rsEstados = st.executeQuery(queryEstados);

session.setAttribute("id_cliente", id_cliente);

HashMap<String, String> estadosMap = new HashMap<String, String>();

while (rsEstados.next()) {
	 String estadoId = rsEstados.getString("id_estado");
	    String estadoDesc = rsEstados.getString("descripcion");
	    estadosMap.put(estadoDesc, estadoId);
}

String query = "SELECT c.nombre, c.apellido, c.cedula, GROUP_CONCAT(v.marca, ' - ', v.modelo) as vehiculo "; // Ajustar la consulta
query += "FROM Cliente c ";
query += "LEFT JOIN clienteVehiculo cv ON c.id_cliente = cv.id_cliente ";
query += "LEFT JOIN Vehiculo v ON cv.id_vehiculo = v.id_vehiculo ";
query += "WHERE c.id_cliente LIKE '%" + id_cliente + "%'";


ResultSet rs = st.executeQuery(query);


if (rs.next()) {
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

<div class="bg-blanco">

<div class="titulo">
<h1 class="titulo-texto">NUEVA CITA</h1>  
</div>

<div class="contenido">

<div class="form_box1">

<form class="form" action="procesar_insercion.jsp" method="post" id="form">
    <input type="hidden" name="username" id="username" value="<%=user%>">
<%
    do {
    	String vehiculos = rs.getString("vehiculo");
		String[] listaVehiculos = (vehiculos != null) ? vehiculos.split(",") : new String[]{"Sin Seleccionar"};
%>
    <div class="form_texto">
    <input type="text" name="nombre" id="nombre" value="<%=rs.getString(1)+" "+ rs.getString(2)%>" readonly>
    <label>Cliente</label>
    </div>
  
    <div class="form_texto">
    <input type="text" name="cedula" id="cedula" value="<%=rs.getString(3)%>" readonly>
    <label>Cédula</label>
    </div>
    
    
    <input type="hidden" name="id_vehiculo" id="id_vehiculo_hidden" value="<%= id_vehiculo %>">	
    
     <div class="form form_texto">
   <input type="text" name="vehiculo_hidden" id="vehiculo_hidden"
    <% if (marca.isEmpty() && modelo.isEmpty()) { %>
        placeholder="Selecciona un Vehiculo"
    <% } else { %>
        value="<%= marca + " - " + modelo %>"
    <% } %>
    readonly>
    <label>Vehiculo</label>
      </div>
                     <button type="button" class="button" style="margin-left: -15px;">
		 <a href="citaVehiculo.jsp?id_cliente=<%=id_cliente%>" class="button__text">SELECCIONAR</a>
		<span class="button__icon">
			<ion-icon name="car"></ion-icon>
		</span>
		
	</button>
	
     </div>  
<div class="form_box2">

	<input type="hidden" name="id_mecanico" id="id_mecanico" value="<%= id_mecanico %>">

	<!-- SELECCIONAR MECANICO -->
<div class="form form_texto">
    <input type="text" name="mecanico_display" id="mecanico_display"
        <% if (nombre.isEmpty() && apellido.isEmpty()) { %>
            placeholder="Selecciona un mecánico"
        <% } else { %>
            value="<%= nombre + " " + apellido %>"
        <% } %>
        readonly>
    <label>Mecánico</label>
</div>
                   <button type="button" class="button" style="margin-left: -30px;">
		 <a href="citaMecanico.jsp?id_vehiculo=<%=id_vehiculo%>&marca=<%=marca%>&modelo=<%=modelo%>" class="button__text">SELECCIONAR</a>
		<span class="button__icon">
			<ion-icon name="person-add"></ion-icon>
		</span>
		
	</button>
	<!-- FIN SELECCIONAR MECANICO -->

  <div class="form form_texto">
    <input type="date" name="fecha" id="date"  placeholder="aa-mm-dd">
    <label>Fecha de Cita</label>
    </div>   
 
    <div  class="form form_texto-estado form_texto">
     
    <select class="btn-estado estado" name="id_estado" id="id_estado" style="text-transform: uppercase;">
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
    <label class="label">Estado:</label> 
    </div>

</div>

<div class="form_box3">


<div style="width: 662px; margin: auto;
  justify-content: left;
  display: flex;">
<label style="	font-size: 14px;
	color: #989898;">OBSERVACION:</label>
</div>
 <div style="display: flex; margin: 0; align-items: center;
  justify-content: center; margin-left: 11px;">
     
     <textarea  class=""  name="observacion" id="observacion" rows="2" cols="88"></textarea>
    </div>


</div>

<div class="cancel-save-boton"> 
	<a href="../../principal/clientes/clientes.jsp" class="boton-cancelar" id="boton-login">
    CANCELAR
  </a>
  
   <button type="submit" class="btn-guardar" id="botonForm">
  	<span >GUARDAR</span>
  </button>
</div>

</form> 


<%
    } while (rs.next());
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


</body>
</html>
        <%
       
            }
        %>