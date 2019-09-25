<%@page import="utils.Utils"%>
<%@page import="java.util.List"%>
<%@page import="entities.ListaReproduccion"%>
<%@page import="java.text.SimpleDateFormat"%>
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

            List<ListaReproduccion> listasReproduccion = (List) session.getAttribute("listasReproduccion");
        %>

        <title>Listas reproduccion</title>
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
                        <h1 class="row" style="font-size: 2em">Listas de reproduccion</h1>
                        <p class="row" style="font-size: 1em">
                            Aqui puedes ver tus propias listas de reproduccion
                        </p>
                    </div>

                    <!-- FIN JUMBOTRON -->

                    <!-- LISTADO ARTISTAS -->

                    <div class="col-12 mt-2">
                        <div class="row my-2 justify-content-between">
                            <div class="col-3">
                                <button class="btn btn-outline-warning" onclick="setupModalCrearLista()"  type="button" data-toggle="modal" data-target="#modalCrearLista">Nueva lista</button>
                            </div>

                            <div class="col-3">
                                <input type="text" class="form-control" id="filtroInput" aria-describedby="filtroInput" placeholder="Filtra en la tabla"
                                       onkeyup="filtrar()">
                            </div>
                        </div>

                        <form id="listaForm" action="ListaReproduccionCRUDServlet" method="POST">
                            <input id="<%=Utils.IDLISTAREPRODUCCIONINPUT%>" name="<%=Utils.IDLISTAREPRODUCCIONINPUT%>" value="" type="hidden"/>
                            <input id="accionInput" name="<%=Utils.OPCODE%>" value="" type="hidden"/>

                            <input id="<%=Utils.NOMBREINPUT%>" name="<%=Utils.NOMBREINPUT%>" value="" type="hidden"/>
                            <input id="<%=Utils.FECHASALIDAINPUT%>" name="<%=Utils.FECHASALIDAINPUT%>" value="" type="hidden"/>
                        </form>


                        <table id="tablaArtistas" class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Lanzamiento</th>
                                    <th scope="col"></th>
                                    <th scope="col"></th>
                                    <th scope="col"></th>
                                </tr>
                            </thead>

                            <% for (ListaReproduccion l : listasReproduccion) {%>
                            <tbody>
                                <tr class="table-active">
                                    <td><%=l.getNombre()%></td>
                                    <td><%=formatter.format(l.getFechaCreacion())%></td>

                                    <td><button class="btn btn-outline-warning" type="submit" form="listaForm"
                                                onclick="seleccionarLista(<%=l.getListaReproduccionPK().getIdCancion()%>, <%=l.getListaReproduccionPK().getIdUsuario()%>, <%=Utils.OP_LISTAR%>)"
                                                title="Ver album"
                                                style="border: none;"><span class="far fa-eye"/></button></td>

                                    <td><button class="btn btn-outline-warning" type="button" form="listaForm" data-toggle="modal" data-target="#modalModificarLista"
                                                onclick="seleccionarLista(<%=l.getListaReproduccionPK().getIdCancion()%>, <%=l.getListaReproduccionPK().getIdUsuario()%>, <%=Utils.OP_MODIFICAR%>)"
                                                title="Modificar album"
                                                style="border: none;"><span class="far fa-edit"/></button></td>

                                    <td><button class="btn btn-outline-warning" type="submit" form="listaForm"
                                                onclick="seleccionarLista(<%=l.getListaReproduccionPK().getIdCancion()%>, <%=l.getListaReproduccionPK().getIdUsuario()%>, <%=Utils.OP_BORRAR%>)"
                                                title="Eliminar album"
                                                style="border: none;"><span class="fas fa-trash"/></button></td>
                                </tr>
                            </tbody>
                            <input id="nombreOculto_<%=l.getListaReproduccionPK().getIdCancion()%>_<%=l.getListaReproduccionPK().getIdUsuario()%>" type="hidden" value="<%=l.getNombre()%>">
                            <input id="fechaOculta_<%=l.getListaReproduccionPK().getIdCancion()%>_<%=l.getListaReproduccionPK().getIdUsuario()%>" type="hidden" value="<%=l.getFechaCreacion()%>">
                            <%}%>
                        </table>
                    </div>

                    <!-- FIN LISTADO ARTISTAS -->

                </div>

                <!-- CONTENIDO -->

            </div>

            <!-- MODALES -->

            <div id="modalCrearLista" class="modal fade">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                Crear Lista de reproduccion
                            </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <fieldset>
                                <legend style="font-size: 1.2em">Datos</legend>
                                <div class="form-group">
                                    <label for="<%=Utils.NOMBREINPUT%>">Nombre</label>
                                    <input id="nombreModalLista" type="text" class="form-control" id="<%=Utils.NOMBREINPUT%>" placeholder="Nombre" name="<%=Utils.NOMBREINPUT%>"/>
                                </div>

                            </fieldset>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                            <button type="submit" form="listaForm" onclick="setupCrearGenero()" class="btn btn-outline-warning">Listo</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="modalModificarLista" class="modal fade">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                Modificar lista de reproduccion
                            </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <fieldset>
                                <legend style="font-size: 1.2em">Datos</legend>
                                <div class="form-group">
                                    <label for="<%=Utils.NOMBREINPUT%>">Nombre</label>
                                    <input id="nombreModalLista" type="text" class="form-control" id="<%=Utils.NOMBREINPUT%>" placeholder="Nombre" name="<%=Utils.NOMBREINPUT%>"/>
                                </div>

                                <div class="form-group">
                                    <label for="<%=Utils.FECHASALIDAINPUT%>">Fecha Creacion</label>
                                    <input id="fechaModalLista" type="text" class="form-control" id="<%=Utils.FECHASALIDAINPUT%>" placeholder="<%=Utils.PLACEHOLDER_FECHA%>" name="<%=Utils.FECHASALIDAINPUT%>"/>
                                </div>
                            </fieldset>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                            <button type="submit" form="listaForm" onclick="setupModalLista()" class="btn btn-outline-warning">Listo</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- FIN MODALES -->
        </div>

        <script>
            function seleccionarLista(idCancion, idUsuario, accion) {
                $('#idCancionInput').val(idCancion);
                $('#idUsuarioInput').val(idUsuario);
                $('#accionInput').val(accion);

                // Seteo para el modal
                $('#nombreModalLista').val($('#nombreOculto_' + idCancion + '_' + idUsuario).val());
                $('#fechaModalLista').val($('#fechaOculta_' + idCancion).val());
                $('#accionInput').val(<%=Utils.OP_MODIFICAR%>);
            }

            function setupModalLista() {
                $('#<%=Utils.NOMBREINPUT%>').val($('#nombreModalLista').val());
                $('#<%=Utils.FECHASALIDAINPUT%>').val($('#fechaModalLista').val());
            }

            function setupModalCrearLista() {
                $('#accionInput').val(<%=Utils.OP_CREAR%>);
            }

            function filtrar() {
                var input, filtro, tabla, cuerpo, fila, columnas, x, i, j, valor;
                input = document.getElementById("filtroInput");
                filtro = input.value.toUpperCase();
                tabla = document.getElementById("tablaArtistas");
                cuerpo = tabla.getElementsByTagName('tbody');

                for (x = 0; cuerpo.length; x++) {
                    fila = cuerpo[x].getElementsByTagName('tr');
                    for (i = 0; i < fila.length; i++) {
                        columnas = fila[i].getElementsByTagName("td");
                        for (j = 0; j < columnas.length - 3; j++) {
                            valor = columnas[j].textContent || columnas[j].innerText;
                            if (valor.toUpperCase().indexOf(filtro) > -1) {
                                fila[i].style.display = "";
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