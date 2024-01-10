<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>

<%
String id_vehiculo = "";
id_vehiculo = (request.getParameter("id_vehiculo") != null) ? request.getParameter("id_vehiculo") : "0"; // consulta en la URL es diferente de null

String nombre = (request.getParameter("nombre") != null) ? request.getParameter("nombre") : "";

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
Statement st = conexion.createStatement();

String query="select *"; 
query += " from vehiculo where id_vehiculo LIKE '%" + id_vehiculo + "%'";

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

<title>MecanoCitas - Editar Vehículo</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco-editar-cliente" style="width: fit-content;">

<div class="titulo">
<h1 class="titulo-texto">EDITAR VEHÍCULO</h1>
</div>

<div class="contenido" style="height: 219px;">
<%
    do {
%>
<div class="form_box1-editar-cliente" style="margin-top: 23px;">

<form style="gap: 0;" class="form-editar" action="update.jsp" method="post">
    <input class="form-crear-input" type="hidden" name="id_vehiculo" value="<%= rs.getString(1) %>">
    
    <div class="form_texto">
    <input class="form-crear-input" type="text" name="matricula" value="<%= rs.getString(2) %>" required>
    
    <label>Matrícula</label>
    </div>
    <div class="form_texto" >
    <input class="form-crear-input" type="text" name="serieVin" value="<%= rs.getString(3) %>" required>
    <label>Serie VIN</label>
    </div>  
    <div class="form_texto">
    <input class="form-crear-input" type="text" name="marca" value="<%= rs.getString(4) %>">
    <label>Marca</label>
    </div>
</div>
<div class="form_box2-editar-cliente" style="gap: 0;" >

   
  <div class="form_texto">
    <input class="form-crear-input" type="text" name="modelo" value="<%= rs.getString(5) %>">
    <label>Modelo</label>
    </div>

  <div class="form_texto">
    <input class="form-crear-input" type="text" name="color" value="<%= rs.getString(6) %>">
    <label>Color</label>
    </div>
  
  <div class="form_texto">
   <input class="form-crear-input" type="text" name="año" value="<%= rs.getString(7) %>">
    <label>Año</label>
</div>


</div>

<div class="cancel-save-boton-editar" style="margin-top: 55px;"> 
	<a href="vehiculos.jsp" class="boton-cancelar" id="boton-login">
    CANCELAR
  </a>
       <button type="submit" class="btn-guardar" id="botonForm">
  	<span >GUARDAR CAMBIOS</span>
  </button>
</div>

</form>

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