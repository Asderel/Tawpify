<%--
    Document   : index
    Created on : 11-sep-2019, 16:23:39
    Author     : alumno
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/bootstrap.min.css">
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
                <li class="nav-item">
                    <span class="badge badge-pill badge-secondary mt-2 mr-4" id="user-pill">WOLOLO</span>
                </li>

                <li class="nav-item">
                    <button class="btn btn-secondary my-2 mx-2 my-sm-0" type="submit">Accede</button>
                </li>

                <li class="nav-item">
                    <button class="btn btn-outline-secondary my-2 mx-2 my-sm-0" type="submit">Registrate</button>
                </li>
            </ul>

        </nav>

        <!-- NAV BAR -->

        <div class="container-fluid">
            <div id="contenedorContenido" class="row">

                <!-- PANEL LATERARL -->

                <div id="panelLateral" class="col-2">
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
                            <tr class="table">
                                <td><a href="usuarios.jsp" class="nav-link">Usuarios</a></td>
                            </tr>
                        </tbody>
                    </table>
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
                        <div class="row my-2 justify-content-between">
                            <div class="col-3">
                                <a class="btn btn-outline-warning" href="nuevoArtista.jsp">Nuevo Artista</a>
                            </div>

                            <div class="col-3">
                                <input type="text" class="form-control" id="filtroInput" aria-describedby="filtroInput" placeholder="Filtra en la tabla"
                                       onkeyup="filtrar()">
                            </div>
                        </div>

                        <form id="artistasForm" action="ArtistaCRUDServlet" method="POST">
                            <input id="idArtistaInput" name="idArtistaInput" value="" type="hidden"/>
                            <input id="accionInput" name="accionInput" value="" type="hidden"/>

                            <table id="tablaArtistas" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Artista</th>
                                        <th scope="col">Album</th>
                                        <th scope="col">Lanzamiento</th>
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
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarartista('1', '1')">Modificar</button></td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarartista('1', '2')">Elminar</button></td>
                                    </tr>
                                </tbody>
                                <tbody>
                                    <tr class="table-active">
                                        <td>b</td>
                                        <td>b</td>
                                        <td>b</td>
                                        <td>b</td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarartista('2', '1')">Modificar</button></td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarartista('2', '2')">Elminar</button></td>
                                    </tr>
                                </tbody>
                                <tbody>
                                    <tr class="table-active">
                                        <td>c</td>
                                        <td>c</td>
                                        <td>c</td>
                                        <td>c</td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarartista('3', '1')">Modificar</button></td>
                                        <td><button class="btn btn-outline-warning" type="submit" onclick="seleccionarartista('3', '2')">Elminar</button></td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>

                    <!-- FIN LISTADO ARTISTAS -->

                </div>

                <!-- CONTENIDO -->

            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

        <script>
                                            function seleccionarartista(idArtista, accion) {
                                                var str = idArtista.concat(accion);
                                                window.alert(str);
                                                $('#idArtistaInput').val(idArtista);
                                                $('#accionInput').val(accion);
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
                                                        for (j = 0; j < columnas.length - 2; j++) {
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