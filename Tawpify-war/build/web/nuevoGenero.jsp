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

        <!-- FIN NAV BAR -->

        <div class="container-fluid">
            <div id="contenedorContenido" class="row">

                <!-- PANEL LATERARL -->

                <div id="panelLateral" class="col-2">
                    <table class="table table-hover">
                        <tbody>
                            <tr class="table">
                                <td><a href="#" class="nav-link">Canciones</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="#" class="nav-link">Albumes</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="#" class="nav-link">Artistas</a></td>
                            </tr>
                            <tr class="table">
                                <td><a href="#" class="nav-link">Listas de reproduccion</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- FIN PANEL LATERARL -->


                <!-- CONTENIDO -->

                <div id="contenido" class="col-10">

                    <!-- JUMBOTRON -->

                    <div class="jumbotron" style="padding: 1rem 2rem">
                        <h1 class="row" style="font-size: 2em">Creacion de genero</h1>
                        <p class="row" style="font-size: 1em">
                            Crea un genero nuevo
                        </p>
                    </div>

                    <!-- FIN JUMBOTRON -->

                    <!-- FORMULARIO NUEVO GENERO -->

                    <div class="container">
                        <form action="NuevoGeneroServlet" id="generoForm" >
                            <fieldset>
                                <div class="form-group">
                                    <label for="nombreInput">Nombre</label>
                                    <input type="text" class="form-control" id="nombreInput" placeholder="Nombre" name="nombreInput"/>
                                </div>

                                <div class="form-group">
                                    <label for="xInput">X</label>
                                    <input type="text" class="form-control" id="xInput" placeholder="X" name="xInput"/>
                                </div>

                                <div class="form-group">
                                    <label for="contrasenaInput">Y</label>
                                    <input type="text" class="form-control" id="yInput" placeholder="Y" name="yInput"/>
                                </div>

                                <div>
                                    <button class="btn btn-block btn-warning" type="submit">Listo</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>

                    <!-- FIN FORMULARIO NUEVO GENERO -->

                </div>

                <!-- FIN CONTENIDO -->
            </div>
        </div>



        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>