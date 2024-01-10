<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
   <%@include file="../connect.jsp"  %>  
   
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="initial-scale=1, width=device-width" />

    <link rel="stylesheet" href="menu.css" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700&display=swap"
    />
    <link rel="icon" type="image/x-icon" href="../favicon/favicon.png">
    <title>MecanoCitas - Menu</title>
  </head>
  <body>
  
<main class="menu-de-opciones-administrador">

<%
String username = request.getParameter("username");
String contrasena = request.getParameter("contrasena");
String id_rol = request.getParameter("id_rol");


Class.forName("com.mysql.jdbc.Driver"); 

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave); // objeto que realiza la conexion a la base de datos

Statement st = conexion.createStatement();

String sql = "SELECT u.username, u.id_rol, u.contrasena, CONCAT(u.nombre, ' ', u.apellido) AS fullname, r.descripcion AS rol_description ";
sql += "FROM usuario u ";
sql += "INNER JOIN roles r ON u.id_rol = r.id_rol "; // Ajusta esta línea según la estructura real de tus tablas
sql += "WHERE u.username = '" + username + "' AND u.contrasena = '" + contrasena + "'";

ResultSet rs = st.executeQuery(sql);

int encontrado = 0;

String name;
String rolDescription;
String idrol;
String user;
while (rs.next()) {
    encontrado = 1;
    name = rs.getString("fullname");
    rolDescription = rs.getString("rol_description");
    idrol = rs.getString("id_rol");
    user = rs.getString("username");
    session.setAttribute("usuario", name);
    session.setAttribute("fullname", name);
    session.setAttribute("rolDescription", rolDescription);
	session.setAttribute("idrol",idrol);
	session.setAttribute("user",user);
	
	
}if (encontrado == 1){
	
	
%>	
<!--  
<ul>
<li><a href="varsesion.jsp" > Variables de Sesion</a> </li>
<li><a href="close.jsp" > Cerrar Sesion</a> </li>
</ul>
-->
<%
	}
	else
	{
		out.println("Usuario No registrado");
		session.invalidate();

		response.sendRedirect("../login/login.jsp");
	}
%>

		<div class="capa-opaca">
			<!-- RECTANGULO OSCURO TRANSPARENTE -->

			<div class="links">

				<ul class="lista-horizontal-sup-izq">

					<li>
						<div>
							<h2 style="margin-top: 10px;">Bienvenido/a <%out.println("" + session.getAttribute("fullname") + "<br>");%></h2>
						</div>
						

					</li>

				

				</ul>

				<ul class="lista-horizontal-sup-salir">

					<li style="margin-left: 10px;">
						<div class="link">
							<img class="link-icon" alt="" src="../public/logout@2x.png" /> <a
								href="../login/login.jsp">SALIR</a>   
						</div>
						<div class="link-subrayado"></div>

					</li>
				</ul>
			</div>
			
			<div class="logo-mecanocitas" >
			<img class="logo" alt=""
				src="../public/logo-mecanocitas--claro-1@2x.png" />
			</div>
			
			
			<!-- BLOQUES DE PROCESOS -->
			
<div class="procesos"> 
	
	<a href="../principal/clientes/clientes.jsp">
	<button class="card">
		 <img class="card-icon" alt="" src="../public/client-management@2x.png"/>
		<h2> CLIENTES</h2>
	   <p> Crear, buscar, actualizar o eliminar clientes.</p>
	</button>
	</a>
	
	  
	<a href="../principal/citas/citas.jsp">
	<button class="card">
		 <img class="card-icon" alt="" src="../public/icono@2x.png" style="padding-top: 0px;"/>
		 <h2>CITAS</h2>
		 <p> Crear, buscar, actualizar o cancelar citas.</p>
	</button> 
	</a>
	
	<a href="../principal/ordentaller/ordentaller.jsp">
	<button class="card">
		 <img class="card-icon" alt="" src="../public/create-order@2x.png" style="padding-top: 8px;padding-left: 5px;padding-bottom: 0px;padding-right: 3px;margin-bottom: 10px;"/>
		 <h2 style="margin-top: -22px;padding-top: 8px;">ORDEN TALLER</h2>
		 <p>Crear, buscar, o cambiar el estado de orden. </p>
	</button> 
	</a>
	
	<a href="../gestion/usuarios/usuarios.jsp" <% if (!session.getAttribute("idrol").equals("1")) { %> style="display:none;"<%} %>>
	<button class="card">
		 <img class="card-icon" alt="" src="../public/usuarios-lateral.png" style="padding-top: 6px;padding-right: 4px;padding-left: 4px;"/>
		 <h2>USUARIOS</h2>
		 <p> Crear, buscar, modificar usuarios.</p> 
	</button> 
	</a>
	 
	<!-- Fin de procesos -->		
			
</div>
			</div>
			

	</main>


   
  </body>
</html>
