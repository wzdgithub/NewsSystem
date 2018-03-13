package com.service;

import com.bean.PageBean;
import com.bean.User;
import com.dao.UserDao;
import com.dao.impl.UserDaoImpl;

import java.util.List;


public class UserService {
    private UserDao userDao = new UserDaoImpl();

    public boolean register(String username, String password, String email) {
        return  userDao.register(username,password,email);
    }
    public User login(String username, String password) {
        return userDao.login(username,password);
    }
    public void updateUserDetails(int id, String name, String sex, String telephone,String email){
        userDao.updateUserDetails(id,name,sex,telephone,email);
    }
    public User selectUserById(int id) {
        return userDao.selectUserById(id);
    }
    public boolean updateUserIcon(String icon,int id) {
        return userDao.updateUserIcon(icon,id);
    }
    public PageBean selectUser(int num,int currentPage){
        PageBean pageBean = new PageBean();
        List<User> users = null;
        try {
            int allRow = userDao.selectUserSum();
            users = userDao.selectUser((currentPage - 1) * num, num);
            pageBean.setPageList(users);
            pageBean.setCurrentPage(currentPage);
            if(allRow%num == 0) {
                pageBean.setTotalPage(allRow / num);
            }else {
                pageBean.setTotalPage(allRow / num + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pageBean;
    }
    public void deleteUser(int id){
        userDao.deleteUser(id);
    }
}
