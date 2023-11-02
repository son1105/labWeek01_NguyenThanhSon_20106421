package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.edu.iuh.fit.connection.Connection;
import vn.edu.iuh.fit.entities.GrantAccess;

import javax.swing.text.html.Option;
import java.util.Optional;

public class GrantAccessRepository {
    private final EntityManager entityManager;
    private final EntityTransaction transaction;
    private final AccountRepository accountRepository;
    private final RoleRepository roleRepository;

    public GrantAccessRepository() {
        entityManager = Connection.getInstance().getEntityManagerFactory().createEntityManager();
        transaction = entityManager.getTransaction();
        accountRepository = new AccountRepository();
        roleRepository = new RoleRepository();
    }

    public GrantAccess getOneByAccountIdAndRoleId(String accId, String roleId){
        transaction.begin();
        try {
            GrantAccess grantAccess = entityManager.createQuery("From GrantAccess ga where ga.account.id=:accId and ga.role.id=:roleId", GrantAccess.class)
                            .setParameter("accId", accId)
                                    .setParameter("roleId", roleId)
                                            .getSingleResult();
            transaction.commit();
            return grantAccess;
        } catch (Exception exception){
            System.out.println(exception.getMessage());
            transaction.rollback();
        }
        return null;
    }

    public boolean addGrantAccess(GrantAccess grantAccess){
        transaction.begin();
        try {
            entityManager.persist(grantAccess);
            transaction.commit();
            return true;
        } catch (Exception exception){
            System.out.println(exception.getMessage());
            transaction.rollback();
        }
        return false;
    }

    public boolean updateGrantAccess(GrantAccess grantAccess){
        transaction.begin();
        try {
            entityManager.merge(grantAccess);
            transaction.commit();
            return true;
        } catch (Exception exception){
            System.out.println(exception.getMessage());
            transaction.rollback();
        }
        return false;
    }
}
