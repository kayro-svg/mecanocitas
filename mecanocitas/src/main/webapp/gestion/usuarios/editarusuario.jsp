<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.sql.Connection" %>
<%@include file="../../connect.jsp" %>

<%
try {
    String username = request.getParameter("username");

    if (username == null || username.isEmpty()) {
        out.println("El parámetro 'username' es obligatorio.");
    } else {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(cadenaconexion, usuario, clave);
        
        String queryRoles = "SELECT id_rol, descripcion FROM roles WHERE id_rol IN (1, 3, 4)";
    	ResultSet rsRoles = conexion.createStatement().executeQuery(queryRoles);
        // Obtener los datos actuales del usuario
        String queryObtenerUsuario = "SELECT * FROM Usuario WHERE username = ?";
        PreparedStatement stmtObtenerUsuario = conexion.prepareStatement(queryObtenerUsuario);
        stmtObtenerUsuario.setString(1, username);
        ResultSet rsUsuario = stmtObtenerUsuario.executeQuery();

        if (rsUsuario.next()) {
            // Mostrar formulario para editar los datos
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="initial-scale=1, width=device-width" />

<link rel="stylesheet" href="../../estilos-crud/formularios.css" />
<link rel="stylesheet" href="../../estilos-crud/estilo_global.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700&display=swap" />
<link rel="icon" type="image/x-icon" href="../../favicon/favicon.png">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<title>MecanoCitas - Editar Usuario</title>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
	
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
	
	
<main class="contenedor_principal">

<div class="capa-opaca">

<div class="bg-blanco" style="height: fit-content;">

<div class="titulo">
<h1 class="titulo-texto">EDITAR USUARIO</h1>
</div>

<div class="form_crear">

<div class="form_box1" style="margin-top: 0;display: flex;">

<form class="form" action="update.jsp" method="post" style=" justify-content: space-between;
margin-right: 113px;margin-left: 61px;align-items: center; margin-top: -18px;">

	<div style="width: 400px;">
	
	 <input type="hidden" name="username" id="username" value="<%=rsUsuario.getString("username")%>">

    <div class="form_texto" style="margin-bottom: 22px;">
    <label class="label" style="display: flex; align-items: center;">Cambiar de Rol:</label>        
        <select class="nuevo-boton" name="id_rol" required id="id_rol" style="width:fit-content !important; padding: 7px; border:none;padding-bottom: 3px;padding-top: 0;font-size: 14px;">
               <% 
    while (rsRoles.next()) {
        String idRol = rsRoles.getString("id_rol");
        String descripcionRol = rsRoles.getString("descripcion");
        String idRolUsuario = rsUsuario.getString("id_rol");

        // Verificar si el rol actual coincide con el rol del usuario, marcarlo como seleccionado
        String selected = idRol.equals(idRolUsuario) ? "selected" : "";

        // Agregar la opción al dropdown con la descripción del rol
    %>
        <option value="<%= idRol %>" <%= selected %>><%= descripcionRol %></option>
    <% } %>
        </select>
    </div>
    
    <div class="form_texto" style="margin-bottom: 22px;">
    <input type="password" name="contrasena" id="contrasena" value="<%= rsUsuario.getString("contrasena")%> " >
   	
   	<div style="display: flex; justify-content: space-between;">
    <label>Contraseña</label>
     <span onclick="mostrarContrasena()" style="cursor: pointer;">
        <ion-icon name="eye-outline" id="eye-icon"></ion-icon>
    </span>
    </div>
</div>
    <div class="form_texto" >
    <input type="text" name="nombre" id="nombre" value="<%=rsUsuario.getString("nombre")%>">
    <label>Nombre</label>
    </div>  
    <div class="form_texto">
    <input type="text" name="apellido" id="apellido"  value="<%= rsUsuario.getString("apellido")%>">
    <label>Apellido</label>
    </div>

	</div>


    	<div class="form form_texto-estado form_texto" style="display: flex; width: fit-content;text-align: center;">
    	 <p style="margin: 10px; margin-bottom: 16px: text-align: center; font-size: 16px">Cambiar datos del usuario: <br><b style="font-size: 22px"><%= rsUsuario.getString("username")%></b></p>  
</div>
    

    </div>
    
    <div style="display: flex;margin-bottom: 20px;"> 
	<a href="usuarios.jsp" class="boton-cancelar" id="boton-login">
    CANCELAR
  </a>
    <a class="btn-guardar" id="boton-login">
    <input class="btn-guardar" type="submit" value="GUARDAR CAMBIOS" style="border: none; outline: none;">
    </a> 
	</div>

</form> 


</div>
</div>
</div>
</main>

<script>
    function mostrarContrasena() {
        var contrasenaInput = document.getElementById("contrasena");
        var eyeIcon = document.getElementById("eye-icon");
        if (contrasenaInput.type === "password") {
            contrasenaInput.type = "text";
            eyeIcon.setAttribute("name", "eye-off-outline");
        } else {
            contrasenaInput.type = "password";
            eyeIcon.setAttribute("name", "eye-outline");
        }
    }
</script>

</body>
</html>
<%
        } else {
            out.println("No se encontró ningún usuario con el username proporcionado.");
        }

        conexion.close();
    }
} catch (SQLException ex) {
    out.println("Error SQL al intentar obtener el usuario: " + ex.getMessage());
    ex.printStackTrace();
} catch (ClassNotFoundException ex) {
    out.println("Error de clase al intentar cargar el controlador JDBC: " + ex.getMessage());
    ex.printStackTrace();
} catch (Exception ex) {
    out.println("Error general: " + ex.getMessage());
    ex.printStackTrace();
}
%>