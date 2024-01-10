<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="../../connect.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.Connection" %>

<%
    String id_cita = "";
id_cita = (session.getAttribute("id_cita") != null) ? session.getAttribute("id_cita").toString() : "0";

    String observacion = request.getParameter("observacion");
    String id_vehiculo = request.getParameter("id_vehiculo");
    String id_mecanico = request.getParameter("id_mecanico");
    String fecha = request.getParameter("fecha");
    String id_estado = request.getParameter("id_estado");
	String username = request.getParameter("username");

    Class.forName("com.mysql.jdbc.Driver");
    Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

    // Insertar el nuevo vehiculo
    String queryInsertCita = "INSERT INTO citas (username, id_vehiculo, observacion, id_mecanico, fecha, id_estado) VALUES (?,?, ?, ?, ?, ?)";
    PreparedStatement stmtInsertCita = conexion.prepareStatement(queryInsertCita, Statement.RETURN_GENERATED_KEYS);
    
    stmtInsertCita.setString(1, username);
    stmtInsertCita.setString(2, id_vehiculo);
    stmtInsertCita.setString(3, observacion);
    stmtInsertCita.setString(4, id_mecanico);
    stmtInsertCita.setString(5, fecha);
    stmtInsertCita.setString(6, id_estado);
   
    stmtInsertCita.executeUpdate();

    ResultSet rs = stmtInsertCita.getGeneratedKeys();
    int id_citas = -1;
    if (rs.next()) {
    	
    	id_citas = rs.getInt(1);
    	 
    	  // Insertar en la tabla pivot citasestado
    	    String queryInsertCitasEstado = "INSERT INTO citasestado (id_citas, id_estado) VALUES (?, ?)";
    	    PreparedStatement stmtInsertCitasEstado = conexion.prepareStatement(queryInsertCitasEstado);
    	    stmtInsertCitasEstado.setInt(1, id_citas);
    	    stmtInsertCitasEstado.setString(2, id_estado);
    	    stmtInsertCitasEstado.executeUpdate();
    	    stmtInsertCitasEstado.close();

    	    // Insertar en la tabla pivot citasmecanico
    	    String queryInsertCitasMecanico = "INSERT INTO citasmecanico (id_citas, id_mecanico) VALUES (?, ?)";
    	    PreparedStatement stmtInsertCitasMecanico = conexion.prepareStatement(queryInsertCitasMecanico);
    	    stmtInsertCitasMecanico.setInt(1, id_citas);
    	    stmtInsertCitasMecanico.setString(2, id_mecanico);
    	    stmtInsertCitasMecanico.executeUpdate();
    	    stmtInsertCitasMecanico.close();

    	    // Insertar en la tabla pivot citavehiculo
    	    String queryInsertCitasVehiculo = "INSERT INTO citavehiculo (id_citas, id_vehiculo) VALUES (?, ?)";
    	    PreparedStatement stmtInsertCitasVehiculo = conexion.prepareStatement(queryInsertCitasVehiculo);
    	    stmtInsertCitasVehiculo.setInt(1, id_citas);
    	    stmtInsertCitasVehiculo.setString(2, id_vehiculo);
    	    stmtInsertCitasVehiculo.executeUpdate();
    	    stmtInsertCitasVehiculo.close();
    	 
        stmtInsertCita.close();
        conexion.close(); %>
        
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

        <title>MecanoCitas - Vehiculos</title>

        </head>
        <body>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
        	
        	<main class="contenedor" style="display: flex; align-items: center;"> 
        	
        	<div style="margin: auto; width: fit-content;"> 
        	
    <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
      <symbol id="check-circle-fill" viewBox="0 0 16 16">
        <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
      </symbol>
    </svg>
    <div class="alert alert-success d-flex align-items-center" role="alert" style="width: fit-content;height: 75px;justify-content: center;gap: 15px;">
      <svg style="width: 50px;" class="bi flex-shrink-0 me-2" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
      <div>
        ¡Cita creada Correctamente!
      </div>
    </div>
    </div>

<%
        out.println("<script type=\"text/javascript\">");
        out.println("setTimeout(function() { window.location.href = 'citas.jsp?id_cita=" + id_cita + "'; }, 1000);");
        out.println("</script>");
    } else {
        out.println("Ocurrió un fallo en la inserción de la Cita: " + id_cita);
    }

  
%>

