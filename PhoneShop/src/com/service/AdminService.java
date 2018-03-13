package com.service;

import com.bean.Admin;
import com.dao.AdminDao;
import com.dao.impl.AdminDaoImpl;


public class AdminService {
    private AdminDao adminDao = new AdminDaoImpl();
    public Admin loginAdmin(String username,String password){
        return adminDao.loginAdmin(username,password);
    }
}
