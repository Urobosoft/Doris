<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= session.getAttribute("user_name")%></title>
        <link rel="stylesheet" type="text/css" href="princistyle.css">
    </head>
    <body>
         <header id="header">
        <div class="main">
            <nav class="nav">
                <div class="menu"></div>
                <ul class="menulist">
                    <li class="active"><a href="Principal.jsp"><i class="fa fa-home"></i>Home</a></li>
                    <li><a href="#"> Perfil </i></a>
                        <div class="sub-menu">
                            <ul>
                                <li><a href="MiPerfil.jsp">Ver perfil</a></li>
                                <li><a href="RegistrarMascota.html">Registrar mascota</a></li>
                                <li><a href="Registro_Dir.html">Registrar Dirección</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="#">Principal </a>
                        <div class="sub-menu">
                            <ul class=>
                                <li><a href="Mis_Mascotas.jsp">Mascotas</a></li>
                            </ul>
                        </div>
                    </li>

                    <li><a href="#"></i> Mascotas </i></a>
                        <div class="sub-menu">
                            <ul>
                                <li><a href="RAdopciones.jsp">Adopción</a></li>
                                <li><a href="Tips.html">Tips</a></li>
                                <li><a href="Mis_Mascotas.jsp">Mis mascotas</a></li>

                            </ul>
                        </div>
                    </li>
                    <li><a href="#">Salud</a>
                        <div class="sub-menu">
                            <ul>
                                <li><a href="#">Veterinario</a></li>
                                <li><a href="Recomendaciones.html">Recomendaciones</a></li>
                                <li><a href="Enfermedades.html">Enfermedades</a></li>
                                <li><a href="Cuidados.html">Cuidados</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="#">Acerca de nosotros</a></li>
                    <li><a href="logout.jsp">Cerrar sesión</a></li>
                </ul>
                <div class="bars__menu">
                    <span class="line1__bars-menu"></span>
                    <span class="line2__bars-menu"></span>
                    <span class="line3__bars-menu"></span>
                </div>
            </nav>
        </div>
    </header>
        <main>
            <div id="container">
                <h1>Mi perfil</h1>
                <div id="datos-personales">
                    <h2>Datos personales</h2>
                    <ul>
                        <p><    strong>Nombre:</strong><%= session.getAttribute("user_name")%></p>
                        <p><strong>Sexo:</strong> <%= session.getAttribute("user_sex")%></p>
                        <p><strong>Fecha de nacimiento:</strong> <%= session.getAttribute("user_date")%></p>
                        <p><strong>Correo electrónico:</strong> <%= session.getAttribute("user_mail")%></p>
                        <p><strong>Teléfono celular:</strong> <%= session.getAttribute("user_phone")%></p>
                    </ul>
                </div>
                <div id="direcciones">
                    <%@page import="java.sql.*, java.io.*, basesita.conexionsita"%>
                    <%
                        HttpSession sesion = request.getSession();
                        Object userIdObj = sesion.getAttribute("user_id");
                        int userid = Integer.parseInt(userIdObj.toString());
                        Connection con = null;
                        CallableStatement comandito = null;
                        conexionsita conecta = new conexionsita();
                        con = conecta.conectar();
                        String queryString = "call desplegarDir(?)";
                        comandito = con.prepareCall(queryString);
                        comandito.setInt(1, userid);
                        ResultSet rs = comandito.executeQuery();
                        if (rs.next()) {
                    %>
                    <table class="mascota">
                        <th>Estado</th>
                        <th>Municipio</th>
                        <th>Colonia</th>
                        <th>CP</th>
                            <% do {%>
                        <tr>
                            <td><%= rs.getString("Estado")%></td>
                            <td><%= rs.getString("Municipio")%></td>
                            <td><%= rs.getString("Colonia")%></td>
                            <td><%= rs.getString("Codigo_Postal")%></td>
                            <td>
                                <form method="POST" action="EliminarDireccion.jsp">
                                    <input type="hidden" name="idDireccion" value="<%= rs.getString("idDireccion")%>">
                                    <button type="submit">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                        <% } while (rs.next()); %>
                    </table>
                    <%
                    } else {
                    %>
                    <p>No hay direcciones registradas.</p>
                        <button><a href="Registro_Dir.html">Agregar</a></button>
                    <%
                        }
                        rs.close();
                        con.close();
                    %>
                </div>
        </main>
    </body>
</html>
