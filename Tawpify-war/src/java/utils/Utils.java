package utils;

public class Utils {

    public static final String NIL = "nil";

    public static final String PLACEHOLDER_FECHA = "__-__-____";

    // CODIGOS CRUD
    public static final int OP_CREAR = 1;
    public static final int OP_BORRAR = 2;
    public static final int OP_MODIFICAR = 3;
    public static final int OP_CREATE = 4;
    public static final int OP_LISTAR = 5;
    public static final int OP_FILTRAR = 6;

    // CODIGOS ACCIONES
    public static final int OP_REDIRECCION_MODIFICAR = 7;
    public static final int OP_REGISTRAR = 8;
    public static final int OP_LOGIN = 9;
    public static final int OP_CREAR_CANCION_ALBUM = 10;
    public static final int OP_BORRAR_CANCION_ALBUM = 11;
    public static final int OP_BORRAR_CANCION_LISTA = 12;
    public static final int OP_INCLUIR_CANCION_LISTA = 13;
    public static final int OP_INCLUIR_ALBUM_LISTA = 14;
    public static final int OP_REDIRECCION_CREAR_CANCION = 15;

    // Codigo operaciones
    public static final String OPCODE = "opcode";

    // Input genericos
    public static final String NOMBREINPUT = "nombreInput";
    public static final String FECHASALIDAINPUT = "fechaSalidaInput";

    // Input Usuario
    public static final String IDUSUARIOINPUT = "idUsuarioInput";
    public static final String EMAILINPUT = "emailInput";
    public static final String APODOINPUT = "apodoInput";
    public static final String CONTRASENAINPUT = "contrasenaInput";
    public static final String ADMINISTRADORINPUT = "administradorInput";

    // Input Genero
    public static final String IDGENEROINPUT = "idGeneroInput";

    // Input Cancion
    public static final String IDCANCIONINPUT = "idCancionInput";
    public static final String URLINPUT = "urlInput";
    public static final String ARTISTASELECCIONADOSNPUT = "artistaSeleccionadosInput";
    public static final String ARTISTASSELECCIONADOSNPUT = "artistasSeleccionadosInput";
    public static final String ALBUMSELECCIONADOINPUT = "albumSeleccionadoInput";
    public static final String LISTASELECCIONADAINPUT = "listaSeleccionadaInput";
    public static final String LISTASELECCIONADAALBUMINPUT = "listaSeleccionadaAlbumInput";

    // Input Album
    public static final String IDALBUMINPUT = "idAlbumInput";
    public static final String IDGENEROSSELECCIONADOSALBUM = "idGenerosSeleccionadosAlbum";

    // Input Album
    public static final String IDARTISTAINPUT = "idAlbumInput";

    // Input ListaReproduccion
    public static final String IDLISTAREPRODUCCIONINPUT = "idListaReproduccionInput";
    public static final String IDLISTAREPRODUCCIONALBUMINPUT = "idListaReproduccionAlbumInput";
    public static final String IDCANCIONESSELECCIONADASLISTA = "idCancionesSeleccionadasLista";

    // ENRUTADOR
    public static final String RUTA = "ruta";
    public static final int RUTA_CANCIONES = 21;
    public static final int RUTA_ALBUMES = 22;
    public static final int RUTA_ARTISTAS = 23;
    public static final int RUTA_GENEROS = 24;
    public static final int RUTA_LISTAS = 25;
    public static final int RUTA_USUARIOS = 26;

    public static final String CANCIONES = "/canciones.jsp";
    public static final String ALBUMES = "/albumes.jsp";
    public static final String ARTISTAS = "/artistas.jsp";
    public static final String GENEROS = "/generos.jsp";
    public static final String LISTAS = "/listasReproduccion.jsp";
    public static final String USUARIOS = "/usuarios.jsp";

    public static final String APP_PATH = "/Tawpify-war";
}
