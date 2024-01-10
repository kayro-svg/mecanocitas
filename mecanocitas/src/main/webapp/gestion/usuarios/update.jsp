<%@ page import="java.sql.*, javax.sql.*, java.sql.Connection" %>
<%@ include file="../../connect.jsp" %>

<%
try {
    String username = request.getParameter("username");
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String contrasena = request.getParameter("contrasena");
    String id_rol = request.getParameter("id_rol");

    if (username == null || username.isEmpty()) {
        out.println("El parámetro 'username' es obligatorio.");
    } else {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

        String queryUpdateUsuario = "UPDATE Usuario SET nombre=?, apellido=?, contrasena=?, id_rol=? WHERE username=?";
        PreparedStatement stmtUpdateUsuario = conexion.prepareStatement(queryUpdateUsuario);
        stmtUpdateUsuario.setString(1, nombre);
        stmtUpdateUsuario.setString(2, apellido);
        stmtUpdateUsuario.setString(3, contrasena);
        stmtUpdateUsuario.setString(4, id_rol);
        stmtUpdateUsuario.setString(5, username);

        int filasAfectadasUsuario = stmtUpdateUsuario.executeUpdate();

        String queryUpdateUsuarioRoles = "UPDATE UsuarioRoles SET id_rol=? WHERE username=?";
        PreparedStatement stmtUpdateUsuarioRoles = conexion.prepareStatement(queryUpdateUsuarioRoles);
        stmtUpdateUsuarioRoles.setString(1, id_rol);
        stmtUpdateUsuarioRoles.setString(2, username);

        int filasAfectadasUsuarioRoles = stmtUpdateUsuarioRoles.executeUpdate();

        if (filasAfectadasUsuario > 0 && filasAfectadasUsuarioRoles > 0) {
            out.println("Usuario y roles actualizados correctamente!");
            out.println("<script type=\"text/javascript\">");
            out.println("setTimeout(function() { window.location.href = 'usuarios.jsp'; }, 1000);");
            out.println("</script>");
        } else {
            out.println("No se pudo actualizar el usuario o sus roles.");
        }

        conexion.close();
    }
} catch (SQLException ex) {
    out.println("Error SQL al intentar actualizar el usuario: " + ex.getMessage());
    ex.printStackTrace();
} catch (ClassNotFoundException ex) {
    out.println("Error de clase al intentar cargar el controlador JDBC: " + ex.getMessage());
    ex.printStackTrace();
} catch (Exception ex) {
    out.println("Error general: " + ex.getMessage());
    ex.printStackTrace();
}
%>
