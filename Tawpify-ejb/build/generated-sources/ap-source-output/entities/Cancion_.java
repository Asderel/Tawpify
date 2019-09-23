package entities;

import entities.Album;
import entities.Artista;
import entities.ListaReproduccion;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2019-09-23T23:43:34")
@StaticMetamodel(Cancion.class)
public class Cancion_ { 

    public static volatile SingularAttribute<Cancion, Integer> idCancion;
    public static volatile CollectionAttribute<Cancion, ListaReproduccion> listaReproduccionCollection;
    public static volatile SingularAttribute<Cancion, Date> fechaSalida;
    public static volatile CollectionAttribute<Cancion, Artista> artistaCollection;
    public static volatile SingularAttribute<Cancion, String> nombre;
    public static volatile SingularAttribute<Cancion, Album> idAlbum;

}