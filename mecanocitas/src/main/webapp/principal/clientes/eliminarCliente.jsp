<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
 
  <%@include file="../../connect.jsp"  %>
<%
String id_cliente = ""; //declaracion de la variable 'descripcio' tipo string 
id_cliente = (request.getParameter("id_cliente") != null) ? request.getParameter("id_cliente") : "0"; //Valida que el nombre que viene por la url no sea NULL y le asigna un espacio en blanco " "


Class.forName("com.mysql.jdbc.Driver");

Connection conexion=DriverManager.getConnection(cadenaconexion,usuario,clave);//objeto que realiza la conexion a la base de datos

Statement st =conexion.createStatement();

try
{
String sql="delete from cliente where id_cliente= '"+id_cliente+"' "; 

st.executeUpdate(sql);

boolean flag = true;

if (flag == true){
	response.sendRedirect("clientes.jsp");
}else{
	out.println("Ocurrio un fallo al eliminar los datos");
}
}catch(Exception e){
	out.println("Exception");
}
//response.sendRedirect("readbancos.jsp");
%>