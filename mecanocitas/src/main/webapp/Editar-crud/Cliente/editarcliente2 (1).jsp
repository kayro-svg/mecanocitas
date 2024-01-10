<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>

<%
String id_cliente = "";
id_cliente = (request.getParameter("id_cliente") != null) ? request.getParameter("id_cliente") : "0"; // consulta en la URL es diferente de null

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
Statement st = conexion.createStatement();

String query = "SELECT c.id_cliente, ";

query += "(SELECT GROUP_CONCAT(marca, ' - ', modelo) FROM clienteVehiculo cv LEFT JOIN Vehiculo v ON cv.id_vehiculo = v.id_vehiculo WHERE cv.id_cliente = c.id_cliente LIMIT 1) AS vehiculo, ";
query += "c.nombre, c.apellido, c.cedula, ";

query += "(SELECT GROUP_CONCAT(descripcion) FROM telCliente tc LEFT JOIN Telefono t ON tc.id_telefono = t.id_telefono WHERE tc.id_cliente = c.id_cliente LIMIT 1) AS telefono, ";
query += "c.email, ";

query += "(SELECT GROUP_CONCAT(provincia, ' - ', distrito) FROM clienteDireccion cd LEFT JOIN Direccion d ON cd.id_direccion = d.id_direccion WHERE cd.id_cliente = c.id_cliente LIMIT 1) AS direccion ";
query += "FROM Cliente c ";

query += "WHERE c.id_cliente LIKE '%" + id_cliente + "%'";


ResultSet rs = st.executeQuery(query);
session.setAttribute("id_cliente", id_cliente);
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

<title>MecanoCitas - Nuevo Cliente</title>

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
<h1 class="titulo-texto">NUEVO CLIENTE</h1>
</div>

<div class="contenido">

<div class="form_box1">



<form class="form" action="update.jsp" method="post">
<%
    do {
    	String vehiculos = rs.getString("vehiculo");
		String[] listaVehiculos = (vehiculos != null) ? vehiculos.split(" - ") : new String[]{"No disponible"};
		
		 String telefonos = rs.getString("telefono");
		 String[] listaTelefonos = (telefonos != null) ? telefonos.split(",") : new String[]{"No disponible"};

         String direcciones = rs.getString("direccion");
         String[] listaDirecciones = (direcciones != null) ? direcciones.split(" - ") : new String[]{"No disponible"};
         
%>
    <div class="form_texto">
    <input type="text" name="nom_cliente" id="nom_cliente" value="<%=rs.getString(3)%>">
    <label>Nombre</label>
    </div>
    <div class="form_texto" >
    <input type="text" name="ape_cliente" id="ape_cliente" value="<%=rs.getString(4)%>">
    <label>Apellido</label>
    </div>  
    <div class="form_texto">
    <input type="text" name="ced_cliente" id="ced_cliente" value="<%=rs.getString(5)%>">
    <label>Cédula</label>
    </div>
    <div class="form_texto">
    <input type="text" name="mail_cliente" id="mail_cliente" value="<%=rs.getString(7)%>">
    <label>Email</label>
    </div>
</form> 
</div>






<div class="form_box2">

    <!-- EDITAR TELEFONOS -->
        <form class="form" action="updateTelefono.jsp" method="get">
		
		<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    Ver Teléfonos
  </button>
  <ul class="dropdown-menu">
    <%
			for (String telefono : listaTelefonos) {
			%>
			<li><input class="dropdown_input" type="text"
				name="vehiculo" value="<%=telefono%>"></li>
			<%
			}
			%>
  </ul>
</div>

<div style="display: flex; width: 100%; gap: 10px; margin-top: 10px;">
	  <a href="../../gestion/telefonos/insertartelefonos.jsp" class="boton" id="form_boton">Añadir</a>
	  </div>
	  
</form>

<script>

	function agregarTelefono() {
		var nuevoInput = document.createElement("input");
		nuevoInput.type = "text";
		nuevoInput.classList.add("dropdown_input");

		var contenedor = document.getElementById("inputsTelefonos");
		contenedor.appendChild(nuevoInput);
		
		
	}
</script>
      <!-- EDITAR TELEFONOS -->
    
    
    
      <!-- EDITAR DIRECCIONES -->
      
      
     <form class="form" action="updateTelefono.jsp" method="get">
		
		<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    Ver Direcciones
  </button>
  <ul class="dropdown-menu">
    <%
			for (String direccion : listaDirecciones) {
			%>
			<li><input class="dropdown_input" type="text"
				name="vehiculo" value="<%=direccion%>"></li>
			<%
			}
			%>
  </ul>
</div>
<div style="display: flex; width: 100%; gap: 10px; margin-top: 10px;">
	  <a href="../../gestion/direcciones/direcciones.jsp" class="boton" id="form_boton">Añadir</a>
	  </div>
</form>
      
<script>
	function agregarDireccion() {
		var nuevoInput = document.createElement("input");
		nuevoInput.type = "text";
		nuevoInput.classList.add("dropdown_input");

		var contenedor = document.getElementById("inputsDirecciones");
		contenedor.appendChild(nuevoInput);
		
	
	}
</script>
      <!-- EDITAR DIRECCIONES -->
      
      
      
        <!-- EDITAR VEHICULOS -->    
        
          <form class="form" action="updateTelefono.jsp" method="get">
		
		<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    Ver Vehículos
  </button>
  <ul class="dropdown-menu">
    <%
			for (String vehiculo : listaVehiculos) {
			%>
			<li><input class="dropdown_input" type="text"
				name="vehiculo" value="<%=vehiculo%>"></li>
			<%
			}
			%>
  </ul>
</div>
<div style="display: flex; width: 100%; gap: 10px; margin-top: 10px;">
	  <a href="../../gestion/vehiculos/vehiculos.jsp" class="boton" id="form_boton">Añadir</a>
	
	  </div>
</form>
        
        

<script>
	function agregarVehiculo() {
		var nuevoInput = document.createElement("input");
		nuevoInput.type = "text";
		nuevoInput.classList.add("dropdown_input");

		var contenedor = document.getElementById("inputsVehiculos");
		contenedor.appendChild(nuevoInput);
		
	
		  
		  
	}
</script>
    
       <!-- EDITAR VEHICULOS -->
</div>

<div class="cancel-save-boton"> 
	<a href="../../principal/clientes/clientes.jsp" class="boton-cancelar" id="boton-login">
    CANCELAR
  </a>
    <a class="btn-guardar" href="../../principal/clientes/clientes.jsp"  id="boton-login">GUARDAR</a> 
</div>

<%
    } while (rs.next());
%>

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
