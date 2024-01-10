<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>

<%
String id_cliente = " ";
id_cliente = (request.getParameter("id_cliente") != null) ? request.getParameter("id_cliente") : "0"; // consulta en la URL es diferente de null


Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
Statement st = conexion.createStatement();

String query = "SELECT c.id_cliente, ";

query += "(SELECT GROUP_CONCAT(marca, ' - ', modelo) FROM clienteVehiculo cv LEFT JOIN Vehiculo v ON cv.id_vehiculo = v.id_vehiculo WHERE cv.id_cliente = c.id_cliente LIMIT 1) AS vehiculo, ";
query += "c.nombre AS nombre , c.apellido, c.cedula, ";

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

<title>MecanoCitas - Editar Cliente</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco-editar-cliente" style="height: 365px;">

<div class="titulo">
<h1 class="titulo-texto">EDITAR CLIENTE</h1>
</div>

<div class="contenido">

<div style="display: contents;">


<%
    do {
    	
    	String nombre = rs.getString("nombre");
    	
    	String vehiculos = rs.getString("vehiculo");
		String[] listaVehiculos = (vehiculos != null) ? vehiculos.split(",") : new String[]{"No disponible"};
		
		 String telefonos = rs.getString("telefono");
		 String[] listaTelefonos = (telefonos != null) ? telefonos.split(",") : new String[]{"No disponible"};

         String direcciones = rs.getString("direccion");
         String[] listaDirecciones = (direcciones != null) ? direcciones.split(",") : new String[]{"No disponible"};
         
%>
  
<form  id="botonForm"  class="form-editar" action="actualizarCliente.jsp" method="post">

<div class="form_box1-editar-cliente">
	 <input class="form-crear-input" type="hidden" name="id_cliente" id="botonForm" value="<%=id_cliente%>">
    <div class="form_texto">
    <input class="form-crear-input" type="text" name="nombre" id="botonForm" value="<%=rs.getString(3)%>">
    <label>Nombre</label>
    </div>
    <div class="form_texto" >
    <input class="form-crear-input" type="text" name="apellido" id="botonForm" value="<%=rs.getString(4)%>">
    <label>Apellido</label>
    </div>  
    <div class="form_texto">
    <input class="form-crear-input" type="text" name="cedula" id="botonForm" value="<%=rs.getString(5)%>">
    <label>Cédula</label>
    </div>
    <div class="form_texto">
    <input class="form-crear-input" type="text" name="email" id="botonForm" value="<%=rs.getString(7)%>">
    <label>Email</label>
    </div>
</div>

<div class="form_box2-editar-cliente">
    <!-- EDITAR TELEFONOS -->
    <div style="display: flex;gap: 50px; align-items: baseline; z-index: 99999;">
        <div>
		<div class="dropdown" style="display: block ruby;">  
  <span class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    Teléfonos <ion-icon name="call"  style="margin: 3px;"></ion-icon>
  </span>
  <ul class="dropdown-menu">
    <%
			for (String telefono : listaTelefonos) {
			%>
			<li><input class="dropdown_input" type="text"
				name="vehiculo" value="<%=telefono%>" readonly></li>
			<%
			}
			%>
  </ul>

	   <span id="btn-telefono" style="width: fit-content;" class="button">
		 <a href="../../gestion/telefonos/formNuevoTelefono.jsp?nombre=<%=nombre%>" class="button__text">AÑADIR</a>
		<span class="button__icon">
			<ion-icon name="add-circle"></ion-icon>
		</span>
	</span>
	</div>
	
		<div style="display: flex; width: 100%; gap: 10px; margin-top: 10px;">	
	 <span type="button" class="button">
		 <a href="../../gestion/telefonos/telefonos.jsp?id_cliente=<%=id_cliente%>" class="input-add button__text" style="border:none; background: transparent;">ACTUALIZAR</a>
		
		<span class="button__icon">
			<ion-icon name="reload-circle"></ion-icon>
		</span>
	</span>
	   </div>
</div>

      <!-- EDITAR TELEFONOS -->

      <!-- EDITAR DIRECCIONES -->
    
       <div>
		<div class="dropdown" style="display: block ruby;">
  <span class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    Direcciones <ion-icon name="location" style="margin: 3px;"></ion-icon>
  </span>
  <ul class="dropdown-menu">
     <%
			for (String direccion : listaDirecciones) {
			%>
			<li><input class="dropdown_input" type="text"
				name="vehiculo" value="<%=direccion%>" style="width: fit-content;" readonly></li>
			<%
			}
			%>
  </ul>

	   <span id="btn-direccion" style="width: fit-content;" class="button">
		 <a href="../../gestion/direcciones/formCrearDireccion.jsp?nombre=<%=nombre%>" class="button__text">AÑADIR</a>
		<span class="button__icon">
			<ion-icon name="add-circle"></ion-icon>    
		</span>
	</span>
	</div>
		<div style="display: flex; width: 100%; gap: 10px; margin-top: 10px;">	
	 <span type="button" class="button">
		 <a href="../../gestion/direcciones/direcciones.jsp?id_cliente=<%=id_cliente%>" class="input-add button__text" style="border:none; background: transparent;">ACTUALIZAR</a>
		
		<span class="button__icon">
			<ion-icon name="reload-circle"></ion-icon>
		</span>
	</span>
	   </div>
	
</div>

      <!-- EDITAR DIRECCIONES -->

        <!-- EDITAR VEHICULOS -->    
            
       <div>
		<div class="dropdown" style="display: block ruby;">
  <span class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    Vehículos <ion-icon name="car"  style="margin: 3px;"></ion-icon>
  </span>
  <ul class="dropdown-menu">
 <%
			for (String vehiculo : listaVehiculos) {
			%>
			<li><input class="dropdown_input" type="text"
				name="vehiculo" value="<%=vehiculo%>" readonly></li>
			<%
			}
			%>
  </ul>
  	   <span id="btn-vehiculo" style="width: fit-content;" class="button">
		 <a href="../../gestion/vehiculos/formCrearVehiculo.jsp?nombre=<%=nombre%>" class="button__text">AÑADIR</a>
		<span class="button__icon">
			<ion-icon name="add-circle"></ion-icon>
		</span>
	</span>
	</div>
		<div style="display: flex; width: 100%; gap: 10px; margin-top: 10px;">	
	 <span type="button" class="button">
		 <a href="../../gestion/vehiculos/vehiculos.jsp?id_cliente=<%=id_cliente%>" class="input-add button__text" style="border:none; background: transparent;">ACTUALIZAR</a>
		
		<span class="button__icon">
			<ion-icon name="reload-circle"></ion-icon>
		</span>
	</span>
	   </div>
</div>
  <!-- EDITAR VEHICULOS -->
</div>    
     
</div>

   <div class="cancel-save-boton-editar" style="margin-top: 60px;"> 
       <a href="../../principal/clientes/clientes.jsp" class="boton-cancelar" id="boton-login">
    CANCELAR
  </a>
   <button type="submit" class="btn-guardar" id="botonForm">
  	<span >GUARDAR CAMBIOS</span>
  </button>
     </div>
     
     
</form> 

  
  <!--   <a href="actualizarCliente.jsp?id_cliente=<%= id_cliente %>&nombre=<%=rs.getString(3)%>&apellido=<%=rs.getString(4)%>&cedula=<%=rs.getString(5)%>&email=<%=rs.getString(7)%>"  class="btn-guardar"  id="botonForm">
    GUARDAR
  </a>  -->  

 

<%  } while (rs.next());  %> 



</div>

</div>
</div>
</div>
</main>
</body>
</html>
<%
  
} else {
    out.println("No existen registros con este criterio de búsqueda");
}
%>
