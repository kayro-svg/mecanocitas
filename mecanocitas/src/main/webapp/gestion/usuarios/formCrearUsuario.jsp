<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@include file="../../connect.jsp"  %>

		
<%
String roltoint = session.getAttribute("idrol").toString();
Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);//objeto que realiza la conexion a la base de datos

Statement sql = conexion.createStatement();
//Obtener la lista de estados
	String queryRoles = "SELECT id_rol, descripcion FROM roles WHERE id_rol IN (1, 3, 4)";
	ResultSet rsRoles = conexion.createStatement().executeQuery(queryRoles);

%>
		<% if (!("1".equals(roltoint) || "1".equals(roltoint))) { 
	out.println("deje de estar inventando");
	out.println("<script type=\"text/javascript\">");
	out.println("setTimeout(function() { window.location.href = '../../principal/clientes/clientes.jsp'; }, 1000);");
	out.println("</script>");}else{ %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="initial-scale=1, width=device-width" />

<link rel="stylesheet" href="../../estilos-crud/formularios.css" />
<link rel="stylesheet" href="../../estilos-crud/estilo_global.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700&display=swap" />
<link rel="icon" type="image/x-icon" href="../../favicon/favicon.png">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<title>MecanoCitas - Nuevo Usuario</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco" style="height: fit-content;">

<div class="titulo">
<h1 class="titulo-texto">NUEVO USUARIO</h1>
</div>

<div class="form_crear">

<div class="form_box1" style="margin-top: 0;display: flex;">

<form class="form" action="procesar_insercion.jsp" method="post" style=" justify-content: space-between;
margin-right: 89px;margin-left: 61px;align-items: center; margin-top: -18px;">

	<div style="width: 400px;">

    <div class="form_texto" style="margin-bottom: 22px;">
    <input type="text" name="username" id="username">
    <label>Username</label>
    </div>
      <div class="form_texto" style="margin-bottom: 22px;">
    <input type="text" name="contrasena" id="contrasena">
    <label>Contraseņa</label>
    </div>
    <div class="form_texto" >
    <input type="text" name="nombre" id="nombre">
    <label>Nombre</label>
    </div>  
    <div class="form_texto">
    <input type="text" name="apellido" id="apellido">
    <label>Apellido</label>
    </div>

	</div>


    	<div class="form form_texto-estado form_texto" style="display: flex; width: fit-content;">
    <label class="label" style="display: flex; align-items: center;">Asignar un Rol:</label>        
        <select class="nuevo-boton" name="id_rol" required id="id_rol" style="width:fit-content !important; padding: 7px; border:none;padding-bottom: 3px;padding-top: 0;">
            <% while (rsRoles.next()) { %>
                <option value="<%= rsRoles.getString("id_rol") %>">
                    <%= rsRoles.getString("descripcion") %>
                </option>
            <% } %>
        </select>
</div>
    

    </div>
    
    <div style="display: flex;margin-bottom: 20px;"> 
	<a href="usuarios.jsp" class="boton-cancelar" id="boton-login">
    CANCELAR
  </a>
    <a class="btn-guardar" id="boton-login">
    <input class="btn-guardar" type="submit" value="GUARDAR" style="border: none; outline: none;">
    </a> 
	</div>

</form> 


</div>
</div>
</div>
</main>
</body>
</html>
<% }%>