<%@page import="utils.Utils"%>
<%@page import="java.util.List"%>
<%@page import="entities.Genero"%>
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
            List<Genero> generos = (List) request.getAttribute("generos");
        %>

        <title>Generos</title>
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
                    <input id="accionInput" name="<%=Utils.OPCODE%>" value="<%=Utils.OP_LISTAR%>" type="hidden"/>
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
                        <h1 class="row" style="font-size: 2em">Generos</h1>
                        <p class="row" style="font-size: 1em">
                            Aqui puedes acceder a todas generos registrados
                        </p>
                    </div>

                    <!-- FIN JUMBOTRON -->

                    <!-- LISTADO GENEROS -->

                    <div class="col-12 mt-2">
                        <div class="row my-2 justify-content-between">
                            <div class="col-3">
                                <button class="btn btn-outline-warning" type="button" data-toggle="modal" data-target="#modalCrearGenero">Nuevo genero</button>
                            </div>
                            <div class="col-3">
                                <input type="text" class="form-control" id="filtroInput" aria-describedby="filtroInput" placeholder="Filtra en la tabla"
                                       onkeyup="filtrar()">
                            </div>
                        </div>

                        <form id="generosForm" action="GeneroCRUDServlet" method="POST">
                            <input id="idGeneroInput" name="<%=Utils.IDGENEROINPUT%>" value="" type="hidden"/>
                            <input id="accionInput" name="<%=Utils.OPCODE%>" value="" type="hidden"/>
                            <input id="nombreInput" name="<%=Utils.NOMBREINPUT%>" value="" type="hidden"/>
                        </form>

                        <table id="tablaGeneros" class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">Nombre</th>
                                    <th scope="col"></th>
                                    <th scope="col"></th>
                                </tr>
                            </thead>
                            <%for (Genero g : generos) {%>
                            <tbody>
                                <tr class="table-active">
                                    <td><%=g.getNombre()%></td>
                                    <td><button class="btn btn-outline-warning" type="button" data-toggle="modal" data-target="#modalModificarGenero"
                                                onclick="seleccionarGenero(<%=g.getIdGenero()%>, <%=Utils.OP_MODIFICAR%>)">Modificar</button></td>
                                    <td><button class="btn btn-outline-warning" form="generosForm" type="submit" onclick="seleccionarGenero(<%=g.getIdGenero()%>, <%=Utils.OP_BORRAR%>)">Eliminar</button></td>
                                </tr>
                            </tbody>
                            <input id="nombreOculto_<%=g.getIdGenero()%>" type="hidden" value="<%=g.getNombre()%>">
                            <%}%>
                        </table>
                    </div>

                    <!-- FIN LISTADO GENEROS -->

                </div>

                <!-- CONTENIDO -->

            </div>
        </div>

        <!-- MODALES -->

        <div id="modalCrearGenero" class="modal fade">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            Crear genero
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <fieldset>
                            <legend style="font-size: 1.2em">Datos</legend>
                            <div class="form-group">
                                <label for="<%=Utils.NOMBREINPUT%>ModalCrearGenero">Nombre</label>
                                <input type="text" class="form-control" id="<%=Utils.NOMBREINPUT%>ModalCrearGenero" placeholder="Nombre"/>
                            </div>
                        </fieldset>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="generosForm" onclick="setupCrearGenero()" class="btn btn-outline-warning">Listo</button>
                    </div>
                </div>
            </div>
        </div>

        <div id="modalModificarGenero" class="modal fade">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            Modificar genero
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <fieldset>
                            <legend style="font-size: 1.2em">Datos</legend>
                            <div class="form-group">
                                <label for="<%=Utils.NOMBREINPUT%>ModificarGenero">Nombre</label>
                                <input id="nombreInputModalModificarGenero" type="text" class="form-control" placeholder="Nombre" value=""/>
                            </div>
                        </fieldset>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                        <button type="submit" form="generosForm" onclick="setupModificarGenero()" class="btn btn-outline-warning">Listo</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- FIN MODALES -->

        <script>
            function seleccionarGenero(idGenero, accion) {
                $('#idGeneroInput').val(idGenero);
                $('#accionInput').val(accion);
                $('#nombreInputModalModificarGenero').val($('#nombreOculto_' + idGenero).val());
            }

            function setupModificarGenero() {
                $('#nombreInput').val($('#nombreInputModalModificarGenero').val());
            }

            function setupCrearGenero() {
                $('#nombreInput').val($('#nombreInputModalCrearGenero').val());
                $('#accionInput').val(<%=Utils.OP_CREAR%>);
            }

            var numFilasIngorar = <%=usuarioConectado.getAdministrador() == 1 ? 2 : 0%>

            function filtrar() {
                var input, filtro, tabla, cuerpo, fila, columnas, x, i, j, valor;
                input = document.getElementById("filtroInput");
                filtro = input.value.toUpperCase();
                tabla = document.getElementById("tablaGeneros");
                cuerpo = tabla.getElementsByTagName('tbody');

                for (x = 0; cuerpo.length; x++) {
                    fila = cuerpo[x].getElementsByTagName('tr');
                    for (i = 0; i < fila.length; i++) {
                        columnas = fila[i].getElementsByTagName("td");
                        for (j = 0; j < columnas.length - numFilasIngorar; j++) {
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