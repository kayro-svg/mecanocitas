<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>

<%
String id_direccion = "";
id_direccion = (request.getParameter("id_direccion") != null) ? request.getParameter("id_direccion") : "0"; // consulta en la URL es diferente de null

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
Statement st = conexion.createStatement();

String query="select *"; 
query += " from direccion where id_direccion LIKE '%" + id_direccion + "%'";

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

<title>MecanoCitas - Editar Dirección</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco" style="height: fit-content; width: 830px;">

<div class="titulo">
<h1 class="titulo-texto">EDITAR DIRECCIÓN</h1>
</div>

<div style="margin-top: 20px;" class="form_crear">

<div>
 <div style="width: fit-content; margin-top: -20px;" class="form_texto">
 <label style="font-size: 18px;">Realizar cambios en la siguiente direccion:</label>
  </div>
</div>
<%
    do {
%>
<div class="form_box1">

<form style="margin-top:-50px;" class="form" action="update.jsp" method="post">

	<input type="hidden" name="id_direccion" value="<%= rs.getString(1) %>" required>
	
    <div class="form_texto" >
    <input type="text" name="provincia" value="<%= rs.getString(2) %>" required>
    <label>Provincia</label>
    </div>  
    <div class="form_texto">
    <input type="text" name="distrito" value="<%= rs.getString(3) %>" required>
    <label>Distrito</label>
    </div>
    <div class="form_texto">
    <input type="text" name="corregimiento" value="<%= rs.getString(4) %>" required>
    <label>Corregimiento</label>
    </div>
    <div class="form_texto">
    <input type="text" name="barriada" value="<%= rs.getString(5) %>" required>
    <label>Barriada</label>
    </div>

    </div>
    
    <div style="display: flex; margin-top: -70px;"> 
      	<a href="direcciones.jsp" class="boton-cancelar" id="boton-login">
    CANCELAR
  </a>
    <a class="btn-guardar" id="boton-login">
    <input class="btn-guardar" type="submit" value="GUARDAR CAMBIOS" style="border: none; outline: none;">
    </a> 
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