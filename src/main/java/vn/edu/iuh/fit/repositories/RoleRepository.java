package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.edu.iuh.fit.connection.Connection;
import vn.edu.iuh.fit.entities.Role;

import java.util.ArrayList;
import java.util.List;

public class RoleRepository {
    private final EntityManager entityManager;
    private final EntityTransaction transaction;

    public RoleRepository() {
        entityManager = Connection.getInstance().getEntityManagerFactory().createEntityManager();
        transaction = entityManager.getTransaction();
    }
    public Role getRole(String id){
        return entityManager.find(Role.class,id);
    }
    public List<Role> getAllRole(){
         transaction.begin();
         try {
             List<Role> roles = entityManager.createQuery("FROM Role r WHERE r.status = 1 and r.id != 'admin' and r.id != 'user' ORDER BY REVERSE(r.name)" , Role.class).getResultList();
             transaction.commit();
             return roles;
         }catch (Exception exception){
             System.out.println(exception.getMessage());
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
            System.out.println(exception.getMessage());
            transaction.rollback();
        }
        return null;
    }

    public List<String> getRoleName(List<Role> roles){
        List<String> roleNames = new ArrayList<>();
        for (Role role: roles) {
            roleNames.add(role.getName());
        }
        return roleNames;
    }
    public String getRoleIdFromRoleName(String roleName){
        return entityManager.createQuery("select r.id from Role r where r.name=:name", String.class)
                .setParameter("name", roleName).getSingleResult();
    }
}
