<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.sql.Connection"%>
	
	   <%@include file="../../connect.jsp"  %> 
	
	<%
	
	String username = ""; //declaracion de la variable 'descripcion' de tipo string 
	username = (request.getParameter("username") != null) ? request.getParameter("username") : ""; //Valida que el nombre que viene por la url no sea NULL y le asigna un espacio en blanco " "
	Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);//objeto que realiza la conexion a la base de datos

Statement sql = conexion.createStatement();


String query = "SELECT " + "u.username, " + "u.contrasena, " + "u.nombre, " + "u.apellido, " + "r.descripcion AS rol " +
        "FROM " + "Usuario u " +
        "LEFT JOIN " + "Roles r ON u.id_rol = r.id_rol " +
        "WHERE " + "u.username LIKE '%" + username + "%'";
//out.println(query);

ResultSet rs = sql.executeQuery(query);

if (rs.next()) {	 
	

	rs = sql.executeQuery(query); 
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

<title>MecanoCitas - Usuarios</title>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<main class="contenedor">

		<%
		// Ejemplo: Obtener el módulo activo de la sesión
		Integer moduloActivo = (Integer) session.getAttribute("moduloActivo");
		if (moduloActivo == null) {
			moduloActivo = 4; // Valor predeterminado o lógica para manejar cuando no está definido
		}
		%>
		<!-- MENU LATERAL -->
		<%@include file="../../estilos-crud/menulateral.jsp"%>
		<!-- MENU LATERAL -->
		<%if (roltoint.equals("1")) { 
		
		
		%>

		<!-- LINKS EXTERNOS Y CRUD -->
		<div>
			<div class="links">

				<ul class="lista-horizontal-sup-izq">

		
				</ul>

				<ul class="lista-horizontal-sup-salir">

					<li style="margin-left: 10px;">
						<div class="link">
							<img class="link-icon" alt=""
								src="../../public/logout@2xBlack.png"
								style="width: 25.06px; margin-right: -6px;" /> <a
								href="../../login/login.jsp">SALIR</a>
						</div>
						<div class="link-subrayado"></div>

					</li>
				</ul>
			</div>


			<div class="contenido">

				<div class="parte-superior">
					<div class="titulo-proceso">
					<img alt="" src="../../public/usuarios.png"
						style="width: 50px; height: 50px; margin: 0;" />  
					<h1>USUARIOS</h1>
					</div>
					
					<div class="linea-contenido"></div>
					
						<div class="nuevo-y-buscar">

					<a class="nuevo-boton" href="formCrearUsuario.jsp"> NUEVO USUARIO
					<img class="icon" src="../../public/plus@2x.png"
						style="width: 60.06px; height: 30px;">
					</a>

					<form class="barra-buscar" action="clientes.jsp" method="get">
						<input type="text" name="nombre" placeholder="BUSCAR" >
						<button type="submit" class="icono-buscar">
							<!--&#128269;-->
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
								style="fill: rgba(67, 67, 67, 1); transform:; msFilter:;">
								<path d="M19.023 16.977a35.13 35.13 0 0 1-1.367-1.384c-.372-.378-.596-.653-.596-.653l-2.8-1.337A6.962 6.962 0 0 0 16 9c0-3.859-3.14-7-7-7S2 5.141 2 9s3.14 7 7 7c1.763 0 3.37-.66 4.603-1.739l1.337 2.8s.275.224.653.596c.387.363.896.854 1.384 1.367l1.358 1.392.604.646 2.121-2.121-.646-.604c-.379-.372-.885-.866-1.391-1.36zM9 14c-2.757 0-5-2.243-5-5s2.243-5 5-5 5 2.243 5 5-2.243 5-5 5z"></path>
							</svg>
						</button>
					</form>

				</div>
	</div>

				 
		<div class="crud">
		
		<div class="tabla-container">
		
	<table class="table" id="tabla">
  <thead class="columnas">
    <tr>
     <!--   <th scope="col">#</th>
      <th scope="col">Cliente</th>
      <th scope="col">Cédula</th>
      <th scope="col">Vehículo</th>
       <th scope="col">Observación</th>
        <th scope="col">Mecánico</th>
         <th scope="col">Fecha</th>
          <th scope="col">Estado</th>
           <th scope="col">Editar</th>
             <th scope="col">Eliminar</th> -->

             
             	<th scope="col">Usuario</th>

				<th scope="col">Contraseña</th>

				<th scope="col">Nombre</th>

				<th scope="col">Apellido</th>
				
				<th scope="col">Rol</th>	
						
				<th scope="col">Editar</th>

				<th scope="col">Eliminar</th>
             
             
    </tr>
  </thead>
  
    <tbody class="table-group-divider">  
    
    <%
			while (rs.next())
			{	
			%>
			<tr id="filas">
				<th scope="row"><%=rs.getString(1)%></th>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getString(3)%></td>
				<td><%=rs.getString(4)%></td>
				<td><%=rs.getString(5)%></td>


			
				
<td>
    <a href="editarusuario.jsp?username=<%=rs.getString(1)%>">
        <img class="link-icon" id="editar" src="../../public/edit@2x.png">
    </a>
</td>
				<td><a href="eliminarUsuario.jsp?username=<%=rs.getString(1)%>"> <img class="link-icon"
						id="eliminar" src="../../public/remove@2x.png">
				</a>
				</td>
								<!--  	<td><a href=modbanco.jsp?idbanco=//rs.getString(1)%>>Modificar</a></td>
				<td><a href=eliminarbanco.jsp?idbanco=//rs.getString(1)%>>Eliminar</a></td> -->
			</tr>
  </tbody>
	<%
			}
			%>
	</table>
	</div>

	<%
	}else {
	out.println("No existen registros con este Criterio de Búsqueda ");
	  response.sendRedirect("../../principal/clientes/clientes.jsp"); // Reemplaza "/ruta/de/tu/pagina.jsp" con la ruta correcta
	}}

  

	%>
		</div>
				</div>
			</div>
	</main>
</body>
</html>