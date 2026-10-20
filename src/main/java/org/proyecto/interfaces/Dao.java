package org.proyecto.interfaces;

import java.util.List;

public interface Dao<O,K> {

    public List<O> getAll();
    public O getById(K id);
    public void insert(O objeto);
    public void update(O objeto);
    public boolean delete(K id);
    public boolean exists(K id);

}
