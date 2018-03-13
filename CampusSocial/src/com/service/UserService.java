package com.service;


import com.bean.User;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZhenDong on 2017/3/21.
 */
@Service
public class UserService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertUser(User user){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_user(user_name,password,email,telephone) values (?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,user.getUsername());
            ps.setString(2,user.getPassword());
            ps.setString(3,user.getEmail());
            ps.setString(4,user.getTelephone());
            n = ps.executeUpdate();

            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public User selectUser(String username,String password){
        User user = null;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_user where user_name = ? and password = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,username);
            ps.setString(2,password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()){
                user = new User();

                user.setId(rs.getInt(1));
                user.setUsername(rs.getString(2));
                user.setPassword(rs.getString(3));
                user.setName(rs.getString(4));
                user.setSex(rs.getString(5));
                user.setTelephone(rs.getString(6));
                user.setEmail(rs.getString(7));
                user.setIcon(rs.getString(8));
                user.setAge(rs.getInt(9));
                user.setAddress(rs.getString(10));
                user.setAutograph(rs.getString(11));
            }

            rs.close();
            ps.close();
            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean verifyUser(String username){
        User user = null;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_user where user_name = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()){
                rs.close();
                ps.close();
                connection.close();
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int uploadUserIcon(int id,String icon){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "update t_user set icon=? WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,icon);
            ps.setInt(2,id);
            n = ps.executeUpdate();

            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public int updateUserInfo(User user){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "update t_user set u_name= ?,sex= ?,telephone=?,email=?,age=?,address=?,autograph=? WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,user.getName());
            ps.setString(2,user.getSex());
            ps.setString(3,user.getTelephone());
            ps.setString(4,user.getEmail());
            ps.setInt(5,user.getAge());
            ps.setString(6,user.getAddress());
            ps.setString(7,user.getAutograph());
            ps.setInt(8,user.getId());
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public int updateUserPassword(int id,String password){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "update t_user set password=? WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,password);
            ps.setInt(2,id);
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
    public int updateNewPassword(String oldPassword,String newPassword,int userId){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "update t_user set password= ? WHERE password = ? AND id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,newPassword);
            ps.setString(2,oldPassword);
            ps.setInt(3,userId);
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
    public User selectUserById(int id){
        User user = null;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_user where id =  ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()){
                user = new User();
                user.setId(rs.getInt(1));
                user.setUsername(rs.getString(2));
                user.setPassword(rs.getString(3));
                user.setName(rs.getString(4));
                user.setSex(rs.getString(5));
                user.setTelephone(rs.getString(6));
                user.setEmail(rs.getString(7));
                user.setIcon(rs.getString(8));
                user.setAge(rs.getInt(9));
                user.setAddress(rs.getString(10));
                user.setAutograph(rs.getString(11));
            }

            rs.close();
            ps.close();
            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public List<User> selectAllUser(int page,int num){
        List<User> users = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_user limit "+page+","+num;
            Statement stmt  = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()){
                User user = new User();
                user.setId(rs.getInt(1));
                user.setUsername(rs.getString(2));
                user.setPassword(rs.getString(3));
                user.setName(rs.getString(4));
                user.setSex(rs.getString(5));
                user.setTelephone(rs.getString(6));
                user.setEmail(rs.getString(7));
                user.setIcon(rs.getString(8));
                user.setAge(rs.getInt(9));
                user.setAddress(rs.getString(10));
                user.setAutograph(rs.getString(11));

                users.add(user);
            }

            rs.close();
            stmt.close();
            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public int deleteuser(int id){
        String sql = "delete from t_user where id = ?";
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
        }
        return n;
    }

    public ComboPooledDataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(ComboPooledDataSource dataSource) {
        this.dataSource = dataSource;
    }
}
