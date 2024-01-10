<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp"  %>

<%
String id_cliente = "";
id_cliente = (request.getParameter("id_cliente") != null) ? request.getParameter("id_cliente") : "0"; // consulta en la URL es diferente de null

Class.forName("com.mysql.jdbc.Driver");

Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
Statement st = conexion.createStatement();

String query="select id_cliente, id_vehiculo, nombre, apellido, cedula, id_telefono, email, id_direccion"; 
query += " from cliente where id_cliente LIKE '%" + id_cliente + "%'";

ResultSet rs = st.executeQuery(query);
session.setAttribute("id_cliente", id_cliente);
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

    <h1>NUEVO</h1>
    <form action="update.jsp" method="post">
        <table cellspacing="3" cellspacing="3" border="1">
            <tr>
                <td>Id_cliente:</td><td><input type="text" name="id_cliente" value="<%=rs.getString(1)%>"></td>
            </tr>

            <tr>
                <td>Nombre:</td><td><input type="text" name="nombre" value="<%=rs.getString(3)%>"></td>
            </tr>
            <tr>
                <td>Apellido:</td><td><input type="text" name="apellido" value="<%=rs.getString(4)%>"></td>
            </tr>
            <tr>
                <td>Cedula:</td><td><input type="text" name="cedula" value="<%=rs.getString(5)%>"></td>
            </tr>
            <tr>
				<td>Telefono:</td>
				<td style="position: relative;">
    			<span style="margin-right: 30px;"><%=rs.getString(6)%></span>
    			<form action="../../gestion/telefonos/telefonos.jsp" method="get" style="display: inline;">
        		<input type="hidden" name="telefono" value="<%=rs.getString(6)%>">
        		<input type="submit" value="Detalles">
    			</form>
				</td>
            </tr>
            <tr>
                <td>Email:</td><td><input type="text" name="email" value="<%=rs.getString(7)%>"></td>
            </tr>
            <tr>
				<td>Id_direccion:</td>
				<td style="position: relative;">
   				 <span style="margin-right: 30px;"><%=rs.getString(8)%></span>
    			<form action="detallesdireccion.jsp" method="get" style="display: inline;">
       		 	<input type="hidden" name="direccion" value="<%=rs.getString(8)%>">
        		<input type="submit" value="Detalles">
    </form>
</td>
            </tr>
            
                        <tr>
             <td>Id_vehiculo:</td>
             
<td style="position: relative;">
    <span style="margin-right: 30px;"><%=rs.getString(2)%></span>
    
    <form action="detallesvehiculo.jsp" method="get" style="display: inline;">
        <input type="hidden" name="vehiculo" value="<%=rs.getString(2)%>">
        <input type="submit" value="Detalles">
    </form>
    
</td>
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