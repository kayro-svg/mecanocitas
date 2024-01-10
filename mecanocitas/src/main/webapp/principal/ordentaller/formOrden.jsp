<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>


<%@include file="../../connect.jsp"  %>


<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- jQuery UI -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<%
String id_cliente = request.getParameter("id_cliente");

Object idrolObj = session.getAttribute("idrol");

//Verificar si la variable de sesión idrol es null o no es una cadena (String)
if (idrolObj == null || !(idrolObj instanceof String) || ((String) idrolObj).isEmpty()) {
response.sendRedirect("../../login/login.jsp");
return; // Finaliza la ejecución del código actual para evitar la renderización del contenido restante
}



String roltoint = session.getAttribute("idrol").toString();
String user = session.getAttribute("user").toString();



Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

Statement st = conexion.createStatement();
// Obtener la lista de mecánicos
String queryMecanicos = "SELECT id_mecanico, nombre FROM Mecanico";
ResultSet rsMecanicos = conexion.createStatement().executeQuery(queryMecanicos);

// Obtener la lista de vehículos
String queryVehiculos = "SELECT v.id_vehiculo, CONCAT(v.marca, ' - ', v.modelo, ' - ', v.matricula) AS vehiculo " +
                        "FROM Vehiculo v " +
                        "INNER JOIN clienteVehiculo cv ON v.id_vehiculo = cv.id_vehiculo " +
                        "WHERE cv.id_cliente = " + id_cliente;
ResultSet rsVehiculos = st.executeQuery(queryVehiculos);

// Obtener la lista de servicios
String queryServicios = "SELECT id_servicio, descripcion FROM Servicio";
ResultSet rsServicios = conexion.createStatement().executeQuery(queryServicios);

// Obtener la lista de repuestos
String queryRepuestos = "SELECT id_repuesto, descripcion FROM Repuesto";
ResultSet rsRepuestos = conexion.createStatement().executeQuery(queryRepuestos);

// Obtener la lista de herramientas
String queryHerramientas = "SELECT id_herramienta, descripcion FROM Herramienta";
ResultSet rsHerramientas = conexion.createStatement().executeQuery(queryHerramientas);

// Obtener la lista de estados
String queryEstados = "SELECT id_estado, descripcion FROM Estado";
ResultSet rsEstados = conexion.createStatement().executeQuery(queryEstados);
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

<title>MecanoCitas - Nueva Orden</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco" style="height: 330px; max-width: 910px;">

<div class="titulo">
<h1 class="titulo-texto">NUEVA ORDEN</h1>  
</div>

<div class="contenido" style="height: 310px;">

<div class="form_box1" style="margin-top: 10px;">

<form id="botonForm" class="form" action="procesar_insercion.jsp" method="post" style="gap: 85px;" >

 <input type="hidden" name="username" id="username" value="<%=user%>">
 
 
 <!-- SERVICIOS -->
 <div class="form form_texto" style="align-items: center;display: grid;gap: 5px;">
<div class="dropdown">
    <a class="dropdown-btn boton-cancelar" style="width: 188px;background: #444444; font-size: 16px; witdh: 
fit-content">Añadir Servicios</a>
    <div class="dropdown-content">
       
            <% while (rsServicios.next()) { %>
                <input style="width: 20px;" type="checkbox" id="servicio_<%= rsServicios.getString("id_servicio") %>" name="id_servicio" value="<%= rsServicios.getString("id_servicio") %>">
                <label for="servicio_<%= rsServicios.getString("id_servicio") %>"><%= rsServicios.getString("descripcion")%></label><br>
            <% } %>
    </div>
</div>
</div> 
 <!-- SERVICIOS -->
 
  <!-- REPUESTOS -->
<div class="form form_texto" style="align-items: center;display: grid;gap: 5px;">
<div class="dropdown">
    <a class="dropdown-btn boton-cancelar" style="width: 188px;background: #444444; font-size: 16px; witdh: 
fit-content">Añadir Repuestos</a>
    <div class="dropdown-content">
       
            <% while (rsRepuestos.next()) { %>
                <input style="width: 20px;" type="checkbox" id="repuesto_<%= rsRepuestos.getString("id_repuesto") %>" name="id_repuesto" value="<%= rsRepuestos.getString("id_repuesto") %>">
                <label for="repuesto_<%= rsRepuestos.getString("id_repuesto") %>"><%= rsRepuestos.getString("descripcion")%></label><br>
            <% } %>
    </div>
</div>
</div> 
  <!-- REPUESTOS -->
  
  <!-- HERRAMIENTAS -->
<div class="form form_texto" style="align-items: center;display: grid;gap: 5px;">
<div class="dropdown">
    <a class="dropdown-btn boton-cancelar" style="width: 188px;background: #444444; font-size: 16px; witdh: 
fit-content">Añadir Herramientas</a>
    <div class="dropdown-content">
      
            <% while (rsHerramientas.next()) { %>
                <input style="width: 20px;" type="checkbox" id="herramienta_<%= rsHerramientas.getString("id_herramienta") %>" name="id_herramienta" value="<%= rsHerramientas.getString("id_herramienta") %>">
                <label for="herramienta_<%= rsHerramientas.getString("id_herramienta") %>"><%= rsHerramientas.getString("descripcion")%></label><br>
            <% } %>
    
    </div>
</div>
 </div>
  <!-- HERRAMIENTAS -->
    
    </div>	
   
<div class="form_box2" style="padding-left: 0 !important; margin-top:-83px;z-index: 1;">


     <div class="form_texto">
   <!-- Vehículo -->
        <label for="id_vehiculo">Vehículo:</label>
        <select name="id_vehiculo"  required>      
            <%
                while (rsVehiculos.next()) { %>
                    <option value="<%=rsVehiculos.getString("id_vehiculo")%>"><%=rsVehiculos.getString("vehiculo") %></option>
              <% }
            %>
        </select>
        <br>
    </div>

    <div class="form_texto" style="width: 120px;margin-left: 40px;">
     <!-- Mecánico -->
        <label for="id_mecanico">Mecánico:</label>
        <select name="id_mecanico" style="font-size: 16px;" required>
            <%
                while (rsMecanicos.next()) { %>
                    <option value=" <%= rsMecanicos.getString("id_mecanico") %> " > <%=rsMecanicos.getString("nombre") %> </option>
             <% }
            %>
        </select>
        <br> 
    </div>
    
      <div  class="form form_texto-estado form_texto" style="margin-left: -66px;">
     
    <!-- Estado -->
        <label for="id_estado">Estado de la Orden:</label>
        <select name="id_estado" style="font-size: 16px;" required>
            <%  
                while (rsEstados.next()) { %>
                   <option  value=" <%= rsEstados.getString("id_estado")%> "><%= rsEstados.getString("descripcion") %></option>
              <%  } %>
        </select>
    </div>
    
  
   
          <div class="form form_texto" style="margin-left: -16px;">
     <!-- Fecha -->
        <label for="fecha">Fecha de inicio:</label>
        <input type="date" name="fecha" required>
    </div> 
 
  <div class="form form_texto" style="margin-left: -10px;">
 <!-- Fecha de entrega -->
        <label for="fecha_entrega">Fecha de Entrega:</label>
        <input type="date" name="fecha_entrega" required>
    </div> 
    

</div> 

</div>
   <div class="cancel-save-boton"> 
        <a href="clientesorden.jsp" class="boton-cancelar" id="boton-login">CANCELAR</a>
        <button  id="botonForm" type="submit" class="btn-guardar">
            <span>GUARDAR</span>
        </button>
    </div>

</form>


</div>
</div>

<style>
    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
        padding: 10px;
        width: 210px;
    }

    .dropdown-content a {
        padding: 12px 16px;
        display: block;
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }
</style>


</main>

</body>
</html>