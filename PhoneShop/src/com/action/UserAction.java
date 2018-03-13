package com.action;

import com.bean.PageBean;
import com.bean.User;
import com.opensymphony.xwork2.ActionContext;
import com.service.UserService;
import com.utils.UploadUtil;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Map;


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

    public String register(){
        userService.register(username,password,email);
        return "registerSuccess";
    }
    public String login(){
        User user = userService.login(username,password);
        if(user != null){
            Map session = ActionContext.getContext().getSession();
            session.put("user",user);
            return "loginSuccess";
        } else
            return "loginFailed";
    }
    public String logout(){
        Map session = ActionContext.getContext().getSession();
        session.put("user",null);
        return "logoutSuccess";
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

    public void setIcon(File icon) {
        this.icon = icon;
    }

    public String getIconFileName() {
        return iconFileName;
    }

    public void setIconFileName(String iconFileName) {
        this.iconFileName = iconFileName;
    }

    public File getIcon() {
        return icon;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

}
