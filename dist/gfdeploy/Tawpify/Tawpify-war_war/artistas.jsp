<%@page import="java.util.List"%>
<%@page import="entities.Album"%>
<%@page import="entities.Artista"%>
<%@page import="utils.Utils"%>
<%@page import="entities.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/all.css">
        <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

        <%
            Usuario usuarioConectado = session.getAttribute("usuarioConectado") != null ? (Usuario) session.getAttribute("usuarioConectado") : null;
            List<Artista> artistas = (List) request.getAttribute("artistas");
        %>

        <title>Artistas</title>
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

        <!-- NAV BAR -->

        <div class="container-fluid">
            <div id="contenedorContenido" class="row">
                <form id="formRuta">
                    <input name="<%=Utils.OPCODE%>" value="<%=Utils.OP_LISTAR%>" type="hidden"/>
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
                                <td><a href="#" class="nav-link" onclick="goto('ListaReproduccionCRUDServlet')">Listas de reproduccion</a></td>
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
                        <h1 class="row" style="font-size: 2em">Artistas</h1>
                        <p class="row" style="font-size: 1em">
                            Aqui puedes consultar los artistas registrados
                        </p>
                    </div>

                    <!-- FIN JUMBOTRON -->

                    <!-- LISTADO ARTISTAS -->

                    <div class="col-12 mt-2">
                        <div class="row my-2 <%=usuarioConectado != null && usuarioConectado.getAdministrador() == 1 ? "justify-content-between" : "justify-content-end"%>">
                            <%if (usuarioConectado.getAdministrador() == 1) {%>
                            <div class="col-3">
                                <button class="btn btn-outline-warning" data-toggle="modal" data-target="#modalCrearArtista">Nuevo Artista</button>
                            </div>
                            <%}%>

                            <div class="col-3">
                                <input type="text" class="form-control" id="filtroInputArtistas" aria-describedby="filtroInputArtistas" placeholder="Filtra en la tabla"
                                       onkeyup="filtrar('filtroInputArtistas', 'cabeceraCard-')">
                            </div>
                        </div>

                        <form id="artistasForm" action="ArtistaCRUDServlet" method="POST">
                            <input id="idArtistaInput" name="<%=Utils.IDARTISTAINPUT%>" value="" type="hidden"/>
                            <input id="accionInput" name="<%=Utils.OPCODE%>" value="" type="hidden"/>
                            <input id="nombreInput" name="<%=Utils.NOMBREINPUT%>" value="" type="hidden"/>
                        </form>

                        <div class="row">
                            <% for (Artista a : artistas) {%>
                            <div data-aos="zoom-in" class="col-md-3 col-sm-12">
                                <div id="card-<%=a.getIdArtista()%>" class="card border-warning mb-3">
                                    <div id="cabeceraCard-<%=a.getIdArtista()%>" class="card-header"><%=a.getNombre()%></div>
                                    <%if (usuarioConectado.getAdministrador() == 1) {%>
                                    <div class="card-body">
                                        <div class="row p-0">
                                            <div class="col-6" style="text-align: center">
                                                <button class="btn btn-outline-warning" type="button" onclick="seleccionarArtista(<%=a.getIdArtista()%>, <%=Utils.OP_MODIFICAR%>)"
                                                        title="Modificar artista" data-toggle="modal" data-target="#modalModificarArtista"
                                                        style="border: none;"><span class="far fa-edit"/></button>
                                            </div>
                                            <div class="col-6" style="text-align: center">
                                                <button class="btn btn-outline-warning" type="submit" form="artistasForm" onclick="seleccionarArtista(<%=a.getIdArtista()%>, <%=Utils.OP_BORRAR%>)"
                                                        title="Eliminar artista"
                                                        style="border: none;"><span class="fas fa-trash"/></button>
                                            </div>
                                        </div>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>

                    <!-- FIN LISTADO ARTISTAS -->

                </div>

                <!-- CONTENIDO -->

            </div>
        </div>

        <!-- MODALES -->

        <div id="modalCrearArtista" class="modal fade">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            Crear un nuevo artista
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <fieldset>
                            <legend style="font-size: 1.2em">Datos</legend>
                            <div class="form-group">
                                <label for="<%=Utils.NOMBREINPUT%>ModalCrearArtista">Nombre</label>
                                <input type="text" class="form-control" id="<%=Utils.NOMBREINPUT%>ModalCrearArtista" placeholder="Nombre"/>
                            </div>
                        </fieldset>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="artistasForm" onclick="setupCrearArtista()" class="btn btn-outline-warning">Listo</button>
                    </div>
                </div>
            </div>
        </div>

        <div id="modalModificarArtista" class="modal fade">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            Modificar el artista seleccionado
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <fieldset>
                            <legend style="font-size: 1.2em">Datos</legend>
                            <div class="form-group">
                                <label for="<%=Utils.NOMBREINPUT%>ModificarArtista">Nombre</label>
                                <input id="nombreInputModalModificarArtista" type="text" class="form-control" placeholder="Nombre" value=""/>
                            </div>
                        </fieldset>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="artistasForm" onclick="setupModificarArtista()" class="btn btn-outline-warning">Listo</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- FIN MODALES -->

        <script src="https://unpkg.com/aos@next/dist/aos.js"></script>

        <script>
                            AOS.init();

                            function seleccionarArtista(idArtista, accion) {
                                $('#idArtistaInput').val(idArtista);
                                $('#accionInput').val(accion);
                                $('#nombreInputModalModificarArtista').val($('#nombreOculto_' + idArtista).val());
                            }

                            function setupModificarArtista() {
                                $('#nombreInput').val($('#nombreInputModalModificarArtista').val());
                            }

                            function setupCrearArtista() {
                                $('#nombreInput').val($('#nombreInputModalCrearArtista').val());
                                $('#accionInput').val(<%=Utils.OP_CREAR%>);
                            }

                            var numFilasIngorar = <%=usuarioConectado.getAdministrador() == 1 ? 2 : 0%>

                            function filtrar(filtroInput, tabla) {
                                var input, filtro;
                                input = document.getElementById(filtroInput);
                                filtro = input.value.toUpperCase();
                                elementos = $('[id^=' + tabla + ']');

                                elementos.each(function () {
                                    if ($(this).text().toUpperCase().indexOf(filtro) > -1) {
                                        $(this).parent().parent().show();
                                    } else {
                                        $(this).parent().parent().hide();
                                    }
                                });
                            }

                            function goto(ruta) {
                                $('#formRuta').attr('action', ruta);
                                $('#formRuta').submit();
                            }
        </script>
    </body>
</html>