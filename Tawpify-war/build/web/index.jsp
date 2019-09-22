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
        <title>Index</title>

        <%
            String resp = session.getAttribute("resp") != null ? session.getAttribute("resp").toString() : "";
        %>
    </head>
    <body>

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
                    <a href="login.jsp">Accede</a>
                </li>

                <li class="nav-item">
                    <button class="btn btn-outline-secondary my-2 mx-2 my-sm-0" type="submit">Registrate</button>
                    <a href="login.jsp">Registrate</a>
                </li>
            </ul>
        </nav>

        <div class="container-fluid">
            <div id="contenedorContenido" class="row">
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
                                <td><a href="listas.jsp" class="nav-link">Listas de reproduccion</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="usuarios.jsp" class="nav-link">Usuarios</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="contenido" class="col-10">
                    <div class="jumbotron" style="padding: 1rem 2rem">
                        <h1 class="row" style="font-size: 2em">Bienvenido de nuevo a Tawpify</h1>
                        <p class="row" style="font-size: 1em">
                            Su gestor de música preferido
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>

<!--
<div class="container-fluid">

                        <div class="mt-2 mb-2">

                            <form action="IndexServlet" method="POST">
                                <div class="row align-content-end">
                                    <fieldset>
                                        <legend>Use 'CTRL' and right click to select several artists</legend>
                                        <div class="form-group">
                                            <label for="exampleSelect2">Filter by artist</label>
                                            <select multiple="" class="form-control" name="artistas" id="artistasFilter" style="width: ">
                                                <option value="a">a</option>
                                            </select>
                                        </div>

                                        <button type="submit" class="btn btn-outline-warning">Filter</button>
                                    </fieldset>
                                </div>
                            </form>
                        </div>

                        <div>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">Artist</th>
                                        <th scope="col">Album</th>
                                        <th scope="col">Song</th>
                                        <th scope="col">Release</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="table-active">
                                        <td>a</td>
                                        <td>a</td>
                                        <td>a</td>
                                        <td>a</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
-->