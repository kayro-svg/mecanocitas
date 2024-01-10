<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>

<%
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

<title>MecanoCitas - Nuevo Vehículo</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco-editar-cliente" style="width: fit-content;">

<div class="titulo">
<h1 class="titulo-texto">NUEVO VEHÍCULO</h1>
</div>

<div class="contenido">
<div>
 <div style="width: fit-content; margin-top: 30px;" class="form_texto">
 <label style="font-size: 18px;">Ingresa un nuevo vehículo para <b> <%= nombre %> </b></label>
  </div>
</div>
<div class="form_box1-editar-cliente" style="margin-top: -92px;">

<form style="gap: 0;" class="form-editar" action="procesar_insercion.jsp" method="post">


    <div class="form_texto">
    <input class="form-crear-input" type="text" name="matricula" required>
    <label>Matrícula</label>
    </div>
    <div class="form_texto" >
    <input class="form-crear-input" type="text" name="serieVin" required>
    <label>Serie VIN</label>
    </div>  
    <div class="form_texto">
    <input class="form-crear-input" type="text" name="marca">
    <label>Marca</label>
    </div>
</div>

<div class="form_box2-editar-cliente" style="gap: 0;margin-top: -95px;">

   
  <div class="form_texto">
    <input class="form-crear-input" type="text" name="modelo">
    <label>Modelo</label>
    </div>

  <div class="form_texto">
    <input class="form-crear-input" type="text" name="color">
    <label>Color</label>
    </div>
  
  <div class="form_texto">
    <select class="form-crear-input" name="año" id="año" required style="background: transparent;">
        <option value="año" disabled selected>Selecciona un año</option>
    </select>
    <label>Año</label>
</div>


</div>

<div class="cancel-save-boton-editar" style="margin-top: -106px;"> 
       <button type="submit" class="btn-guardar" id="botonForm">
  	<span >AGREGAR</span>
  </button>
</div>

</form>

</div>
</div>
</div>

</main>

<script>
    // Obtener el elemento select
    var selectYear = document.getElementById("año");

    // Obtener el año actual
    var currentYear = new Date().getFullYear();

    // Generar opciones de años (desde el año actual hasta 100 años atrás)
    for (var i = currentYear; i >= currentYear - 100; i--) {
        var option = document.createElement("option");
        option.value = i;
        option.text = i;
        selectYear.appendChild(option);
    }
</script>

</body>
</html>
