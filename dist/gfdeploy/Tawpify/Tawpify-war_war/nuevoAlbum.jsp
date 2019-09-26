<%@page import="entities.Genero"%>
<%@page import="entities.ListaReproduccion"%>
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

            Album albumSeleccionado = session.getAttribute("albumSeleccionado") != null ? (Album) session.getAttribute("albumSeleccionado") : null;
            List<Artista> artistas = (List) session.getAttribute("artistas");
            List<Genero> generos = (List) session.getAttribute("generos");

            List<ListaReproduccion> listasReproduccion = (List) session.getAttribute("listasReproduccion");

            int opcode = request.getParameter(Utils.OPCODE) != null ? Integer.parseInt(request.getParameter(Utils.OPCODE)) : 0;
            if (opcode == Utils.OP_REDIRECCION_MODIFICAR) {
                opcode = Utils.OP_MODIFICAR;
            }

            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        %>

        <title>Nuevo album</title>
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
                        <%if (albumSeleccionado != null && opcode != Utils.OP_MODIFICAR) {%>
                        <h1 class="row" style="font-size: 2em">
                            <span class="mr-3">
                                Album
                            </span>
                            <span>
                                <%=albumSeleccionado.getNombre().toUpperCase()%>
                            </span>

                        </h1>
                        <p class="row" style="font-size: 1em">
                            <span class="mr-3">
                                Artista:
                            </span>
                            <span>
                                <%=albumSeleccionado.getIdArtista().getNombre().toUpperCase()%>
                            </span>
                        </p>
                        <p class="row" style="font-size: 1em">
                            <span class="mr-3">
                                Canciones:
                            </span>
                            <span>
                                <%=albumSeleccionado.getCancionCollection().size()%>
                            </span>
                        </p>

                        <%if (!albumSeleccionado.getGeneroCollection().isEmpty()) {%>
                        <p class="row" style="font-size: 1em">
                            <span class="mr-3">Generos:</span>
                            <%for (Genero g : albumSeleccionado.getGeneroCollection()) {%>
                            <span class="badge badge-pill badge-success my-1 mr-4" id="user-pill">
                                <%=g.getNombre()%>
                            </span>
                            <%}%>
                        </p>
                        <%}%>

                        <div class="row">
                            <button class="btn btn-outline-warning" type="button" data-toggle="modal" data-target="#modalIncluirAlbum"
                                    onclick="setupModalIncuirAlbumLista()">Incluir en lista...</button>
                        </div>
                        <%} else {%>
                        <h1 class="row" style="font-size: 2em">
                            <%if (albumSeleccionado != null) {%>
                            Modificar album
                            <%} else {%>
                            Crear album
                            <%}%>
                        </h1>
                        <p class="row" style="font-size: 1em">
                            <%if (albumSeleccionado != null) {%>
                            Modifica el album seleccionado
                            <%} else {%>
                            Crea un nuevo album
                            <%}%>
                        </p>
                        <%}%>
                    </div>

                    <!-- FIN JUMBOTRON -->

                    <%if (albumSeleccionado != null && opcode != Utils.OP_MODIFICAR && opcode != Utils.OP_CREAR) {%>

                    <!-- VER ALBUM -->
                    <div class="container-fluid">

                        <div class="col-12 mt-2">
                            <div class="row my-2 justify-content-between">
                                <div class="col-3">
                                    <button class="btn btn-outline-warning" type="button" onclick="setupModalCrearCancion()" data-toggle="modal" data-target="#modalNuevaCancion">Incluir cancion</button>
                                </div>

                                <div class="col-3">
                                    <input type="text" class="form-control" id="filtroInput" aria-describedby="filtroInput" placeholder="Filtra en la tabla"
                                           onkeyup="filtrar()">
                                </div>
                            </div>

                            <form id="cancionesForm" action="AlbumCRUDServlet" method="POST">
                                <input id="<%=Utils.IDALBUMINPUT%>" name="<%=Utils.IDALBUMINPUT%>" value="<%=albumSeleccionado != null ? albumSeleccionado.getIdAlbum() : ""%>" type="hidden"/>
                                <input id="<%=Utils.IDCANCIONINPUT%>" name="<%=Utils.IDCANCIONINPUT%>" value="" type="hidden"/>
                                <input id="accionInput" name="<%=Utils.OPCODE%>" value="" type="hidden"/>

                                <input id="<%=Utils.NOMBREINPUT%>" name="<%=Utils.NOMBREINPUT%>" value="" type="hidden"/>
                                <input id="<%=Utils.FECHASALIDAINPUT%>" name="<%=Utils.FECHASALIDAINPUT%>" value="" type="hidden"/>
                                <input id="<%=Utils.URLINPUT%>" name="<%=Utils.URLINPUT%>" value="" type="hidden"/>
                                <input id="<%=Utils.IDLISTAREPRODUCCIONINPUT%>" name="<%=Utils.IDLISTAREPRODUCCIONINPUT%>" value="" type="hidden"/>
                            </form>

                            <table id="tablaCanciones" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Album</th>
                                        <th scope="col">Artista</th>
                                        <th scope="col">Lanzamiento</th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <%for (Cancion c : albumSeleccionado.getCancionCollection()) {%>
                                <tbody>
                                    <tr class="table-active">
                                        <th scope="row"><a class="btn btn-outline-warning far fa-play-circle" target=_blank" href="<%=c.getUrl()%>"
                                                           style="border: none; font-size: 1.5em"></a></th>
                                        <td><%=c.getNombre()%></td>
                                        <td><%=c.getIdAlbum().getNombre()%></td>
                                        <td><%=c.getIdAlbum().getIdArtista().getNombre()%></td>
                                        <td><%=formatter.format(c.getFechaSalida())%></td>

                                        <td><button class="btn btn-outline-warning" type="button" data-toggle="modal" data-target="#modalIncluirLista" title="Incluir en lista de reproduccion"
                                                    onclick="seleccionarCancionBorrar(<%=c.getIdCancion()%>, <%=Utils.OP_INCLUIR_CANCION_LISTA%>)"
                                                    style="border: none;"><span class="fas fa-plus-circle"/></button></td>

                                        <td><button class="btn btn-outline-warning" type="button" form="cancionesForm" onclick="seleccionarCancion(<%=c.getIdCancion()%>, <%=Utils.OP_CREAR_CANCION_ALBUM%>)"
                                                    title="Modificar cancion"
                                                    style="border: none;"><span class="far fa-edit"/></button></td>

                                        <td><button class="btn btn-outline-warning" type="submit" form="cancionesForm" onclick="seleccionarCancionBorrar(<%=c.getIdCancion()%>, <%=Utils.OP_BORRAR_CANCION_ALBUM%>)"
                                                    title="Eliminar cancion"
                                                    style="border: none;"><span class="fas fa-trash"/></button></td>
                                    </tr>
                                </tbody>
                                <input id="nombreOculto_<%=c.getNombre()%>" type="hidden" value="<%=c.getNombre()%>">
                                <input id="fechaOculta_<%=c.getFechaSalida()%>" type="hidden" value="<%=c.getFechaSalida()%>">
                                <input id="urlOculta_<%=c.getUrl()%>" type="hidden" value="<%=c.getUrl()%>">
                                <%}%>
                            </table>
                        </div>
                    </div>

                    <!-- FIN VER ALBUM -->

                    <%} else {%>

                    <!-- CREAR/MODIFICAR ALBUM -->

                    <div class="container">
                        <form action="AlbumCRUDServlet" id="albumForm" method="POST">
                            <input id="accionInput" name="<%=Utils.OPCODE%>" value="<%=opcode%>" type="hidden"/>
                            <input id="<%=Utils.IDALBUMINPUT%>" name="<%=Utils.IDALBUMINPUT%>" value="<%=albumSeleccionado != null ? albumSeleccionado.getIdAlbum() : ""%>" type="hidden"/>

                            <fieldset>
                                <legend style="font-size: 1.2em">Informacion basica</legend>
                                <div class="form-group">
                                    <label for="<%=Utils.NOMBREINPUT%>">Nombre</label>
                                    <input type="text" class="form-control" id="<%=Utils.NOMBREINPUT%>" placeholder="Nombre" name="<%=Utils.NOMBREINPUT%>"
                                           value="<%=albumSeleccionado != null ? albumSeleccionado.getNombre() : ""%>"/>
                                </div>

                                <div class="form-group">
                                    <label for="<%=Utils.FECHASALIDAINPUT%>">Fecha lanzamiento</label>
                                    <input type="text" class="form-control" id="<%=Utils.FECHASALIDAINPUT%>" placeholder="<%=Utils.PLACEHOLDER_FECHA%>" name="<%=Utils.FECHASALIDAINPUT%>"
                                           value="<%=albumSeleccionado != null ? formatter.format(albumSeleccionado.getFechaSalida()) : ""%>"/>
                                </div>
                            </fieldset>

                            <fieldset>
                                <legend style="font-size: 1.2em">Artista</legend>
                                <div class="form-group">
                                    <label for="<%=Utils.ARTISTASELECCIONADOSNPUT%>">Artista del album</label>
                                    <select class="form-control" name="<%=Utils.ARTISTASELECCIONADOSNPUT%>" id="<%=Utils.ARTISTASELECCIONADOSNPUT%>">
                                        <%for (Artista a : artistas) {%>
                                        <option value="<%=a.getIdArtista()%>"
                                                <%=albumSeleccionado != null && albumSeleccionado.getIdArtista().getIdArtista() == a.getIdArtista() ? "selected" : ""%>/>
                                        <%=a.getNombre()%>
                                        </option>
                                        <%}%>
                                    </select>
                                </div>
                            </fieldset>

                            <fieldset>
                                <legend style="font-size: 1.2em">Genero</legend>
                                <div class="form-group">
                                    <label for="<%=Utils.IDGENEROSSELECCIONADOSALBUM%>">Genero del album</label>
                                    <select multiple="true" class="form-control" name="<%=Utils.IDGENEROSSELECCIONADOSALBUM%>" id="<%=Utils.IDGENEROSSELECCIONADOSALBUM%>" size="3">
                                        <%for (Genero g : generos) {%>
                                        <option value="<%=g.getIdGenero()%>"
                                                <%=albumSeleccionado != null && albumSeleccionado.getGeneroCollection().contains(g) ? "selected" : ""%>>
                                            <%=g.getNombre()%>
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

                    <!-- CREAR/MODIFICAR ALBUM -->
                    <%}%>
                </div>

                <!-- FIN CONTENIDO -->
            </div>
        </div>

        <!-- MODALES -->

        <% if (albumSeleccionado != null && opcode == Utils.OP_LISTAR) {%>
        <div id="modalIncluirAlbum" class="modal fade">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">¿En qué lista quieres incluirla?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="POST" action="CancionCRUDServlet">
                        <div class="modal-body">

                            <fieldset>
                                <legend style="font-size: 1.2em">Incluir cancion en la lista de reproduccion...</legend>
                                <div class="form-group">
                                    <select class="form-control" name="<%=Utils.LISTASELECCIONADAALBUMINPUT%>" id="<%=Utils.LISTASELECCIONADAALBUMINPUT%>">
                                        <%for (ListaReproduccion l : listasReproduccion) {%>
                                        <option value="<%=l.getIdListaReproduccion()%>"><%=l.getNombre()%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </fieldset>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                            <button type="submit" form="cancionesForm" onclick="incluirCancionAlbumLista()" class="btn btn-outline-warning">Incluir</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div id="modalIncluirLista" class="modal fade">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">¿En qué lista quieres incluirla?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="POST" action="CancionCRUDServlet">
                        <div class="modal-body">

                            <fieldset>
                                <legend style="font-size: 1.2em">Incluir cancion en la lista de reproduccion...</legend>
                                <div class="form-group">
                                    <select class="form-control" name="<%=Utils.LISTASELECCIONADAINPUT%>" id="<%=Utils.LISTASELECCIONADAINPUT%>">
                                        <%for (ListaReproduccion l : listasReproduccion) {%>
                                        <option value="<%=l.getIdListaReproduccion()%>"><%=l.getNombre()%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </fieldset>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                            <button type="submit" form="cancionesForm" onclick="incluirCancionLista()" class="btn btn-outline-warning">Incluir</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div id="modalNuevaCancion" class="modal fade">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 id="tituloModalCancion" class="modal-title">Nueva cancion para el album</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form method="POST" action="AlbumCRUDServlet">
                        <div class="modal-body">

                            <fieldset>
                                <div class="form-group">
                                    <label for="<%=Utils.NOMBREINPUT%>">Nombre</label>
                                    <input id="nombreModalCancion" type="text" class="form-control" id="<%=Utils.NOMBREINPUT%>" placeholder="Nombre" name="<%=Utils.NOMBREINPUT%>"/>
                                </div>

                                <div class="form-group">
                                    <label for="<%=Utils.FECHASALIDAINPUT%>">Fecha lanzamiento</label>
                                    <input id="fechaModalCancion" type="text" class="form-control" id="<%=Utils.FECHASALIDAINPUT%>" placeholder="<%=Utils.PLACEHOLDER_FECHA%>" name="<%=Utils.FECHASALIDAINPUT%>"/>
                                </div>

                                <div class="form-group">
                                    <label for="<%=Utils.URLINPUT%>">URL</label>
                                    <input id="urlModalCancion" type="text" class="form-control" id="<%=Utils.URLINPUT%>" placeholder="URL de la cancion en Youtube" name="<%=Utils.URLINPUT%>"/>
                                </div>
                            </fieldset>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                            <button type="submit" form="cancionesForm" onclick="setupModalCancion()" class="btn btn-outline-warning">Incluir</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%}%>

        <!-- FIN MODALES -->

        <script>
            function goto(ruta) {
                $('#formRuta').attr('action', ruta);
                $('#formRuta').submit();
            }

            function incluirCancionLista(){
                $('#<%=Utils.IDLISTAREPRODUCCIONINPUT%>').val($('#<%=Utils.LISTASELECCIONADAALBUMINPUT%>').val());
            }

            function incluirCancionAlbumLista(){
                $('#<%=Utils.IDLISTAREPRODUCCIONINPUT%>').val($('#<%=Utils.LISTASELECCIONADAALBUMINPUT%>').val());
            }

            function seleccionarCancionBorrar(idCancion, accion) {
                $('#idCancionInput').val(idCancion);
                $('#accionInput').val(accion);
            }

            function seleccionarCancion(idCancion, accion) {
                $('#idCancionInput').val(idCancion);
                $('#accionInput').val(accion);

                // Seteo para el modal
                $('#nombreModalCancion').val($('#nombreOculto_' + idCancion).val());
                $('#fechaModalCancion').val($('#fechaOculta_' + idCancion).val());
                $('#urlModalCancion').val($('#urlOculta_' + idCancion).val());
                $('#accionInput').val(<%=Utils.OP_CREAR_CANCION_ALBUM%>);
            }

            function setupModalCancion() {
                $('#<%=Utils.NOMBREINPUT%>').val($('#nombreModalCancion').val());
                $('#<%=Utils.FECHASALIDAINPUT%>').val($('#fechaModalCancion').val());
                $('#<%=Utils.URLINPUT%>').val($('#urlModalCancion').val());
            }

            function setupModalCrearCancion() {
                $('#accionInput').val(<%=Utils.OP_CREAR_CANCION_ALBUM%>);
            }

            function setupModalIncuirAlbumLista() {
                $('#accionInput').val(<%=Utils.OP_INCLUIR_ALBUM_LISTA%>);
            }

            var numFilasIngorar = <%=usuarioConectado.getAdministrador() == 1 ? 3 : 2%>

            function filtrar() {
                var input, filtro, tabla, cuerpo, fila, columnas, x, i, j, valor;
                input = document.getElementById("filtroInput");
                filtro = input.value.toUpperCase();
                tabla = document.getElementById("tablaCanciones");
                cuerpo = tabla.getElementsByTagName('tbody');

                for (x = 0; cuerpo.length; x++) {
                    fila = cuerpo[x].getElementsByTagName('tr');
                    for (i = 0; i < fila.length; i++) {
                        columnas = fila[i].getElementsByTagName("td");
                        for (j = 0; j < columnas.length - numFilasIngorar; j++) {
                            valor = columnas[j].textContent || columnas[j].innerText;
                            if (valor.toUpperCase().indexOf(filtro) > -1) {
                                fila[i].style.display = "";
                                break;
                            } else {
                                fila[i].style.display = "none";
                            }
                        }
                    }
                }
            }
        </script>
    </body>
</html>