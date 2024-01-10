<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>

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

<title>MecanoCitas - Nuevo Cliente</title>

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
<h1 class="titulo-texto">NUEVO CLIENTE</h1>
</div>

<div class="form_crear">

<div class="form_box1" style="margin-top: 0;">

<form class="form" action="crearCliente.jsp" method="post">

    <div class="form_texto">
    <input type="text" name="nombre" id="nombre">
    <label>Nombre</label>
    </div>
    <div class="form_texto" >
    <input type="text" name="apellido" id="apellido">
    <label>Apellido</label>
    </div>  
    <div class="form_texto">
    <input type="text" name="cedula" id="cedula">
    <label>Cédula</label>
    </div>
    <div class="form_texto">
    <input type="text" name="email" id="email">
    <label>Email</label>
    </div>

    </div>
    
    <div style="display: flex;margin-bottom: 20px;"> 
	<a href="clientes.jsp" class="boton-cancelar" id="boton-login">
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