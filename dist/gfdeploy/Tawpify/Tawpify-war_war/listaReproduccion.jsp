<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entities.Cancion"%>
<%@page import="utils.Utils"%>
<%@page import="entities.ListaReproduccion"%>
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

            ListaReproduccion listaSeleccionada = session.getAttribute("listaSeleccionada") != null ? (ListaReproduccion) session.getAttribute("listaSeleccionada") : null;
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        %>

        <title>Lista reproduccion</title>
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
                        <h1 class="row" style="font-size: 2em">
                            <span>
                                <%=listaSeleccionada.getNombre().toUpperCase()%>
                            </span>
                        </h1>
                        <p class="row" style="font-size: 1em">
                            <span class="mr-3">
                                Canciones:
                            </span>
                            <span>
                                <%=listaSeleccionada.getCancionCollection().size()%>
                            </span>
                        </p>
                    </div>

                    <!-- FIN JUMBOTRON -->

                    <!-- LISTADO CANCIONES -->

                    <div class="col-12 mt-2">
                        <div class="row my-2 justify-content-end">
                            <div class="col-3">
                                <input type="text" class="form-control" id="filtroInput" aria-describedby="filtroInput" placeholder="Filtra en la tabla"
                                       onkeyup="filtrar()">
                            </div>
                        </div>

                        <form id="cancionesForm" action="ListaReproduccionCRUDServlet" method="POST">
                            <input id="<%=Utils.IDCANCIONINPUT%>" name="<%=Utils.IDCANCIONINPUT%>" value="" type="hidden"/>
                            <input id="<%=Utils.IDLISTAREPRODUCCIONINPUT%>" name="<%=Utils.IDLISTAREPRODUCCIONINPUT%>" value="<%=listaSeleccionada.getIdListaReproduccion()%>" type="hidden"/>
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
                                </tr>
                            </thead>
                            <%for (Cancion c : listaSeleccionada.getCancionCollection()) {%>
                            <tbody>
                                <tr class="table-active">
                                    <th scope="row"><a class="btn btn-outline-warning far fa-play-circle" target=_blank" href="<%=c.getUrl()%>"
                                                       style="border: none; font-size: 1.5em"></a></th>
                                    <td><%=c.getNombre()%></td>
                                    <td><%=c.getIdAlbum().getNombre()%></td>
                                    <td><%=c.getIdAlbum().getIdArtista().getNombre()%></td>
                                    <td><%=formatter.format(c.getFechaSalida())%></td>

                                    <td><button class="btn btn-outline-warning" type="submit" form="cancionesForm" onclick="seleccionarCancion(<%=c.getIdCancion()%>, <%=Utils.OP_BORRAR_CANCION_LISTA%>)"
                                                title="Eliminar cancion"
                                                style="border: none;"><span class="far fa-times-circle"/></button></td>
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

        <script>
            function seleccionarCancion(idCancion, accion) {
                $('#idCancionInput').val(idCancion);
                $('#accionInput').val(accion);
            }

            var numFilasIngorar = <%=usuarioConectado.getAdministrador() == 1 ? 1 : 1%>

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
                        for (j = 1; j < columnas.length - numFilasIngorar; j++) {
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