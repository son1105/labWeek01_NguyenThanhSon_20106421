package vn.edu.iuh.fit.respositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.edu.iuh.fit.connection.Connection;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.Log;

import java.time.LocalDateTime;

public class LogRespository {
    private EntityManager entityManager;
    private EntityTransaction transaction;

    public LogRespository() {
        entityManager = Connection.getInstance().getEntityManagerFactory().createEntityManager();
        transaction = entityManager.getTransaction();
    }
    public boolean addLog(Log log){
        transaction.begin();
        try {
            entityManager.persist(log);
            transaction.commit();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            transaction.rollback();
        }
        return false;
    }
    public boolean updateLog(Log log){
        transaction.begin();
        try {
            entityManager.merge(log);
            transaction.commit();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            transaction.rollback();
        }
        return false;
    }
    public long getLogId(Account account, LocalDateTime timeLogin){
        transaction.begin();
        try {
            Long a = entityManager.createQuery("select l.id from Log l where l.account.id=:id and l.loginTime=:timeLogin", Long.class)
                    .setParameter("id", account.getId())
                    .setParameter("timeLogin", timeLogin)
                    .getSingleResult();
            System.out.println(a);
            transaction.commit();
            return a;
        }catch (Exception e){
            e.printStackTrace();
            transaction.rollback();
        }
        return 0;
    }
}
