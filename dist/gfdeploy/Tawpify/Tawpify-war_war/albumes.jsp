<%@page import="entities.ListaReproduccion"%>
<%@page import="entities.Album"%>
<%@page import="java.util.List"%>
<%@page import="entities.Artista"%>
<%@page import="utils.Utils"%>
<%@page import="java.text.SimpleDateFormat"%>
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
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

            List<Artista> artistas = (List) session.getAttribute("artistas");
            List<Album> albumes = (List) session.getAttribute("albumes");
        %>

        <title>Albumes</title>
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
                        <h1 class="row" style="font-size: 2em">Albumes</h1>
                        <p class="row" style="font-size: 1em">
                            Aqui puedes acceder a todos los albumes registrados
                        </p>
                    </div>

                    <!-- FIN JUMBOTRON -->

                    <!-- LISTADO ALBUMES -->

                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12 mt-2">
                                <form action="AlbumCRUDServlet" method="POST">
                                    <div class="row">
                                        <div class="col-6">
                                            <fieldset>
                                                <legend style="font-size: 1.2em">Selecciona diferentes artistas a la vez presionando 'CTRL'</legend>
                                                <div class="form-group">
                                                    <label for="<%=Utils.ARTISTASSELECCIONADOSNPUT%>">Filtra por artista</label>
                                                    <select multiple="true" class="form-control" name="<%=Utils.ARTISTASSELECCIONADOSNPUT%>" id="<%=Utils.ARTISTASSELECCIONADOSNPUT%>">
                                                        <%for (Artista a : artistas) {%>
                                                        <option value="<%=a.getIdArtista()%>"><%=a.getNombre()%></option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>

                                    <div class="row justify-content-end">
                                        <div class="col-auto">
                                            <button type="submit" class="btn btn-outline-warning">Filtrar</button>
                                            <input name="<%=Utils.OPCODE%>" value="<%=Utils.OP_FILTRAR%>" type="hidden"/>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 mt-2">
                        <div class="row my-2 <%=usuarioConectado != null && usuarioConectado.getAdministrador() == 1 ? "justify-content-between" : "justify-content-end"%>">
                            <%if (usuarioConectado.getAdministrador() == 1) {%>
                            <div class="col-3">
                                <a class="btn btn-outline-warning" href="nuevoAlbum.jsp?<%=Utils.OPCODE%>=<%=Utils.OP_CREAR%>">Nuevo album</a>
                            </div>
                            <%}%>

                            <div class="col-3">
                                <input type="text" class="form-control" id="filtroInput" aria-describedby="filtroInput" placeholder="Filtra en la tabla"
                                       onkeyup="filtrar('filtroInput', 'card-')">
                            </div>
                        </div>

                        <form id="albumesForm" action="AlbumCRUDServlet" method="POST">
                            <input id="<%=Utils.IDALBUMINPUT%>" name="<%=Utils.IDALBUMINPUT%>" value="" type="hidden"/>
                            <input id="accionInput" name="<%=Utils.OPCODE%>" value="" type="hidden"/>
                        </form>

                        <div class="row">
                            <%for (Album al : albumes) {%>
                            <div data-aos="zoom-in" class="col-md-3 col-sm-12">
                                <div id="card-<%=al.getIdAlbum()%>" class="card border-warning mb-3">
                                    <div id="cabeceraCard-<%=al.getIdAlbum()%>" class="card-header"><%=al.getNombre()%></div>
                                    <div class="card-body pb-0">
                                        <p class="row pl-3">
                                            <span class="mr-3">
                                                Artista:
                                            </span>
                                            <span id="contenidoCard1-<%=al.getIdAlbum()%>" class ml-3>
                                                <%=al.getIdArtista().getNombre()%>
                                            </span>
                                        </p>

                                        <p class="row pl-3">
                                            <span class="mr-3">
                                                Fecha salida:
                                            </span>
                                            <span id="contenidoCard2-<%=al.getIdAlbum()%>">
                                                <%=formatter.format(al.getFechaSalida())%>
                                            </span>
                                        </p>


                                        <div class="row p-2" style="border-top: solid 1px #444">
                                            <div class="<%=usuarioConectado.getAdministrador() == 1 ? "col-4" : "col-12" %>" style="text-align: center">
                                                <button class="btn btn-outline-warning" type="submit" form="albumesForm" onclick="seleccionarAlbum(<%=al.getIdAlbum()%>, <%=Utils.OP_LISTAR%>)"
                                                        title="Ver album"
                                                        style="border: none;"><span class="far fa-eye"/></button>
                                            </div>
                                            <%if (usuarioConectado.getAdministrador() == 1) {%>
                                            <div class="col-4" style="text-align: center">
                                                <button class="btn btn-outline-warning" type="submit" form="albumesForm" onclick="seleccionarAlbum(<%=al.getIdAlbum()%>, <%=Utils.OP_REDIRECCION_MODIFICAR%>)"
                                                        title="Modificar album"
                                                        style="border: none;"><span class="far fa-edit"/></button>
                                            </div>
                                            <div class="col-4" style="text-align: center">
                                                <button class="btn btn-outline-warning" type="submit" form="albumesForm" onclick="seleccionarAlbum(<%=al.getIdAlbum()%>, <%=Utils.OP_BORRAR%>)"
                                                        title="Eliminar album"
                                                        style="border: none;"><span class="fas fa-trash"/></button>
                                            </div>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>

                    <!-- FIN LISTADO ALBUMES -->

                </div>

                <!-- CONTENIDO -->

            </div>
        </div>

        <script src="https://unpkg.com/aos@next/dist/aos.js"></script>
        <script>
                                                    AOS.init();

                                                    function seleccionarAlbum(idAlbum, accion) {
                                                        $('#idAlbumInput').val(idAlbum);
                                                        $('#accionInput').val(accion);
                                                    }


                                                    function filtrar(filtroInput, tabla) {
                                                        var input, filtro, encontrado;
                                                        input = document.getElementById(filtroInput);
                                                        filtro = input.value.toUpperCase();
                                                        elementos = $('[id^=' + tabla + ']');

                                                        elementos.each(function () {
                                                            var encontrado;
                                                            var contenido = $(this).find('[id^=contenidoCard]');

                                                            contenido.each(function () {
                                                                if ($(this).text().toUpperCase().indexOf(filtro) > -1) {
                                                                    encontrado = true;
                                                                    return false;
                                                                } else {
                                                                    encontrado = false;
                                                                }
                                                            });

                                                            if (encontrado) {
                                                                $(this).parent().show();
                                                            } else {
                                                                $(this).parent().hide();
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