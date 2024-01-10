<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<%@include file="../../connect.jsp" %>

<%
// Recuperar los par�metros enviados desde el formulario
String[] nuevosTelefonos = request.getParameterValues("nuevosTelefonos");
String id_cliente = request.getParameter("id_cliente");

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

// Obtener los n�meros de tel�fono actuales del cliente
String queryObtenerTelefonos = "SELECT descripcion FROM telefono WHERE id_cliente = ?";
PreparedStatement stmt = conexion.prepareStatement(queryObtenerTelefonos);
stmt.setString(1, id_cliente);
ResultSet rs = stmt.executeQuery();

// Obtener los n�meros de tel�fono actuales en una lista
List<String> telefonosActuales = new ArrayList<>();
while (rs.next()) {
    telefonosActuales.add(rs.getString("descripcion"));
}

// Comparar los n�meros de tel�fono actuales con los nuevos para actualizar solo los cambios
for (String nuevoTelefono : nuevosTelefonos) {
    if (!telefonosActuales.contains(nuevoTelefono)) {
        String queryUpdateTelefono = "UPDATE telefono SET descripcion = ? WHERE id_cliente = ? AND telefono = ?";
        PreparedStatement updateStmt = conexion.prepareStatement(queryUpdateTelefono);
        updateStmt.setString(1, nuevoTelefono);
        updateStmt.setString(2, id_cliente);
        updateStmt.setString(3, telefonosActuales.get(0)); // Solo se actualiza el primer n�mero de tel�fono (puedes ajustarlo seg�n tu l�gica)
        updateStmt.executeUpdate();
        updateStmt.close();
    }
}

rs.close();
stmt.close();
conexion.close();

// Redirigir o mostrar un mensaje de �xito
response.sendRedirect("../../gestion/telefonos/telefonos.jsp?id_cliente=" + id_cliente);
%>


