package vn.edu.iuh.fit.connection;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class Connection {
    private EntityManagerFactory entityManagerFactory;
    private static Connection instance;

    public Connection() {
        entityManagerFactory = Persistence.createEntityManagerFactory("nts");
    }

    public static Connection getInstance() {
        if(instance == null)
            instance = new Connection();
        return instance;
    }

    public EntityManagerFactory getEntityManagerFactory() {
        return entityManagerFactory;
    }
}
