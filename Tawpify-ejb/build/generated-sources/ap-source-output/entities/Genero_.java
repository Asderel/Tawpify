package entities;

import entities.Album;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2019-09-23T23:43:34")
@StaticMetamodel(Genero.class)
public class Genero_ { 

    public static volatile SingularAttribute<Genero, Integer> idGenero;
    public static volatile CollectionAttribute<Genero, Album> albumCollection;
    public static volatile SingularAttribute<Genero, String> nombre;

}