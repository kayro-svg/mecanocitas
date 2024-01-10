<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>

<%
String id_telefono = request.getParameter("id_telefono");
String descripcion = request.getParameter("descripcion");

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
Statement st = conexion.createStatement();

String updateQuery = "UPDATE telefono SET descripcion=? WHERE id_telefono=?";
PreparedStatement preparedStatement = conexion.prepareStatement(updateQuery);
preparedStatement.setString(1, descripcion);
preparedStatement.setString(2, id_telefono);

int rowsAffected = preparedStatement.executeUpdate();

if (rowsAffected > 0) {
    out.println("Actualización exitosa");
    out.println("<script type=\"text/javascript\">");
    out.println("setTimeout(function(){ window.location.href='../../gestion/telefonos/telefonos.jsp'; }, 1000);");
    out.println("</script>");
} else {
    out.println("No se pudo actualizar el registro");
}

preparedStatement.close();
conexion.close();
%>

