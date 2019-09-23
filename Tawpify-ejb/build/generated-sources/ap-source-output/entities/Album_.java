package entities;

import entities.Artista;
import entities.Cancion;
import entities.Genero;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2019-09-23T23:43:34")
@StaticMetamodel(Album.class)
public class Album_ { 

    public static volatile CollectionAttribute<Album, Cancion> cancionCollection;
    public static volatile SingularAttribute<Album, Date> fechaSalida;
    public static volatile SingularAttribute<Album, Artista> idArtista;
    public static volatile CollectionAttribute<Album, Genero> generoCollection;
    public static volatile SingularAttribute<Album, Integer> idAlbum;
    public static volatile SingularAttribute<Album, String> nombre;

}