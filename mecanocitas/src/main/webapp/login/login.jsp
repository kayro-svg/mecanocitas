<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%

session.removeAttribute("usuario");
session.removeAttribute("fullname");
session.removeAttribute("rolDescription");
session.removeAttribute("idrol");
session.removeAttribute("user");


String username = null;
String contrasena = null;

%>



<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<html>
<link rel="stylesheet" href="login.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;800&display=swap" />
	<link rel="icon" type="image/x-icon" href="../favicon/favicon.png">
<head>
<meta charset="ISO-8859-1">
<title>MecanoCitas - Inicio de Sesión</title>
</head>
<body>
	<main class="inicio-de-sesion" id="login">
	
	
	
	<div class="content">


	<div style="margin: auto;margin-right: 50px;">
		<img class="logo-mecanocitas-icon" alt=""
			src="../public/logo-mecanocitas@2x.png" />

		<div class="titulo">
			<h2>Iniciar Sesión</h2>
		</div>
		<div class="titulo-child"></div>

	
		<form class="form" action="../menu/menu.jsp" method="post">
		
			<div style="margin-top: 30px; margin-bottom: 10px;">
			<input class="usuario" type="text" name="username" id="username"
				placeholder="Usuario" /> <br />
				</div>
			<div  style="margin-top: 10px; margin-bottom: 10px;">
			<input class="contrasena" type="password" name="contrasena" id="contrasena"
				placeholder="Contraseña" /> <br />
			</div>
			<div  style="margin-top: 20px; margin-bottom: 10px;">
				<input class="boton" id="boton-login"
				type="submit" value="ENTRAR" name="submit" />
			</div>
		</form> 
		</div>
		
		</div>

	</main>
</body>
</html>

 
