package com.dao.impl;

import com.bean.User;
import com.dao.UserDao;
import com.utils.SimpleJDBCUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class UserDaoImpl implements UserDao {
    @Override
    public User login(String username, String password) {
        String sql = "select * from t_user where username=? and password=?";
        ResultSet rs = null;
        User user = new User();
        try {
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{username,password});
            if(rs.next()){
                user.setId(rs.getInt(1));
                user.setUsername(rs.getString(2));
                user.setEmail(rs.getString(4));
                user.setName(rs.getString(5));
                user.setSex(rs.getString(6));
                user.setTelephone(rs.getString(7));
                user.setIcon(rs.getString(8));
            }else{
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public boolean register(String username, String password, String email) {
        String sql = "insert into t_user (username,password,email) values (?,?,?)";
        int n = 0;
        try {
            n = SimpleJDBCUtil.executUpdate(sql,new Object[]{username,password,email});
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(n>0)
            return true;
        else
            return false;
    }

    @Override
    public List<User> selectUser(int start,int end) {
        String sql = "select * from t_user limit ?,?";
        ResultSet rs = null;
        List<User> users = new ArrayList<User>();
        try {
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{start,end});
            while(rs.next()){
                User user = new User();
                user.setId(rs.getInt(1));
                user.setUsername(rs.getString(2));
                user.setEmail(rs.getString(4));
                user.setName(rs.getString(5));
                user.setSex(rs.getString(6));
                user.setTelephone(rs.getString(7));
                user.setIcon(rs.getString(8));
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public User selectUserById(int id) {
        String sql = "select * from t_user where id=? ";
        ResultSet rs = null;
        User user = new User();
        try {
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{id});
            if(rs.next()){
                user.setId(rs.getInt(1));
                user.setUsername(rs.getString(2));
                user.setEmail(rs.getString(4));
                user.setName(rs.getString(5));
                user.setSex(rs.getString(6));
                user.setTelephone(rs.getString(7));
                user.setIcon(rs.getString(8));
            }else{
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public boolean deleteUser(int id) {
        String sql = "delete from t_user where id = ?";
        int n = 0;
        try {
            n = SimpleJDBCUtil.executUpdate(sql,new Object[]{id});
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(n>0)
            return true;
        else
            return false;
    }

    @Override
    public boolean updateUserDetails(int id, String name, String sex, String telephone,String email) {
        String sql = "update t_user set name=?,sex=?,telephone=?,email=? where id=?";
        int n = 0;
        try {
            n = SimpleJDBCUtil.executUpdate(sql,new Object[]{name,sex,telephone,email,id});
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(n>0)
            return true;
        else
            return false;
    }

    @Override
    public boolean updateUserIcon(String icon,int id) {
        String sql = "update t_user set icon=? where id=?";
        int n = 0;
        try {
            n = SimpleJDBCUtil.executUpdate(sql,new Object[]{icon,id});
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(n>0)
            return true;
        else
            return false;
    }

    @Override
    public int selectUserSum() {
        ResultSet rs = null;
        int count  = 0;
        try{
            String sql = "select count(*) from t_user";
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{});
            if (rs.next())
                count = rs.getInt(1);
        }catch (Exception e){}
        return count;
    }
}
