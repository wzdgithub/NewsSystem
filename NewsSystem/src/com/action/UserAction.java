package com.action;

import com.bean.PageBean;
import com.bean.Score;
import com.bean.User;
import com.dao.ScoreDao;
import com.dao.UserDao;
import com.dao.impl.ScoreDaoImpl;
import com.dao.impl.UserDaoImpl;
import com.opensymphony.xwork2.ActionContext;
import com.utils.UploadUtil;
import com.utils.UserService;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/4/11.
 */
public class UserAction {
    private int id;
    private String username;
    private String password;
    private String email;
    private String name;
    private String sex;
    private String telephone;
    private File icon;
    private String iconFileName;
    private int currentPage = 1;
    private UserService userService = new UserService();

    private UserDao userDao = new UserDaoImpl();
    private ScoreDao scoreDao = new ScoreDaoImpl();

    public String loginUser(){
        User user = userDao.login(username,password);
        if (user == null)
            return "loginUserFailure";
        else {
            Map session = ServletActionContext.getContext().getSession();
            session.put("user", user);
            List<Score> scores = scoreDao.selectScore(user.getId());
            session.put("scores", scores);
            return "loginUserSuccess";
        }
    }
    public String loginOutUser(){
        Map session = ServletActionContext.getContext().getSession();
        session.put("user",null);
        return "loginUserSuccess";
    }

    public String register(){
        if(!userDao.selectUserByName(username)){
            return "registerFilure";
        }else {
            userService.register(username, password, email);
            return "registerSuccess";
        }
    }

    public String updateUserDetails(){
        userService.updateUserDetails(id,name,sex,telephone,email);
        User user = userService.selectUserById(id);
        Map session = ActionContext.getContext().getSession();
        session.put("user",user);
        return "updateUserDetailsSuccess";
    }
    public String updateUserIcon(){
        UploadUtil.upload(icon, iconFileName);
        userService.updateUserIcon("images//"+iconFileName,id);
        User user = userService.selectUserById(id);
        Map session = ActionContext.getContext().getSession();
        session.put("user",user);
        return "updateUserDetailsSuccess";
    }
    public String selectUser(){
        PageBean userPage = userService.selectUser(20, currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("userPage",userPage);
        return "selectUserSuccess";
    }
    public String deleteUser(){
        System.out.println(id);
        userService.deleteUser(id);
        return "deleteUserSuccess";
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public File getIcon() {
        return icon;
    }

    public void setIcon(File icon) {
        this.icon = icon;
    }

    public String getIconFileName() {
        return iconFileName;
    }

    public void setIconFileName(String iconFileName) {
        this.iconFileName = iconFileName;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
}
