<%@ page import="java.sql.*" %>
<%@ include file="../../connect.jsp" %>

<%
try {
    String username = request.getParameter("username");

    if (username == null || username.isEmpty()) {
        out.println("El parámetro 'username' es obligatorio.");
    } else {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

        // Eliminar las relaciones de usuario de la tabla 'UsuarioRoles'
        String queryEliminarUsuarioRoles = "DELETE FROM UsuarioRoles WHERE username = ?";
        PreparedStatement stmtEliminarUsuarioRoles = conexion.prepareStatement(queryEliminarUsuarioRoles);
        stmtEliminarUsuarioRoles.setString(1, username);

        int filasEliminadasUsuarioRoles = stmtEliminarUsuarioRoles.executeUpdate();

        if (filasEliminadasUsuarioRoles > 0) {
            // Ahora que las relaciones de usuario han sido eliminadas, procedemos a eliminar el usuario de la tabla 'Usuario'
            String queryEliminarUsuario = "DELETE FROM Usuario WHERE username = ?";
            PreparedStatement stmtEliminarUsuario = conexion.prepareStatement(queryEliminarUsuario);
            stmtEliminarUsuario.setString(1, username);

            int filasEliminadasUsuario = stmtEliminarUsuario.executeUpdate();

            if (filasEliminadasUsuario > 0) {
                out.println("Usuario " + username + " eliminado correctamente.");
                out.println("<script type=\"text/javascript\">");
                out.println("setTimeout(function() { window.location.href = 'usuarios.jsp'; }, 1000);");
                out.println("</script>");
            } else {
                out.println("No se encontró ningún usuario con el username proporcionado.");
            }
        } else {
            out.println("No se eliminaron las relaciones de usuario en la tabla UsuarioRoles.");
        }

        conexion.close();
    }
} catch (SQLException ex) {
    out.println("Error SQL al intentar eliminar el usuario: " + ex.getMessage());
    ex.printStackTrace();
} catch (ClassNotFoundException ex) {
    out.println("Error de clase al intentar cargar el controlador JDBC: " + ex.getMessage());
    ex.printStackTrace();
} catch (Exception ex) {
    out.println("Error general: " + ex.getMessage());
    ex.printStackTrace();
}
%>
