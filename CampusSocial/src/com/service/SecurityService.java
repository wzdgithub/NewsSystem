package com.service;

import com.bean.Security;
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
public class SecurityService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertSecurity(Security security){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_security(security_Question,security_answer,user_id) values (?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,security.getSecurityQuestion());
            ps.setString(2,security.getSecurityAnswer());
            ps.setInt(3,security.getUserId());
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public int updateSecurity(Security security){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "update t_security set security_question= ?,security_answer= ? WHERE user_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,security.getSecurityQuestion());
            ps.setString(2,security.getSecurityAnswer());
            ps.setInt(3,security.getUserId());
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public int modifySecurity(String oldAnswer,String newAnswer,String newQuestion,int userId){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "update t_security set security_question= ?,security_answer= ? WHERE user_id = ? AND security_answer = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,newQuestion);
            ps.setString(2,newAnswer);
            ps.setInt(3,userId);
            ps.setString(4,oldAnswer);
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public Security selectSecurity(int userId){
        Security security = null;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_security where user_id =  ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                security = new Security();
                security.setId(rs.getInt(1));
                security.setSecurityQuestion(rs.getString(2));
                security.setSecurityAnswer(rs.getString(3));
                security.setUserId(rs.getInt(4));
            }
            rs.close();
            ps.close();
            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return security;
    }

    public Security selectSecurityByUserName(String username){
        Security security = null;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_security s,t_user u where s.user_id = u.id and u.user_name = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                security = new Security();
                security.setId(rs.getInt(1));
                security.setSecurityQuestion(rs.getString(2));
                security.setSecurityAnswer(rs.getString(3));
                security.setUserId(rs.getInt(4));
            }
            rs.close();
            ps.close();
            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return security;
    }


    public ComboPooledDataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(ComboPooledDataSource dataSource) {
        this.dataSource = dataSource;
    }
}
