package com.controller;

import com.bean.Category;
import com.bean.Security;
import com.bean.User;
import com.service.CategoryService;
import com.service.SecurityService;
import com.service.UserService;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Created by ZhenDong on 2017/3/21.
 */
@Controller
public class UserController {
    @Resource(name = "userService")
    private UserService userService;
    @Resource(name = "categoryService")
    private CategoryService categoryService;
    @Resource(name = "securityService")
    private SecurityService securityService;

    private void againLogin(int id , HttpSession session){
        User user = userService.selectUserById(id);
        session.setAttribute("user",user);
    }

    @RequestMapping(value = "/verifyUser",method = RequestMethod.POST)
    public @ResponseBody
    int verifyUser(@RequestParam String username){
        if (userService.verifyUser(username))
            return 1;
        else
            return 0;
    }

    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public @ResponseBody
    int register(User user,@RequestParam String question,@RequestParam String answer){
        int m = 0;
        int n = userService.insertUser(user);
        User u = userService.selectUser(user.getUsername(),user.getPassword());
        if (n>0) {
            Security security = new Security();
            security.setUserId(u.getId());
            security.setSecurityQuestion(question);
            security.setSecurityAnswer(answer);
            m = securityService.insertSecurity(security);
        }
        return m;
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(@RequestParam("username") String username, @RequestParam("password") String password, HttpSession session){
        User user = userService.selectUser(username,password);
        session.setAttribute("user",user);
        if (user!=null) {
            List<Category> categories = categoryService.selectCategory();
            session.setAttribute("categories",categories);

            Security security = securityService.selectSecurity(user.getId());
            session.setAttribute("security",security);
            return "redirect:/module/home/index.jsp";
        }else
            return "redirect:/module/failure/index.jsp";
    }
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(HttpSession session){
        session.setAttribute("user",null);
        return "redirect:/module/user/login.jsp";
    }
    @RequestMapping(value = "/uploadUserIcon",method = RequestMethod.POST)
    public String uploadUserIcon(@RequestParam int id, @RequestParam MultipartFile icon, HttpServletRequest request,HttpSession session){
        String iconPath="";
        try {
            if (icon.getOriginalFilename() !=null&&icon.getOriginalFilename()!=""){
                iconPath = "/icon/user/"+icon.getOriginalFilename();

                String realPath = request.getSession().getServletContext()
                        .getRealPath("/icon/user");

                FileUtils.copyInputStreamToFile(icon.getInputStream(), new File(
                        realPath, icon.getOriginalFilename()));

            }else{
                iconPath ="/icon/user/pic-none.png";
            }
            userService.uploadUserIcon(id,iconPath);
            againLogin(id,session);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/module/user/information.jsp";
    }

    @RequestMapping(value = "/updateUserInfo",method = RequestMethod.POST)
    public String updateUserInfo(User user,HttpSession session) {
        userService.updateUserInfo(user);
        againLogin(user.getId(),session);
        return "redirect:/module/user/information.jsp";
    }

    @RequestMapping(value = "/updateNewPassword",method = RequestMethod.POST)
    public String updateNewPassword(String oldPassword,String newPassword,int userId){
        int n = userService.updateNewPassword(oldPassword,newPassword,userId);
        if (n>0) {
            return "redirect:/module/user/information.jsp";
        }else
            return "redirect:/module/failure/index.jsp";
    }

    @RequestMapping(value = "/selectAllUser",method = RequestMethod.POST)
    public @ResponseBody
    List<User> selectAllUser(@RequestParam int page){
        return userService.selectAllUser(page,15);
    }

    @RequestMapping(value = "/deleteUser",method = RequestMethod.POST)
    public @ResponseBody
    List<User> deleteUser(@RequestParam int id,int page){
        userService.deleteuser(id);
        return userService.selectAllUser(page,15);
    }
    @RequestMapping(value = "/updateUserPassword",method = RequestMethod.POST)
    public String updateUserPassword(@RequestParam int userId,@RequestParam String password){
        userService.updateUserPassword(userId,password);
        return "redirect:/module/user/login.jsp";
    }

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public CategoryService getCategoryService() {
        return categoryService;
    }

    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    public SecurityService getSecurityService() {
        return securityService;
    }

    public void setSecurityService(SecurityService securityService) {
        this.securityService = securityService;
    }
}
