<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.Cancion"%>
<%@page import="entities.Album"%>
<%@page import="entities.Artista"%>
<%@page import="java.util.List"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/bootstrap.min.css">

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/86da25765b.js" crossorigin="anonymous"></script>

        <%
            Usuario usuarioConectado = session.getAttribute("usuarioConectado") != null ? (Usuario) session.getAttribute("usuarioConectado") : null;
            Cancion cancionSeleccionada = request.getAttribute("cancionSeleccionada") != null ? (Cancion) request.getAttribute("cancionSeleccionada") : null;
            List<Artista> artistas = (List) session.getAttribute("artistas");
            List<Album> albumes = (List) session.getAttribute("albumes");

            int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));
            if (opcode == Utils.OP_REDIRECCION_MODIFICAR) {
                opcode = Utils.OP_MODIFICAR;
            }

            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        %>

        <title>Nueva cancion</title>
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
                <form id="formRuta">
                    <input id="accionInput" name="<%=Utils.OPCODE%>" value="<%=Utils.OP_LISTAR%>" type="hidden"/>
                </form>

                <!-- PANEL LATERARL -->

                <div id="panelLateral" class="col-2">

                    <%if (usuarioConectado != null) {%>

                    <table class="table table-hover">
                        <tbody>
                            <tr class="table">
                                <td><a href="#" class="nav-link" onclick="goto('CancionCRUDServlet')">Canciones</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="#" class="nav-link" onclick="goto('AlbumCRUDServlet')">Albumes</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="#" class="nav-link" onclick="goto('ArtistaCRUDServlet')">Artistas</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="#" class="nav-link" onclick="goto('GeneroCRUDServlet')">Generos</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="#" class="nav-link" onclick="goto('ListaReproducionCRUDServlet')">Listas de reproduccion</a></td>
                            </tr>

                            <%if (usuarioConectado != null && usuarioConectado.getAdministrador() == 1) {%>
                            <tr class="table">
                                <td><a href="#" class="nav-link" onclick="goto('UsuarioCRUDServlet')">Usuarios</a> </td>
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
                            <%if (cancionSeleccionada != null) {%>
                            Modificacion de cancion
                            <%} else {%>
                            Creacion de cancion
                            <%}%>
                        </h1>
                        <p class="row" style="font-size: 1em">
                            <%if (cancionSeleccionada != null) {%>
                            Modifica la cancion seleccionada
                            <%} else {%>
                            Crea una nueva cancion
                            <%}%>
                        </p>
                    </div>

                    <!-- FIN JUMBOTRON -->

                    <!-- FORMULARIO NUEVA CANCION -->

                    <div class="container">
                        <form action="CancionCRUDServlet" id="cancionForm" method="POST">
                            <input id="accionInput" name="<%=Utils.OPCODE%>" value="<%=opcode%>" type="hidden"/>
                            <input id="idCancionInput" name="<%=Utils.IDCANCIONINPUT%>" value="<%=cancionSeleccionada != null ? cancionSeleccionada.getIdCancion() : ""%>" type="hidden"/>

                            <fieldset>
                                <legend style="font-size: 1.2em">Informacion basica</legend>
                                <div class="form-group">
                                    <label for="<%=Utils.NOMBREINPUT%>">Nombre</label>
                                    <input type="text" class="form-control" id="<%=Utils.NOMBREINPUT%>" placeholder="Nombre" name="<%=Utils.NOMBREINPUT%>"
                                           value="<%=cancionSeleccionada != null ? cancionSeleccionada.getNombre() : ""%>"/>
                                </div>

                                <div class="form-group">
                                    <label for="<%=Utils.FECHASALIDAINPUT%>">Fecha lanzamiento</label>
                                    <input type="text" class="form-control" id="<%=Utils.FECHASALIDAINPUT%>" placeholder="<%=Utils.PLACEHOLDER_FECHA%>" name="<%=Utils.FECHASALIDAINPUT%>"
                                           value="<%=cancionSeleccionada != null ? formatter.format(cancionSeleccionada.getFechaSalida()) : ""%>"/>
                                </div>

                                <div class="form-group">
                                    <label for="<%=Utils.URLINPUT%>">URL</label>
                                    <input type="text" class="form-control" id="<%=Utils.URLINPUT%>" placeholder="URL de la cancion en Youtube" name="<%=Utils.URLINPUT%>"
                                           value="<%=cancionSeleccionada != null ? cancionSeleccionada.getUrl() : ""%>"/>
                                </div>
                            </fieldset>

                            <fieldset>
                                <legend style="font-size: 1.2em">Artistas colaboradores</legend>
                                <div class="form-group">
                                    <label for="<%=Utils.ARTISTASSELECCIONADOSNPUT%>">Artistas</label>
                                    <select multiple="true" class="form-control" name="<%=Utils.ARTISTASSELECCIONADOSNPUT%>" id="<%=Utils.ARTISTASSELECCIONADOSNPUT%>" size="3">
                                        <%for (Artista a : artistas) {%>
                                        <option value="<%=a.getIdArtista()%>"
                                                <%=cancionSeleccionada != null && cancionSeleccionada.getArtistaCollection().contains(a) ? "selected" : ""%>>
                                            <%=a.getNombre()%>
                                        </option>
                                        <%}%>
                                    </select>
                                </div>
                            </fieldset>

                            <fieldset>
                                <legend style="font-size: 1.2em">Album</legend>
                                <div class="form-group">
                                    <label for="<%=Utils.ALBUMSELECCIONADOINPUT%>">Album al que pertenece la cancion</label>
                                    <select class="form-control" name="<%=Utils.ALBUMSELECCIONADOINPUT%>" id="<%=Utils.ALBUMSELECCIONADOINPUT%>">
                                        <%for (Album al : albumes) {%>
                                        <option value="<%=al.getIdAlbum()%>"
                                                <%=cancionSeleccionada != null && cancionSeleccionada.getIdAlbum().getIdAlbum() == al.getIdAlbum() ? "selected" : ""%>>
                                            <%=al.getNombre()%>
                                        </option>
                                        <%}%>
                                    </select>
                                </div>

                                <div>
                                    <button class="btn btn-block btn-warning" type="submit">Listo</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>

                    <!-- FIN FORMULARIO NUEVA CANCION -->

                </div>

                <!-- FIN CONTENIDO -->
            </div>
        </div>

        <script>
            function goto(ruta) {
                $('#formRuta').attr('action', ruta);
                $('#formRuta').submit();
            }
        </script>
    </body>
</html>