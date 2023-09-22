package vn.edu.iuh.fit.respositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.edu.iuh.fit.connection.Connection;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.GrantAccess;
import vn.edu.iuh.fit.entities.Role;

import java.util.List;

public class AccountRespository {
    private EntityManager entityManager;
    private EntityTransaction transaction;

    public AccountRespository() {
        entityManager = Connection.getInstance().getEntityManagerFactory().createEntityManager();
        transaction = entityManager.getTransaction();
    }
    public boolean addAccount(Account account){
        transaction.begin();
        try{
            entityManager.persist(account);
            if(grantAccount(account.getId(), "user", ""))
                transaction.commit();
            else{
                transaction.rollback();
                return false;
            }
            return true;
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return false;
    }
    public boolean updateAccount(Account account){
        transaction.begin();
        try{
            entityManager.merge(account);
            transaction.commit();
            return true;
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return false;
    }
    public boolean grantAccount(String accountId, String roleId, String note){
        transaction.begin();
        try{
            if(note == null) note="";
            GrantAccess grantAccess = new GrantAccess(new RoleRespository().getRole(roleId), new AccountRespository().getAccountById(accountId), true, note);
            entityManager.persist(grantAccess);
            transaction.commit();
            return true;
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return false;
    }
    public Account getAccountById(String id){
        return entityManager.find(Account.class, id);
    }
    public List<Account> getAllAccountUser(){
        transaction.begin();
        try {
            transaction.commit();
            return entityManager.createQuery("FROM Account a WHERE a.status = 1 and a.id IN (SELECT ga.account.id FROM GrantAccess ga WHERE ga.role.id = 'user')", Account.class).getResultList();
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return null;
    }

    public Account getAccountByEmailAndPassword(String email, String password){
        transaction.begin();
        try{
            Account account = entityManager.createQuery("Select acc from Account acc where acc.email=:email and acc.password=:password", Account.class)
                    .setParameter("email", email)
                    .setParameter("password", password).getSingleResult();
            transaction.commit();
            return account;
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return null;
    }
    public List<Role> getRoleFromAccountID(String id){
        transaction.begin();
        try {
            List<Role> roles = entityManager.createQuery(
                            "SELECT r FROM Role r WHERE id IN " +
                                    "(SELECT ga.role.id FROM GrantAccess ga WHERE ga.isGrant and ga.account.id = :id)", Role.class)
                    .setParameter("id", id)
                    .getResultList();
            transaction.commit();
            return roles;
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return null;
    }
    public List<Account> getAccountFromRoleName(String name){
        transaction.begin();
        try {
            List<Account> accounts = entityManager.createQuery("FROM Account a WHERE a.status=1 and a.id IN " +
                            "(SELECT ga.account.id FROM GrantAccess ga WHERE ga.isGrant and ga.role.id IN " +
                            "(SELECT r.id FROM Role r WHERE r.name = :name))", Account.class)
                    .setParameter("name", name)
                    .getResultList();
            transaction.commit();
            return accounts;
        }catch (Exception exception){
            exception.printStackTrace();
            transaction.rollback();
        }
        return null;
    }
}
