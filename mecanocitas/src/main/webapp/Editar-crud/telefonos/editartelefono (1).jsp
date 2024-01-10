<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>

<%
String id_telefono = "";
id_telefono = (request.getParameter("id_telefono") != null) ? request.getParameter("id_telefono") : "0"; // consulta en la URL es diferente de null

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
Statement st = conexion.createStatement();

String query="select id_telefono, descripcion"; 
query += " from telefono where id_telefono LIKE '%" + id_telefono + "%'";

ResultSet rs = st.executeQuery(query);

if (rs.next()) {
%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<%
    do {
%>



    <h1>ACTUALIZAR</h1>
    <form action="update.jsp" method="post">
        <table cellspacing="3" cellspacing="3" border="1">
            <tr>
                <td>ID:</td><td><input type="text" name="id_telefono" value="<%=rs.getString(1)%>" readonly></td>
            </tr>
            <tr>
                <td>Numero:</td><td><input type="text" name="descripcion" value="<%=rs.getString(2)%>"></td>
            </tr>
            <tr>
                <td></td><td><input type="submit" value="Actualizar"></td>
            </tr>
        </table>
    </form>

<%
    } while (rs.next());
%>

<%
} else {
    out.println("No existen registros con este criterio de búsqueda");
}
%>
</body>
</html>