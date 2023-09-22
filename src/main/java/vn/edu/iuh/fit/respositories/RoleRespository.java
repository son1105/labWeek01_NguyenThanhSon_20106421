package vn.edu.iuh.fit.respositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.edu.iuh.fit.connection.Connection;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.Role;

import java.util.ArrayList;
import java.util.List;

public class RoleRespository {
    private EntityManager entityManager;
    private EntityTransaction transaction;

    public RoleRespository() {
        entityManager = Connection.getInstance().getEntityManagerFactory().createEntityManager();
    }
    public Role getRole(String id){
        return entityManager.find(Role.class,id);
    }
    public List<Role> getAllRole(){
         transaction = entityManager.getTransaction();
         transaction.begin();
         try {
             transaction.commit();
             return entityManager.createQuery("FROM Role r WHERE r.status = 1 and r.id != 'admin' and r.id != 'user'", Role.class).getResultList();
         }catch (Exception exception){
             exception.printStackTrace();
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
