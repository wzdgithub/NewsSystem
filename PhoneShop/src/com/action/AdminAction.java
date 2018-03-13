package com.action;

import com.bean.Admin;
import com.service.AdminService;


public class AdminAction {
    private int id;
    private String username;
    private String password;
    private AdminService adminService = new AdminService();

    public String loginAdmin(){
        Admin admin = adminService.loginAdmin(username,password);
        if(admin != null){
            return "loginAdminSuccess";
        }else{
            return "loginAdminFailed";
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
