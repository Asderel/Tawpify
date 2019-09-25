<%@page import="entities.ListaReproduccion"%>
<%@page import="entities.Album"%>
<%@page import="entities.Artista"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.Cancion"%>
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
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

            List<Cancion> canciones = (List) request.getAttribute("canciones");
            List<Artista> artistas = (List) session.getAttribute("artistas");
            List<Album> albumes = (List) session.getAttribute("albumes");
            List<ListaReproduccion> listasReproduccion = (List) request.getAttribute("listasReproduccion");
        %>

        <title>Canciones</title>
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
                        <h1 class="row" style="font-size: 2em">Canciones</h1>
                        <p class="row" style="font-size: 1em">
                            Aqui puedes acceder a todas las canciones registradas y reproducirlas
                        </p>
                    </div>

                    <!-- FIN JUMBOTRON -->

                    <!-- LISTADO CANCIONES -->

                    <div class="container-fluid mb-5">
                        <div class="row">
                            <div class="col-12 mt-2">
                                <form action="CancionCRUDServlet" method="POST">
                                    <div class="row">
                                        <div class="col-6">
                                            <fieldset>
                                                <legend style="font-size: 1.2em">Selecciona diferentes artistas a la vez presionando 'CTRL'</legend>
                                                <div class="form-group">
                                                    <label for="<%=Utils.ARTISTASSELECCIONADOSNPUT%>">Filtra por artista</label>
                                                    <select multiple="true" class="form-control" name="<%=Utils.ARTISTASSELECCIONADOSNPUT%>" id="<%=Utils.ARTISTASSELECCIONADOSNPUT%>" size="3">
                                                        <%for (Artista a : artistas) {%>
                                                        <option value="<%=a.getIdArtista()%>"><%=a.getNombre()%></option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                            </fieldset>
                                        </div>
                                        <div class="col-6">
                                            <fieldset>
                                                <legend style="font-size: 1.2em">Selecciona diferentes albumes a la vez presionando 'CTRL'</legend>
                                                <div class="form-group">
                                                    <label for="<%=Utils.ALBUMSELECCIONADOINPUT%>">Filtra por album</label>
                                                    <select multiple="true" class="form-control" name="<%=Utils.ALBUMSELECCIONADOINPUT%>" id="<%=Utils.ALBUMSELECCIONADOINPUT%>" size="3">
                                                        <%for (Album al : albumes) {%>
                                                        <option value="<%=al.getIdAlbum()%>"><%=al.getNombre()%></option>
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
                        <div class="row my-2 justify-content-between">
                            <div class="col-3">
                                <a class="btn btn-outline-warning" href="nuevaCancion.jsp?<%=Utils.OPCODE%>=<%=Utils.OP_CREAR%>">Nueva cancion</a>
                            </div>

                            <div class="col-3">
                                <input type="text" class="form-control" id="filtroInput" aria-describedby="filtroInput" placeholder="Filtra en la tabla"
                                       onkeyup="filtrar()">
                            </div>
                        </div>

                        <form id="cancionesForm" action="CancionCRUDServlet" method="POST">
                            <input id="idCancionInput" name="<%=Utils.IDCANCIONINPUT%>" value="" type="hidden"/>
                            <input id="accionInput" name="<%=Utils.OPCODE%>" value="" type="hidden"/>
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
                            <%for (Cancion c : canciones) {%>
                            <tbody>
                                <tr class="table-active">
                                    <th scope="row"><a class="btn btn-outline-warning far fa-play-circle" target=_blank" href="<%=c.getUrl()%>"
                                                       style="border: none; font-size: 1.5em"></a></th>
                                    <td><%=c.getNombre()%></td>
                                    <td><%=c.getIdAlbum().getNombre()%></td>
                                    <td><%=c.getIdAlbum().getIdArtista().getNombre()%></td>
                                    <td><%=formatter.format(c.getFechaSalida())%></td>

                                    <td><button class="btn btn-outline-warning" type="button" data-toggle="modal" data-target="#modalIncluir" title="Incluir en lista de reproduccion"
                                                style="border: none;"><span class="fas fa-plus-circle"/></button></td>

                                    <td><button class="btn btn-outline-warning" type="submit" form="cancionesForm" onclick="seleccionarCancion(<%=c.getIdCancion()%>, <%=Utils.OP_REDIRECCION_MODIFICAR%>)"
                                                title="Modificar cancion"
                                                style="border: none;"><span class="far fa-edit"/></button></td>

                                    <td><button class="btn btn-outline-warning" type="submit" form="cancionesForm" onclick="seleccionarCancion(<%=c.getIdCancion()%>, <%=Utils.OP_BORRAR%>)"
                                                title="Eliminar cancion"
                                                style="border: none;"><span class="fas fa-trash"/></button></td>
                                </tr>
                            </tbody>
                            <%}%>
                        </table>
                    </div>

                    <!-- FIN LISTADO CANCIONES -->

                </div>

                <!-- CONTENIDO -->

            </div>
        </div>

        <!-- MODALES -->

        <div id="modalIncluir" class="modal fade">
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
                                    <select class="form-control" name="<%=Utils.LISTASELECCIONADAINPUT%>" id="<%=Utils.LISTASELECCIONADAINPUT%>" name="<%=Utils.LISTASELECCIONADAINPUT%>">
                                        <%for (ListaReproduccion l : listasReproduccion) {%>
                                        <option value="<%=l.getNombre()%>"><%=l.getNombre()%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </fieldset>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                            <button type="button" class="btn btn-outline-warning">Incluir</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- FIN MODALES -->

        <script>
            function seleccionarCancion(idCancion, accion) {
                $('#idCancionInput').val(idCancion);
                $('#accionInput').val(accion);

                console.log($('#idCancionInput').val());
                console.log($('#accionInput').val());
            }


            var numFilasIngorar = <%=usuarioConectado.getAdministrador() == 1 ? 3 : 1%>

            function filtrar() {
                // Declare variables
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

            function goto(ruta) {
                $('#formRuta').attr('action', ruta);
                $('#formRuta').submit();
            }
        </script>
    </body>
</html>