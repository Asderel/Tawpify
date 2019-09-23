<%@page import="entities.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/bootstrap.min.css">

        <%
            Usuario usuarioConectado = session.getAttribute("usuarioConectado") != null ? (Usuario) session.getAttribute("usuarioConectado") : null;
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
                                                    <label for="seleccionArtistas">Filtra por artista</label>
                                                    <select multiple="true" class="form-control" name="seleccionArtistas" id="seleccionArtistas" size="3">
                                                        <option value="a">a</option>
                                                        <option value="b">b</option>
                                                        <option value="c">c</option>
                                                        <option value="d">d</option>
                                                        <option value="e">e</option>
                                                        <option value="f">f</option>
                                                        <option value="g">g</option>
                                                    </select>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>

                                    <div class="row justify-content-end">
                                        <div class="col-auto">
                                            <button type="submit" class="btn btn-outline-warning">Filtrar</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 mt-2">
                        <div class="row my-2 justify-content-between">
                            <div class="col-3">
                                <a class="btn btn-outline-warning" href="nuevoAlbum.jsp">Nueva cancion</a>
                            </div>

                            <div class="col-3">
                                <input type="text" class="form-control" id="filtroInput" aria-describedby="filtroInput" placeholder="Filtra en la tabla"
                                       onkeyup="filtrar()">
                            </div>
                        </div>

                        <form id="cancionesForm" action="AlbumCRUDServlet" method="POST">
                            <input id="idCancionInput" name="idAlbumInput" value="" type="hidden"/>
                            <input id="accionInput" name="accionInput" value="" type="hidden"/>

                            <table id="tablaCanciones" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Artista</th>
                                        <th scope="col">asdf</th>
                                        <th scope="col">Lanzamiento</th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="table-active">
                                        <td>a</td>
                                        <td>a</td>
                                        <td>a</td>
                                        <td>a</td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarartista('1', '3')">Ver</button></td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarCancion('1', '1')">Modificar</button></td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarCancion('1', '2')">Eliminar</button></td>
                                    </tr>
                                </tbody>
                                <tbody>
                                    <tr class="table-active">
                                        <td>b</td>
                                        <td>b</td>
                                        <td>b</td>
                                        <td>b</td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarartista('1', '3')">Ver</button></td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarCancion('2', '2')">Modificar</button></td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarCancion('2', '2')">Eliminar</button></td>
                                    </tr>
                                </tbody>
                                <tbody>
                                    <tr class="table-active">
                                        <td>c</td>
                                        <td>c</td>
                                        <td>c</td>
                                        <td>c</td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarartista('1', '3')">Ver</button></td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarCancion('3', '1')">Modificar</button></td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarCancion('3', '2')">Eliminar</button></td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>

                    <!-- FIN LISTADO ALBUMES -->

                </div>

                <!-- CONTENIDO -->

            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

        <script>
                                            function seleccionarCancion(idAlbum, accion) {
                                                var str = idAlbum.concat(accion);

                                                window.alert(str);
                                                $('#idAlbumInput').val(idAlbum);
                                                $('#accionInput').val(accion);
                                            }

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