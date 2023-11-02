package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.edu.iuh.fit.connection.Connection;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.GrantAccess;
import vn.edu.iuh.fit.entities.Role;

import java.util.List;
import java.util.Objects;

public class AccountRepository {
    private final EntityManager entityManager;
    private final EntityTransaction transaction;
    private final RoleRepository roleRepository;

    public AccountRepository() {
        entityManager = Connection.getInstance().getEntityManagerFactory().createEntityManager();
        transaction = entityManager.getTransaction();
        roleRepository = new RoleRepository();
    }
    public boolean addAccount(Account account){
        transaction.begin();
        try{
            entityManager.persist(account);
            GrantAccess grantAccess = new GrantAccess(new RoleRepository().getRole("user"), account, true, "");
            entityManager.persist(grantAccess);
            transaction.commit();
            return true;
        }catch (Exception exception){
            System.out.println(exception.getMessage());
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
            System.out.println(exception.getMessage());
            transaction.rollback();
        }
        return false;
    }

    public boolean grantAccount(String accountId, String roleId, String note){
        transaction.begin();
        try{
            if(note == null) note="";
            GrantAccess grantAccess = new GrantAccess(new RoleRepository().getRole(roleId), new AccountRepository().getAccountById(accountId), true, note);
            entityManager.persist(grantAccess);
            transaction.commit();
            return true;
        }catch (Exception exception){
            System.out.println(exception.getMessage());
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
            System.out.println(exception.getMessage());
            transaction.rollback();
        }
        return null;
    }

    public Account getAccountByEmailAndPassword(String email, String password){
        transaction.begin();
        try{
            Account account = entityManager.createQuery("Select acc from Account acc where acc.email=:email and acc.password=:password and acc.status=1", Account.class)
                    .setParameter("email", email)
                    .setParameter("password", password).getSingleResult();
            transaction.commit();
            return account;
        }catch (Exception exception){
            System.out.println(exception.getMessage());
            transaction.rollback();
        }
        return null;
    }
    public List<Account> getAccountFromRoleName(String name){
        if(name.equalsIgnoreCase("All"))
            return getAllAccountUser();
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
            System.out.println(exception.getMessage());
            transaction.rollback();
        }
        return null;
    }

    public boolean checkAdmin(String id){
        transaction.begin();
        try{
            boolean check = false;
            for(Role role: roleRepository.getRoleFromAccountID(id)){
                if(Objects.equals(role.getId(), "admin")){
                    check = true;
                    break;
                }
            }
            transaction.commit();
            return check;
        } catch (Exception exception){
            System.out.println(exception.getMessage());
            transaction.rollback();
        }
        return false;
    }
    public boolean checkUser(String id){
        transaction.begin();
        try{
            boolean check = false;
            for(Role role: roleRepository.getRoleFromAccountID(id)){
                if(Objects.equals(role.getId(), "user")){
                    check = true;
                    break;
                }
            }
            transaction.commit();
            return check;
        } catch (Exception exception){
            System.out.println(exception.getMessage());
            transaction.rollback();
        }
        return false;
    }
}
