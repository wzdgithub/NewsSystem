package com.action;

import com.bean.Admin;
import com.dao.AdminDao;
import com.dao.impl.AdminDaoImpl;
import org.apache.struts2.ServletActionContext;

import java.util.Map;

/**
 * Created by admin on 2016/4/17.
 */
public class AdminAction {
    private int id;
    private String adminname;
    private String password;

    private AdminDao adminDao = new AdminDaoImpl();

    public String loginAdmin(){
        Admin admin = adminDao.loginAdmin(adminname,password);
        if(admin==null){
            return "loginAdminFailure";
        }else {
            Map session = ServletActionContext.getContext().getSession();
            session.put("admin", admin);
            return "loginAdminSuccess";
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAdminname() {
        return adminname;
    }

    public void setAdminname(String adminname) {
        this.adminname = adminname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
