<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>
<%
String nombre = request.getParameter("nombre");
String apellido = request.getParameter("apellido");
String cedula = request.getParameter("cedula");
String email = request.getParameter("email");

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
PreparedStatement st = conexion.prepareStatement("insert into cliente (nombre, apellido, cedula, email) values (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
st.setString(1, nombre);
st.setString(2, apellido);
st.setString(3, cedula);
st.setString(4, email);

int flag = st.executeUpdate();

if (flag == 1){
    ResultSet generatedKeys = st.getGeneratedKeys();
    if (generatedKeys.next()) {
        int id_cliente = generatedKeys.getInt(1); // Obtiene el ID del cliente reci�n insertado
        session.setAttribute("id_cliente", id_cliente);
        out.println("Cliente agregado Correctamente!");

        // Redirige a la p�gina de editarcliente2.jsp despu�s de 3 segundos
        out.println("<script type=\"text/javascript\">");
        out.println("setTimeout(function() { window.location.href = 'editarcliente2.jsp?id_cliente=" + id_cliente + "'; }, 1000);");
        out.println("</script>");
    }
} else {
    out.println("Ocurri� un fallo en la inserci�n del cliente " + nombre);
}
%>
</body>
</html>
