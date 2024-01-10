<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../connect.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.Connection" %>

<%
String id_cliente = request.getParameter("id_cliente");
    String id_vehiculo = request.getParameter("id_vehiculo");
    String id_mecanico = request.getParameter("id_mecanico");
    String fecha = request.getParameter("fecha");
    String fecha_entrega = request.getParameter("fecha_entrega");
    String id_estado = request.getParameter("id_estado");
    String id_herramienta = request.getParameter("id_herramienta");
    String id_servicio = request.getParameter("id_servicio");
    String id_repuesto = request.getParameter("id_repuesto");
	String username = request.getParameter("username");
    Connection conexion = null;
    PreparedStatement stmtInsertOrden = null;
    PreparedStatement stmtInsertOrdenServicio = null;
    PreparedStatement stmtInsertOrdenRepuesto = null;
    PreparedStatement stmtInsertOrdenHerramienta = null;
    PreparedStatement stmtInsertOrdenEstado = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

        String queryInsertOrden = "INSERT INTO OrdenTaller (username, id_mecanico, id_vehiculo, fecha, fecha_entrega, id_estado) VALUES (?,?, ?, ?, ?, ?)";
        stmtInsertOrden = conexion.prepareStatement(queryInsertOrden, Statement.RETURN_GENERATED_KEYS);

        // Configurar parámetros para la orden de taller
        stmtInsertOrden.setString(1, username);
        stmtInsertOrden.setString(2, id_mecanico);
        stmtInsertOrden.setString(3, id_vehiculo);
        stmtInsertOrden.setString(4, fecha);
        stmtInsertOrden.setString(5, fecha_entrega);
        stmtInsertOrden.setString(6, id_estado);

        int affectedRows = stmtInsertOrden.executeUpdate();

        if (affectedRows > 0) {
        	  ResultSet generatedKeys = stmtInsertOrden.getGeneratedKeys();
            if (generatedKeys.next()) {
            	 int id_orden = generatedKeys.getInt(1);

            	// Insertar en la tabla pivot OrdenServicio
                 String queryInsertOrdenServicio = "INSERT INTO OrdenServicio (id_orden, id_servicio) VALUES (?, ?)";
                 stmtInsertOrdenServicio = conexion.prepareStatement(queryInsertOrdenServicio);
                 String[] servicios = request.getParameterValues("id_servicio");
                 if (servicios != null) {
                     for (String servicio : servicios) {
                         stmtInsertOrdenServicio.setInt(1, id_orden);
                         stmtInsertOrdenServicio.setString(2, servicio);
                         stmtInsertOrdenServicio.executeUpdate();
                     }
                 }

                 // Insertar en la tabla pivot OrdenRepuesto
                 String queryInsertOrdenRepuesto = "INSERT INTO OrdenRepuesto (id_orden, id_repuesto) VALUES (?, ?)";
                 stmtInsertOrdenRepuesto = conexion.prepareStatement(queryInsertOrdenRepuesto);
                 String[] repuestos = request.getParameterValues("id_repuesto");
                 if (repuestos != null) {
                     for (String repuesto : repuestos) {
                         stmtInsertOrdenRepuesto.setInt(1, id_orden);
                         stmtInsertOrdenRepuesto.setString(2, repuesto);
                         stmtInsertOrdenRepuesto.executeUpdate();
                     }
                 }

                 // Insertar en la tabla pivot OrdenHerramienta
                 String queryInsertOrdenHerramienta = "INSERT INTO OrdenHerramienta (id_orden, id_herramienta) VALUES (?, ?)";
                 stmtInsertOrdenHerramienta = conexion.prepareStatement(queryInsertOrdenHerramienta);
           			String[] herramientas = request.getParameterValues("id_herramienta");
			if (herramientas != null) {
				for (String herrmienta : herramientas) {
					stmtInsertOrdenHerramienta.setInt(1, id_orden);
					stmtInsertOrdenHerramienta.setString(2, id_herramienta);
					stmtInsertOrdenHerramienta.executeUpdate(); 
				}
			}
			// Insertar en la tabla pivot OrdenEstado
			String queryInsertOrdenEstado = "INSERT INTO OrdenEstado (id_orden, id_estado) VALUES (?, ?)";
			stmtInsertOrdenEstado = conexion.prepareStatement(queryInsertOrdenEstado);
			stmtInsertOrdenEstado.setInt(1, id_orden);
			stmtInsertOrdenEstado.setString(2, id_estado);
			stmtInsertOrdenEstado.executeUpdate();
		}
	}

	// Cerrar conexiones y declaraciones
	if (stmtInsertOrdenServicio != null) {
		stmtInsertOrdenServicio.close();
	}
	if (stmtInsertOrdenRepuesto != null) {
		stmtInsertOrdenRepuesto.close();
	}
	if (stmtInsertOrdenHerramienta != null) {
		stmtInsertOrdenHerramienta.close();
	}
	if (stmtInsertOrden != null) {
		stmtInsertOrden.close();
	}
	if (conexion != null) {
		conexion.close();
	}

	// Redirigir o mostrar un mensaje de éxito
	out.println("Orden de Taller creada correctamente!");
	out.println("<script type=\"text/javascript\">");
	out.println("setTimeout(function() { window.location.href = 'ordentaller.jsp'; }, 1000);");
	out.println("</script>");

		} catch (Exception e) {
	out.println("Ocurrió un fallo en la creación de la orden de taller");
		}
%>