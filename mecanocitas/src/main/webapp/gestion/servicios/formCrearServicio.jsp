<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.Connection" %>


<%String roltoint = session.getAttribute("idrol").toString(); %>
<% if (!("1".equals(roltoint) || "3".equals(roltoint))) { 
out.println("deje de estar inventando");
out.println("<script type=\"text/javascript\">");
out.println("setTimeout(function() { window.location.href = '../../principal/clientes/clientes.jsp'; }, 1000);");
out.println("</script>");}else{ %>
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

<title>MecanoCitas - Nuevo Servicio</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco-editar-cliente" style="height: 335px;width: fit-content;padding-right: 20px;padding-left: 20px;">

<div class="titulo">
<h1 class="titulo-texto">NUEVO SERVICIO</h1>
</div>

<div class="contenido" style="height: 389px;margin-top: -10px;">     

<div style="height: fit-content;">
 <div style="width: fit-content; margin-top: 30px;" class="form_texto">
 <label style="font-size: 18px;">Ingresa un nuevo Servicio</label>
  </div>
</div>
<div class="form_box1-editar-cliente" style="margin-top:0;height: fit-content;">

<form style="margin-top: -40px;" class="form-editar" action="procesar_insercion.jsp" method="post">
    <div class="form_texto">
    <input class="form-crear-input" type="text" name="descripcion" required>
    <label>Descripción</label>
    </div>
  
    <div class="form_texto" >
    <input class="form-crear-input" type="text" name="tiempo" placeholder="00:00:00" required>
    <label>Tiempo</label>
    </div>  
    <div class="form_texto">
    <input class="form-crear-input" type="text" name="valor" placeholder="000.00" required>
    <label>Valor</label>
    </div>
</div>



   <div style="width: 553px; margin: auto;
  justify-content: left;
  display: flex;margin-top: -55px;">
<label style="	font-size: 14px;
	color: #989898;">OBSERVACION:</label>
</div>
 <div style="display: flex; margin: 0; align-items: center;
  justify-content: center;height: fit-content;">
     
     <textarea  style="margin-top: -120px;"  name="observacion" id="observacion" rows="2" cols="60"></textarea>
    </div>



<div class="cancel-save-boton-editar" style="margin-top: -75px;"> 
	<a href="servicios.jsp" class="boton-cancelar" id="boton-login">
    CANCELAR
  </a>
       <button type="submit" class="btn-guardar" id="botonForm">
  	<span >GUARDAR</span>
  </button>
</div>

</form>

</div>
</div>
</div>

</main>
</body>
</html>

<%}%>