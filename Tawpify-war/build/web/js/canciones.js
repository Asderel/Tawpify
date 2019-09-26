function seleccionarCancion(idCancion, accion) {
    $('#idCancionInput').val(idCancion);
    $('#accionInput').val(accion);
}

function incluirCancionLista() {
    $('#idListaReproduccionInput').val($('#listaSeleccionadaInput').val());
}

function setupCancionCrear() {
    $('#accionInput').val(15);
    $('#idAlbumInput').val($('#idAlbumInputModal').val());
}

function filtrar(numFilasIgnorar) {
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
            for (j = 0; j < columnas.length - numFilasIgnorar; j++) {
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


