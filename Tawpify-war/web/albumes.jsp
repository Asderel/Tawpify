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

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/86da25765b.js" crossorigin="anonymous"></script>

        <%
            Usuario usuarioConectado = session.getAttribute("usuarioConectado") != null ? (Usuario) session.getAttribute("usuarioConectado") : null;
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

            List<Artista> artistas = (List) session.getAttribute("artistas");
            List<Album> albumes = (List) session.getAttribute("albumes");
            List<ListaReproduccion> listasReproduccion = (List) request.getAttribute("listasReproduccion");
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
                        <div class="row my-2 justify-content-between">
                            <div class="col-3">
                                <a class="btn btn-outline-warning" href="nuevoAlbum.jsp?<%=Utils.OPCODE%>=<%=Utils.OP_CREAR%>">Nuevo album</a>
                            </div>

                            <div class="col-3">
                                <input type="text" class="form-control" id="filtroInput" aria-describedby="filtroInput" placeholder="Filtra en la tabla"
                                       onkeyup="filtrar()">
                            </div>
                        </div>

                        <form id="albumesForm" action="AlbumCRUDServlet" method="POST">
                            <input id="<%=Utils.IDALBUMINPUT%>" name="<%=Utils.IDALBUMINPUT%>" value="" type="hidden"/>
                            <input id="accionInput" name="<%=Utils.OPCODE%>" value="" type="hidden"/>
                        </form>

                        <table id="tablaCanciones" class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">Artista</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Lanzamiento</th>
                                    <th scope="col"></th>
                                    <th scope="col"></th>
                                    <th scope="col"></th>
                                </tr>
                            </thead>

                            <%for(Album al : albumes) {%>
                            <tbody>
                                <tr class="table-active">
                                    <td><%=al.getIdArtista().getNombre()%></td>
                                    <td><%=al.getNombre()%></td>
                                    <td><%=formatter.format(al.getFechaSalida())%></td>

                                    <td><button class="btn btn-outline-warning" type="submit" form="albumesForm" onclick="seleccionarAlbum(<%=al.getIdAlbum()%>, <%=Utils.OP_LISTAR%>)"
                                                title="Ver album"
                                                style="border: none;"><span class="far fa-eye"/></button></td>

                                    <td><button class="btn btn-outline-warning" type="submit" form="albumesForm" onclick="seleccionarAlbum(<%=al.getIdAlbum()%>, <%=Utils.OP_REDIRECCION_MODIFICAR%>)"
                                                title="Modificar album"
                                                style="border: none;"><span class="far fa-edit"/></button></td>

                                    <td><button class="btn btn-outline-warning" type="submit" form="albumesForm" onclick="seleccionarAlbum(<%=al.getIdAlbum()%>, <%=Utils.OP_BORRAR%>)"
                                                title="Eliminar album"
                                                style="border: none;"><span class="fas fa-trash"/></button></td>
                                </tr>
                            </tbody>
                            <%}%>
                        </table>
                    </div>

                    <!-- FIN LISTADO ALBUMES -->

                </div>

                <!-- CONTENIDO -->

            </div>
        </div>

        <script>
            function seleccionarAlbum(idAlbum, accion) {
                $('#idAlbumInput').val(idAlbum);
                $('#accionInput').val(accion);
            }

            var numFilasIngorar = <%=usuarioConectado.getAdministrador() == 1 ? 2 : 0%>

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
                        for (j = 0; j < columnas.length - 3; j++) {
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