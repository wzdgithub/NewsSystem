package com.dao.impl;

import com.bean.Admin;
import com.dao.AdminDao;
import com.utils.SimpleJDBCUtil;

import java.sql.ResultSet;


public class AdminDaoImpl implements AdminDao {
    @Override
    public Admin loginAdmin(String username, String password) {
        String sql = "select * from t_admin where username = ? and password = ?";
        Admin admin = new Admin();
        try {
            ResultSet rs = SimpleJDBCUtil.executQuery(sql,new Object[]{username,password});
            if(rs.next()){
                admin.setId(rs.getInt(1));
                admin.setUsername(rs.getString(2));
                admin.setPassword(rs.getString(3));
                return admin;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
