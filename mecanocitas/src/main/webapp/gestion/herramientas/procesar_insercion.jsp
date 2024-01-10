<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="../../connect.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.Connection" %>

<%

    String id_cliente = "";
    id_cliente = (session.getAttribute("id_cliente") != null) ? session.getAttribute("id_cliente").toString() : "0";

    String descripcion = request.getParameter("descripcion");
    String cantidad = request.getParameter("cantidad");


    Class.forName("com.mysql.jdbc.Driver");
    Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

    Statement st = conexion.createStatement();

    String sql = "INSERT INTO herramienta (descripcion, cantidad)";
    		sql = sql +" VALUES ('" + descripcion + "', '" + cantidad + "')";
    int flag = st.executeUpdate(sql);
    if (flag == 1) {
    	out.println("Servicio de " + descripcion + " agregado correctamente!");
  
    	  
    	    out.println("<script type=\"text/javascript\">");
    	    out.println("setTimeout(function() { window.location.href = 'herramientas.jsp?id_herramienta'; }, 1000);");
    	    out.println("</script>");
    	    
    }else {
        out.println("Ocurrió un fallo en la inserción de la direccion ");
    }
   
%>

