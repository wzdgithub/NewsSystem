package com.service;

import com.bean.Admin;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ZhenDong on 2017/5/3.
 */
@Service
public class AdminService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public Admin adminLogin(String adminName,String password){
        Admin admin = null;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_admin where admin_name = ? and password = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,adminName);
            ps.setString(2,password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()){
                admin = new Admin();
                admin.setId(rs.getInt(1));
                admin.setAdminName(rs.getString(2));
                admin.setPassword(rs.getString(3));
            }

            rs.close();
            ps.close();
            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }

    public ComboPooledDataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(ComboPooledDataSource dataSource) {
        this.dataSource = dataSource;
    }
}
