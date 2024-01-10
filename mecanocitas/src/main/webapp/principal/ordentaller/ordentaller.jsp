<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@page import="java.sql.Connection"%>
	
	   <%@include file="../../connect.jsp"  %> 
	<%
	session.removeAttribute("id_cliente");
	
	String user ="";
	user= (request.getParameter("user") != null) ? request.getParameter("user") : "";

	String id_ordentaller = ""; //declaracion de la variable 'descripcion' de tipo string 
	id_ordentaller = (request.getParameter("id_ordentaller") != null) ? request.getParameter("id_ordentaller") : ""; //Valida que el nombre que viene por la url no sea NULL y le asigna un espacio en blanco " "
	
	String matricula = ""; //declaracion de la variable 'descripcion' de tipo string 
	matricula = (request.getParameter("v.matricula") != null) ? request.getParameter("v.matricula") : ""; //Valida que el nombre que viene por la url no sea NULL y le asigna un espacio en blanco " "
	
	
	Class.forName("com.mysql.jdbc.Driver");

	Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);//objeto que realiza la conexion a la base de datos

	Statement sql = conexion.createStatement();

	
	// Obtener la lista de estados
	String queryEstados = "SELECT id_estado, descripcion FROM Estado";
	ResultSet rsEstados = conexion.createStatement().executeQuery(queryEstados);
	
	String query = "SELECT ot.id_orden, ";
	query += "(SELECT CONCAT(m.nombre, ' ', m.apellido) FROM Mecanico m WHERE m.id_mecanico = ot.id_mecanico) AS mecanico, ";
	query += "(SELECT CONCAT(v.modelo, ' - ', v.matricula) FROM Vehiculo v WHERE v.id_vehiculo = ot.id_vehiculo) AS vehiculo, ";
	query += "(SELECT GROUP_CONCAT(s.descripcion) FROM servicio s WHERE s.id_servicio IN (SELECT id_servicio FROM OrdenServicio os WHERE os.id_orden = ot.id_orden)) AS servicio, ";
	query += "(SELECT GROUP_CONCAT(r.descripcion) FROM repuesto r WHERE r.id_repuesto IN (SELECT id_repuesto FROM OrdenRepuesto orp WHERE orp.id_orden = ot.id_orden)) AS repuesto, ";
	query += "(SELECT GROUP_CONCAT(h.descripcion) FROM herramienta h WHERE h.id_herramienta IN (SELECT id_herramienta FROM OrdenHerramienta oh WHERE oh.id_orden = ot.id_orden)) AS herramienta, ";
	query += "ot.fecha, ot.fecha_entrega, ";
	query += "(SELECT e.descripcion FROM Estado e WHERE e.id_estado = ot.id_estado) AS estado ";
	query += " FROM OrdenTaller ot ";
	
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

<title>MecanoCitas - Orden de Taller</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<main class="contenedor">

		<%
		// Ejemplo: Obtener el módulo activo de la sesión
		Integer moduloActivo = (Integer) session.getAttribute("moduloActivo");
		if (moduloActivo == null) {
			moduloActivo = 3; // Valor predeterminado o lógica para manejar cuando no está definido
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
						<div class="link"<% if (!("1".equals(roltoint) || "3".equals(roltoint))) { %> style="display:none;"<% } %>>
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
					
				
					<li>
						<div class="link"<% if (!("1".equals(roltoint) || "3".equals(roltoint))) { %> style="display:none;"<% } %>>
							<img class="link-icon" alt="" src="../../public/service@2x.png" /> <a
								href="../../gestion/servicios/servicios.jsp">Servicios</a>
						</div>
						<div class="link-subrayado"></div>

					</li>
					
										
						<li>
						<div class="link"<% if (!("1".equals(roltoint) || "3".equals(roltoint))) { %> style="display:none;"<% } %>>
							<img class="link-icon" alt="" src="../../public/automotive@2x.png" /> <a
								href="../../gestion/repuestos/repuestos.jsp">Repuestos</a>
						</div>
						<div class="link-subrayado"></div>

					</li>
					
					<li>
						<div class="link"<% if (!("1".equals(roltoint) || "3".equals(roltoint))) { %> style="display:none;"<% } %>>
							<img class="link-icon" alt="" src="../../public/tools1@2x.png" /> <a
								href="../../gestion/herramientas/herramientas.jsp">Herramientas</a>
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
								href="../../login/login.jsp">SALIR</a>
						</div>
						<div class="link-subrayado"></div>

					</li>
				</ul>
			</div>


			<div class="contenido">

				<div class="parte-superior">
					<div class="titulo-proceso"  style="justify-content: space-between;">
					<div style="display: flex;">
					<img alt="" src="../../public/create-order.png"
						style="width: 50px; height: 50px; margin: 0;" />
					<h1>ORDEN DE TALLER</h1>
					</div>
					
			
					
					</div>
					
					<div class="linea-contenido"></div>
					
						<div class="nuevo-y-buscar">

					<a class="nuevo-boton" href="clientesorden.jsp"<% if (!("1".equals(roltoint) || "3".equals(roltoint))) { %> style="display:none;"<% } %>> NUEVA
						ORDEN<img class="icon" src="../../public/plus@2x.png"
						style="width: 60.06px; height: 30px;">
					</a>
					
						<div class="form form_texto-estado form_texto" style="display: flex;">
    <label class="label" style="display: flex; align-items: center;">Buscar por:</label>        
    <form class="nuevo-boton"  id="redireccionForm" action="ordenPorEstado.jsp" method="post" style="width:fit-content !important; padding: 5px; margin-left: 7px;">
        <select class="nuevo-boton" name="id_estado" required id="id_estado" onchange="this.form.submit()" style="width:fit-content !important; padding: 0px; border:none;">
            <% while (rsEstados.next()) {  %>
                <option value="<%= rsEstados.getString("id_estado") %>">
                    <%= rsEstados.getString("descripcion") %>
                </option>
            <% } %>
        </select>
    </form>
</div>
		
			
				</div>
				
				</div>
				<div class="crud">
	<div class="tabla-container">
	<table class="table" id="tabla">
  <thead class="columnas">
    <tr>
      <th scope="col">#</th>
      <th scope="col">Mécanico</th>
      <th scope="col">Vehículo</th>
      <th scope="col">Servicio</th>
       <th scope="col">Repuestos</th>
        <th scope="col">Herramientas</th>
         <th scope="col">F. Inicio</th>
         <th scope="col">F.Entrega</th>
          <th scope="col">Estado</th>
           <th scope="col"<% if (!("1".equals(roltoint) || "3".equals(roltoint))) { %> style="display:none;"<% } %>>Editar</th>
              
    </tr>
  </thead>
  <tbody class="table-group-divider"> 
      
      <%
			while (rs.next())
			{
				
			String servicios = rs.getString("servicio");
			String[] listaServicios = (servicios != null) ? servicios.split(",") : new String[]{"No disponible"};

            String repuestos = rs.getString("repuesto");
            String[] listaRepuestos = (repuestos != null) ? repuestos.split(",") : new String[]{"No disponible"};
            
            String herramientas = rs.getString("herramienta");
            String[] listaHerramientas = (herramientas != null) ? herramientas.split(",") : new String[]{"No disponible"};
            
            String mecanico = rs.getString("mecanico");
            
         
            
            String vehiculo = rs.getString("vehiculo");
           
			%> 
    
   <tr id="filas">
				<th scope="row"><%=rs.getString(1)%></th>
				<td><%=mecanico%></td>
				<td><%= vehiculo %></td>
						<td>
				
		<div class="dropdown">
			<a class="btn-custom btn-secondary dropdown-toggle" href="#"
				role="button" data-bs-toggle="dropdown" aria-expanded="false">
				Ver Servicios </a>

					<ul class="dropdown-menu">
					<% 
					for (String servicio : listaServicios) { %>
                    <li><a class="dropdown-item" href="#"><%= servicio %></a></li>
                     <% } %>
			</ul>
		</div>
		</td>
					  <td>
				
		<div class="dropdown">
			<a class="btn-custom btn-secondary dropdown-toggle" href="#"
				role="button" data-bs-toggle="dropdown" aria-expanded="false">
				Ver Repuestos </a>

					<ul class="dropdown-menu">
					<% 
					for (String repuesto : listaRepuestos) { %>
                    <li><a class="dropdown-item" href="#"><%= repuesto %></a></li>
                     <% } %>
			</ul>
		</div>
		</td>
								<td>
				
		<div class="dropdown">
			<a class="btn-custom btn-secondary dropdown-toggle" href="#"
				role="button" data-bs-toggle="dropdown" aria-expanded="false">
				Ver Herramientas </a>

					<ul class="dropdown-menu">
					<% 
					for (String herramienta : listaHerramientas) { %>
                    <li><a class="dropdown-item" href="#"><%= herramienta %></a></li>
                     <% } %>
			</ul>
		</div>
		</td>
				<td><%=rs.getString(7)%></td>
				<td><%=rs.getString(8)%></td>
				<td><b style="text-transform: uppercase;"><%= rs.getString("estado") %></b></td>
						
			
				
<td<% if (!("1".equals(roltoint) || "3".equals(roltoint))) { %> style="display:none;"<% } %>>
    <a href="formEditarOrden.jsp?id_orden=<%=rs.getString(1)%>">
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
		
	out.println("No existen registros con este Criterio de Búsqueda ");
	}

	%>
			</div>
		</div>

	</main>
	
</body>
</html>