<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>


<%@include file="../../connect.jsp"  %>


<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- jQuery UI -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<%
String id_telefono = "";
id_telefono = (request.getParameter("id_telefono") != null) ? request.getParameter("id_telefono") : "0"; // consulta en la URL es diferente de null

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
Statement st = conexion.createStatement();

String query="select id_telefono, descripcion"; 
query += " from telefono where id_telefono LIKE '%" + id_telefono + "%'";

ResultSet rs = st.executeQuery(query);

if (rs.next()) {
	
%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<%
    do {
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

<title>MecanoCitas - Editar Telefono</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco" style="height: 235px; max-width: 600px;">

<div class="titulo">
<h1 class="titulo-texto">EDITAR TELEFONO</h1>  
</div>

<div class="contenido" style="height:265px;">

<div class="form_box1" style="margin-top: 30px;">

  	<form class="form" action="update.jsp" method="post" >   
							<input type="hidden" name="id_telefono"
										value="<%= rs.getString(1) %>" readonly>
										
										<div class="form_texto" style="width:280px;text-align: center;">
										<label style="text-align: center;">Editar el siguiente numero de telefono:</label>  
											<input style="width:200px; font-size: 25px; text-align: center;" type="text" name="descripcion"
												value="<%= rs.getString(2) %>" required>
										</div>
								</div>

<div class="cancel-save-boton" style="margin-top: -56px; width: 100%;"> 
  	<a href="telefonos.jsp" class="boton-cancelar" id="boton-login">
    CANCELAR
  </a>
   <button type="submit" class="btn-guardar" id="botonForm">
  	<span >GUARDAR CAMBIOS</span>
  </button>
</div>

  </form>
  
  
</div>
</div>
</div>

</main>
</body>
</html>

<%
    } while (rs.next());
%>

<%
} else {
    out.println("No existen registros con este criterio de búsqueda");
}
%>
</body>
</html>