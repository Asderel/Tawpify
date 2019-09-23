package entities;

import entities.Cancion;
import entities.ListaReproduccionPK;
import entities.Usuario;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2019-09-23T23:43:34")
@StaticMetamodel(ListaReproduccion.class)
public class ListaReproduccion_ { 

    public static volatile SingularAttribute<ListaReproduccion, ListaReproduccionPK> listaReproduccionPK;
    public static volatile SingularAttribute<ListaReproduccion, Date> fechaCreacion;
    public static volatile SingularAttribute<ListaReproduccion, Usuario> usuario;
    public static volatile SingularAttribute<ListaReproduccion, String> nombre;
    public static volatile SingularAttribute<ListaReproduccion, Cancion> cancion;

}