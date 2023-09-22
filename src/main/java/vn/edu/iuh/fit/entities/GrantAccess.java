package vn.edu.iuh.fit.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "grant_access")
public class GrantAccess {
    @Id
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;
    @Id
    @ManyToOne
    @JoinColumn(name = "account_id")
    private Account account;
    @Column(name = "is_grant")
    private boolean isGrant;
    private String note;

    public GrantAccess() {
    }

    public GrantAccess(Role role, Account account, boolean isGrant, String note) {
        this.role = role;
        this.account = account;
        this.isGrant = isGrant;
        this.note = note;
    }

    public Role getRoleId() {
        return role;
    }

    public void setRoleId(Role roleId) {
        this.role = roleId;
    }

    public Account getAccId() {
        return account;
    }

    public void setAccId(Account accId) {
        this.account = accId;
    }

    public boolean isGrant() {
        return isGrant;
    }

    public void setGrant(boolean grant) {
        isGrant = grant;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "GrantAccess{" +
                "roleId=" + role +
                ", accId=" + account +
                ", isGrant=" + isGrant +
                ", note='" + note + '\'' +
                '}';
    }
}
