<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>


<%
String id_cliente = "";
id_cliente = (session.getAttribute("id_cliente") != null) ? session.getAttribute("id_cliente").toString() : "0";

String nombre = (request.getParameter("nombre") != null) ? request.getParameter("nombre") : "";
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

<title>MecanoCitas - Nueva Dirección</title>

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
<h1 class="titulo-texto">NUEVA DIRECCIÓN</h1>
</div>

<div style="margin-top: 20px;" class="form_crear">

<div>
 <div style="width: fit-content; margin-top: -20px;" class="form_texto">
 <label style="font-size: 18px;">Ingresa la nueva direccion para <b> <%= nombre %> </b></label>
  </div>
</div>

<div class="form_box1">

<form style="margin-top:-50px;" class="form" action="procesar_insercion.jsp" method="post">

    <div class="form_texto" >
    <input type="text" name="provincia" required>
    <label>Provincia</label>
    </div>  
    <div class="form_texto">
    <input type="text" name="distrito" required>
    <label>Distrito</label>
    </div>
    <div class="form_texto">
    <input type="text" name="corregimiento">
    <label>Corregimiento</label>
    </div>
    <div class="form_texto">
    <input type="text" name="barriada">
    <label>Barriada</label>
    </div>

    </div>
    
    <div style="display: flex; margin-top: -70px;"> 
    <a class="btn-guardar" id="boton-login">
    <input class="btn-guardar" type="submit" value="AGREGAR" style="border: none; outline: none;">
    </a> 
</div>

</form>

</div>
</div>
</div>
</main>
</body>
</html>