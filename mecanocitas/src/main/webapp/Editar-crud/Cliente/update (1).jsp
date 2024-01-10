<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.Connection" %>
<%@include file="../../connect.jsp" %>

<%
String id_cliente = request.getParameter("id_cliente");
String id_vehiculo = request.getParameter("id_vehiculo");
String nombre = request.getParameter("nombre");
String apellido = request.getParameter("apellido");
String cedula = request.getParameter("cedula");
String id_telefono = request.getParameter("id_telefono");
String email = request.getParameter("email");
String id_direccion = request.getParameter("id_direccion");

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
Statement st = conexion.createStatement();

// Actualizar la información del cliente en la base de datos
String updateQuery = "UPDATE Cliente SET id_vehiculo=?, nombre=?, apellido=?, cedula=?, id_telefono=?, email=?, id_direccion=? WHERE id_cliente=?";
try (PreparedStatement preparedStatement = conexion.prepareStatement(updateQuery)) {
    preparedStatement.setString(1, id_vehiculo);
    preparedStatement.setString(2, nombre);
    preparedStatement.setString(3, apellido);
    preparedStatement.setString(4, cedula);
    preparedStatement.setString(5, id_telefono);
    preparedStatement.setString(6, email);
    preparedStatement.setString(7, id_direccion);
    preparedStatement.setString(8, id_cliente);

    int rowsUpdated = preparedStatement.executeUpdate();

    if (rowsUpdated > 0) {
        out.println("¡La actualización se realizó correctamente!");
    } else {
        out.println("No se pudo actualizar el registro. Verifica los datos proporcionados.");
    }
} catch (SQLException e) {
    out.println("Error al actualizar el registro: " + e.getMessage());
} finally {
    st.close();
    conexion.close();
}
%>

