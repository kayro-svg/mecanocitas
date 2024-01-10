<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.Connection" %>
<%@ include file="../../connect.jsp" %>
<%
try {
    String username = request.getParameter("username");
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String contrasena = request.getParameter("contrasena");
    String id_rol = request.getParameter("id_rol");

    // Validación de datos recibidos del formulario
    if (username == null || nombre == null || apellido == null || contrasena == null || id_rol == null ||
            username.isEmpty() || nombre.isEmpty() || apellido.isEmpty() || contrasena.isEmpty() || id_rol.isEmpty()) {
        out.println("Todos los campos son obligatorios. Por favor, complete todos los campos.");
    } else {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);

        // Insertar en la tabla 'Usuario'
        String queryInsertUsuario = "INSERT INTO Usuario (username, nombre, apellido, contrasena, id_rol) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmtInsertUsuario = conexion.prepareStatement(queryInsertUsuario);
        stmtInsertUsuario.setString(1, username);
        stmtInsertUsuario.setString(2, nombre);
        stmtInsertUsuario.setString(3, apellido);
        stmtInsertUsuario.setString(4, contrasena);
        stmtInsertUsuario.setString(5, id_rol);

        int filasAfectadasUsuario = stmtInsertUsuario.executeUpdate();

        if (filasAfectadasUsuario > 0) {
            // Insertar en la tabla 'UsuarioRoles'
            String queryInsertUsuarioRol = "INSERT INTO UsuarioRoles (username, id_rol) VALUES (?, ?)";
            PreparedStatement stmtInsertUsuarioRol = conexion.prepareStatement(queryInsertUsuarioRol);
            stmtInsertUsuarioRol.setString(1, username);
            stmtInsertUsuarioRol.setString(2, id_rol);

            int filasAfectadasUsuarioRol = stmtInsertUsuarioRol.executeUpdate();

            if (filasAfectadasUsuarioRol > 0) {
                out.println("Usuario " + username + " agregado correctamente!");
                out.println("<script type=\"text/javascript\">");
                out.println("setTimeout(function() { window.location.href = 'usuarios.jsp'; }, 1000);");
                out.println("</script>");
            } else {
                out.println("No se insertaron filas en la tabla UsuarioRoles.");
            }
        } else {
            out.println("No se insertaron filas en la tabla Usuario.");
        }

        conexion.close();
    }
} catch (SQLException ex) {
    out.println("Error SQL al intentar insertar en la base de datos: " + ex.getMessage());
    ex.printStackTrace();
} catch (ClassNotFoundException ex) {
    out.println("Error de clase al intentar cargar el controlador JDBC: " + ex.getMessage());
    ex.printStackTrace();
} catch (Exception ex) {
    out.println("Error general: " + ex.getMessage());
    ex.printStackTrace();
}
%>
