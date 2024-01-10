<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.sql.Connection"%>
	
	   <%@include file="../../connect.jsp"  %> 
	    
<%
session.removeAttribute("id_cliente");
	
String id_cita = ""; //declaracion de la variable 'descripcion' de tipo string 
id_cita = (request.getParameter("id_cita") != null) ? request.getParameter("id_cita") : ""; //Valida que el nombre que viene por la url no sea NULL y le asigna un espacio en blanco " "

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);//objeto que realiza la conexion a la base de datos

Statement sql = conexion.createStatement();


CallableStatement cs = conexion.prepareCall("{CALL ObtenerCitasFechaActual}");
ResultSet rs = cs.executeQuery();


if (rs.next()) {	 
	
	
	rs = cs.executeQuery();
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

<title>MecanoCitas - Citas</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<main class="contenedor">

		<%
		// Ejemplo: Obtener el m�dulo activo de la sesi�n
		Integer moduloActivo = (Integer) session.getAttribute("moduloActivo");
		if (moduloActivo == null) {
			moduloActivo = 2; // Valor predeterminado o l�gica para manejar cuando no est� definido
		}
		%>
		<!-- MENU LATERAL -->
		<%@include file="../../estilos-crud/menulateral.jsp"%>
		<!-- MENU LATERAL -->

		<!-- LINKS EXTERNOS Y CRUD -->
		<div>
			<div class="links">

				<ul class="lista-horizontal-sup-izq">

					<li>
						<div class="link">
							<img class="link-icon" alt=""
								src="../../public/mecanicos-icon.png" /> <a
								href="../../gestion/mecanicos/mecanicos.jsp">Mecánicos</a>
						</div>
						<div class="link-subrayado"></div>

					</li>

					<li>
						<div class="link">
							<img class="link-icon" alt="" src="../../public/car@2x.png" /> <a
								href="../../gestion/vehiculos/vehiculos.jsp">Vehículos</a>
						</div>
						<div class="link-subrayado"></div>

					</li>
				</ul>

				<ul class="lista-horizontal-sup-salir">

					<li style="margin-left: 10px;">
						<div class="link">
							<img class="link-icon" alt=""
								src="../../public/logout@2xBlack.png"
								style="width: 25.06px; margin-right: -6px;" /> <a
								href="../salir/salir.jsp">SALIR</a>
						</div>
						<div class="link-subrayado"></div>

					</li>
				</ul>
			</div>

			<div class="contenido">

				<div class="parte-superior">
					<div class="titulo-proceso">
					<img alt="" src="../../public/citas.png"
						style="width: 50px; height: 50px; margin: 0;" />
					<h1>CITAS</h1>
					</div>
					
					<div class="linea-contenido"></div>
					
						<div class="nuevo-y-buscar">

					<a class="nuevo-boton" href="../clientes/clientes.jsp"> NUEVA
						CITA<img class="icon" src="../../public/plus@2x.png"
						style="width: 60.06px; height: 30px;">
					</a>
					
					<form class="barra-buscar" action="citas.jsp" method="get">
						<input type="text" placeholder="BUSCAR" name="descripcion">
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
      <th scope="col">#</th>
      <th scope="col">Cliente</th>
      <th scope="col">Cédula</th>
      <th scope="col">Vehículo</th>
       <th scope="col">Observación</th>
        <th scope="col">Mecánico</th>
         <th scope="col">Fecha</th>
          <th scope="col">Estado</th>
           <th scope="col">Editar</th>
          
    </tr>
  </thead>
  
    <tbody class="table-group-divider"> 
    
  <%
			while (rs.next())
			{
				String vehiculos = rs.getString("vehiculo");
				String[] listaVehiculos = (vehiculos != null) ? vehiculos.split(",") : new String[]{"No disponible"};
				
			%>
			<tr id="filas">
				<th scope="row"><%=rs.getString(1)%></th>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getString(3)%></td>
								<td>
		<div class="dropdown">
			<a class="btn-custom btn-secondary dropdown-toggle" href="#"
				role="button" data-bs-toggle="dropdown" aria-expanded="false">
				Ver Vehiculos </a>

					<ul class="dropdown-menu">
					<% 

					
					for (String vehiculo : listaVehiculos) { %>
                                        <li><a class="dropdown-item" href="#"><%= vehiculo %></a></li>
                                    <% } %>
			</ul>
		</div>
		</td>
				<td><%=rs.getString(5)%></td>
				<td><%=rs.getString(6)%></td>
				<td><%=rs.getString(7)%></td>
				<td><b><%=rs.getString(8)%></b></td>
<td>
    <a href="formEditarCita.jsp?id_citas=<%=rs.getString(1)%>">
        <img class="link-icon" id="editar" src="../../public/edit@2x.png">
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
	} else {
		 out.println("No existen criterios con esta busqueda");
	        out.println("<script type=\"text/javascript\">");
	        out.println("setTimeout(function() { window.location.href = 'citas.jsp'; }, 1000);");
	        out.println("</script>");
	} 
	%>
	
			</div>
		</div>

	</main>
</body>
</html>