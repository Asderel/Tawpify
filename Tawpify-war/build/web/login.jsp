<%@page import="entities.Usuario"%>
<%@page import="utils.Utils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/bootstrap.min.css">

        <%
            Usuario usuarioConectado = session.getAttribute("usuarioConectado") != null ? (Usuario) session.getAttribute("usuarioConectado") : null;
            Usuario usuarioSeleccionado = request.getAttribute("usuarioSeleccionado") != null ? (Usuario) request.getAttribute("usuarioSeleccionado") : null;
            int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));
        %>

        <title>Index</title>
    </head>
    <body>

        <!-- NAV BAR -->

        <nav class="navbar navbar-expand-lg navbar-dark bg-warning">

            <a class="navbar-brand" href="index.jsp">Tawpify</a>

            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                </li>
            </ul>

            <ul class="navbar-nav">

                <%if (usuarioConectado != null) {%>
                <li class="nav-item">
                    <span class="badge badge-pill badge-secondary mt-2 mr-4" id="user-pill">
                        <%=!usuarioConectado.getApodo().isEmpty() ? usuarioConectado.getApodo() : usuarioConectado.getNombre()%>
                    </span>
                </li>
                <%}%>

                <%if (usuarioConectado == null) {%>
                <li class="nav-item">
                    <a class="btn btn-secondary my-2 mx-2 my-sm-0" href="login.jsp?opcode=9">Accede</a>
                </li>

                <li class="nav-item">
                    <a class="btn btn-outline-secondary my-2 mx-2 my-sm-0" href="login.jsp?opcode=8">Registrate</a>
                </li>
                <%} else {%>
                <form id="formLogout" method="POST" action="IndexServlet">
                    <li class="nav-item">
                        <button class="btn btn-outline-secondary my-2 mx-2 my-sm-0" type="submit">Salir</button>
                    </li>
                </form>
                <%}%>
            </ul>
        </nav>

        <!-- FIN NAV BAR -->

        <div class="container-fluid">
            <div id="contenedorContenido" class="row">

                <!-- PANEL LATERARL -->

                <div id="panelLateral" class="col-2">

                    <%if (usuarioConectado != null) {%>
                    <table class="table table-hover">
                        <tbody>
                            <tr class="table">
                                <td><a href="canciones.jsp" class="nav-link">Canciones</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="albumes.jsp" class="nav-link">Albumes</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="artistas.jsp" class="nav-link">Artistas</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="generos.jsp" class="nav-link">Generos</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="listasReproduccion.jsp" class="nav-link">Listas de reproduccion</a></td>
                            </tr>

                            <%if (usuarioConectado != null && usuarioConectado.getAdministrador() == 1) {%>
                            <tr class="table">
                                <td><a href="usuarios.jsp" class="nav-link">Usuarios</a></td>
                            </tr>
                            <%}%>

                        </tbody>
                    </table>
                    <%}%>

                </div>

                <!-- FIN PANEL LATERARL -->


                <!-- CONTENIDO -->

                <div id="contenido" class="col-10">

                    <!-- JUMBOTRON -->

                    <div class="jumbotron" style="padding: 1rem 2rem">
                        <h1 class="row" style="font-size: 2em">
                            <%if (opcode == Utils.OP_REGISTRAR) {%>
                            Registrate en Tawpify
                            <%} else {%>
                            Accede aTawpify
                            <%}%>
                        </h1>
                        <p class="row" style="font-size: 1em">
                            <%if (opcode == Utils.OP_REGISTRAR) {%>
                            Introduce tu email y contraseña para usar Tawpify
                            <%} else if(opcode == Utils.OP_LOGIN) {%>
                            Introduce tus datos para crear un usuario y empezar a usar Tawpify
                            <%} else if(opcode == Utils.OP_MODIFICAR){%>
                            Modifica el usuario seleccionado
                            <%} else {%>
                            Crea un nuevo usuario
                            <%}%>
                        </p>
                    </div>

                    <!-- FIN JUMBOTRON -->

                    <!-- FORMULARIO LOGIN -->

                    <div class="container">
                        <form action="LoginServlet" method="POST">

                            <%if (opcode != Utils.OP_LOGIN || opcode == Utils.OP_MODIFICAR || opcode == Utils.OP_CREAR) {%>

                            <div class="form-group">
                                <label for="<%=Utils.NOMBREINPUT%>">Nombre</label>
                                <input type="text" class="form-control" id="<%=Utils.NOMBREINPUT%>" placeholder="Nombre" name="<%=Utils.NOMBREINPUT%>"
                                       value="<%=opcode == Utils.OP_MODIFICAR ? usuarioSeleccionado.getNombre() : ""%>"/>
                            </div>

                            <div class="form-group">
                                <label for="<%=Utils.APODOINPUT%>">Apodo</label>
                                <input type="text" class="form-control" id="<%=Utils.APODOINPUT%>" placeholder="Apodo" name="<%=Utils.APODOINPUT%>"
                                       value="<%=opcode == Utils.OP_MODIFICAR && usuarioSeleccionado.getApodo() != null ? usuarioSeleccionado.getApodo(): ""%>"/>
                            </div>
                            <%}%>

                            <div class="form-group">
                                <label for="<%=Utils.EMAILINPUT%>">Email</label>
                                <input type="email" class="form-control" id="<%=Utils.EMAILINPUT%>" placeholder="Email" name="<%=Utils.EMAILINPUT%>"
                                       value="<%=opcode == Utils.OP_MODIFICAR ? usuarioSeleccionado.getEmail() : ""%>"/>
                            </div>

                            <div class="form-group">
                                <label for="<%=Utils.CONTRASENAINPUT%>">Contraseña</label>
                                <input type="password" class="form-control" id="<%=Utils.CONTRASENAINPUT%>" placeholder="Contraseña" name="<%=Utils.CONTRASENAINPUT%>"
                                       value="<%=opcode == Utils.OP_MODIFICAR ? usuarioSeleccionado.getContrasena(): ""%>"/>
                            </div>

                            <%if (opcode == Utils.OP_MODIFICAR || opcode == Utils.OP_CREAR) {%>
                            <fieldset class="form-group">
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="checkbox" value="" checked="<%=opcode == Utils.OP_MODIFICAR ? usuarioSeleccionado.getAdministrador() == 1 : false%>"
                                               name="<%=Utils.ADMINISTRADORINPUT%>">
                                        Es administrador
                                    </label>
                                </div>
                            </fieldset>
                            <%}%>

                            <div>
                                <button class="btn btn-block btn-warning">Listo</button>
                            </div>

                            <input name="<%=Utils.OPCODE%>" value="<%=opcode%>" type="hidden">
                            <%if (opcode == Utils.OP_MODIFICAR) {%>
                            <input name="<%=Utils.IDUSUARIOINPUT%>" value="<%=usuarioSeleccionado.getIdUsuario()%>" type="hidden">
                            <%}%>
                        </form>
                    </div>

                    <!-- FIN FORMULARIO LOGIN -->

                </div>

                <!-- FIN CONTENIDO -->
            </div>
        </div>



        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>