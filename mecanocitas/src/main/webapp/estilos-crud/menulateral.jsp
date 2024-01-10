<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 

session.getAttribute("idrol");

Object idrolObj = session.getAttribute("idrol");

// Verificar si la variable de sesión idrol es null o no es una cadena (String)
if (idrolObj == null || !(idrolObj instanceof String) || ((String) idrolObj).isEmpty()) {
 response.sendRedirect("../../login/login.jsp");
 return; // Finaliza la ejecución del código actual para evitar la renderización del contenido restante
}

String roltoint = session.getAttribute("idrol").toString();



%>
<!DOCTYPE html>
<html>

<link rel="stylesheet" href="../../estilos-crud/menulateral.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700&display=swap" />

<head>
<meta charset="ISO-8859-1">
</head>
<body>
<!-- FRAGMENTO HTML Y JSP PARA MENU LATERAL IZQUIERDO -->
	<div class="barra-lateral">  

		<div class="menu-encabezado">
			<img class="logo" alt="" src="../../public/logo-mecanocitas@2x.png" />
		</div>
		<div class="linea"></div>
		<div class="usuario-data">

			<h2><%out.println("" + session.getAttribute("fullname") + "<br>");%></h2>
			<h3><%out.println("" + session.getAttribute("rolDescription") + "<br>");%></h3>
			<%session.getAttribute("user"); %>
		</div>
		<div class="linea"></div>

	
		<ul class="menu-lista">
			<!--  <li><a href="#"> <img class="icon" id="list-icon" src="../../public/staff@2x.png"> Gestionar Usuario</a></li> -->
			<li class="<%=(moduloActivo == 1) ? "modulo-activo" : ""%>">
			<a href="../../principal/clientes/clientes.jsp">
			<img class="icon" id="list-icon" src="../../public/client-management@2x.png">
			Gestionar Clientes
			</a> 
			</li>
			
			<li class="<%=(moduloActivo == 2) ? "modulo-activo" : ""%>">
			<a href="../../principal/citas/citas.jsp">
			<img class="icon" id="list-icon" src="../../public/icono@2x.png">
			Gestionar Citas
			</a>
			</li>
			
			<li class="<%=(moduloActivo == 3) ? "modulo-activo" : ""%>">
			<a href="../../principal/ordentaller/ordentaller.jsp">
			<img class="icon" id="list-icon" src="../../public/create-order@2x.png">
			Ordenes Taller
			</a>
			</li>
			
			<li class="<%=(moduloActivo == 4) ? "modulo-activo" : ""%>"<% if (!roltoint.equals("1")) { %> style="display:none;"<%} %>>
			<a href="../../gestion/usuarios/usuarios.jsp">
			<img class="icon" id="list-icon" src="../../public/usuarios-lateral.png">
			Gestionar Usuarios
			</a>
			</li>
			
		</ul>
	</div>
</body>
</html>