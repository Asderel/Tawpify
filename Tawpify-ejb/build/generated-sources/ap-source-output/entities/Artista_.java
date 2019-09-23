package entities;

import entities.Album;
import entities.Cancion;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2019-09-23T23:43:34")
@StaticMetamodel(Artista.class)
public class Artista_ { 

    public static volatile CollectionAttribute<Artista, Cancion> cancionCollection;
    public static volatile SingularAttribute<Artista, Integer> idArtista;
    public static volatile CollectionAttribute<Artista, Album> albumCollection;
    public static volatile SingularAttribute<Artista, String> nombre;

}