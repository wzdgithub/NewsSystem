package com.dao.impl;

import com.bean.Admin;
import com.dao.AdminDao;
import com.utils.SimpleJDBCUtil;

import java.sql.ResultSet;

/**
 * Created by admin on 2016/4/17.
 */
public class AdminDaoImpl implements AdminDao {
    @Override
    public Admin loginAdmin(String adminname, String password) {
        String sql = "select * from t_admin where adminname=? and password=?";
        ResultSet rs = null;
        Admin admin = new Admin();
        try {
            rs = SimpleJDBCUtil.executQuery(sql, new Object[]{adminname, password});
            if(rs.next()){
                admin.setId(rs.getInt(1));
                admin.setAdminname(rs.getString(2));
                admin.setPassword(rs.getString(3));
            }else{
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }
}
