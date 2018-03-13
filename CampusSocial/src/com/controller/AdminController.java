package com.controller;

import com.bean.Admin;
import com.service.AdminService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

/**
 * Created by ZhenDong on 2017/5/3.
 */
@Controller
public class AdminController {
    @Resource(name = "adminService")
    private AdminService adminService;

    @RequestMapping(value = "/adminLogin",method = RequestMethod.POST)
    public String adminLogin(@RequestParam String adminName, @RequestParam String password, HttpSession session){
        Admin admin = adminService.adminLogin(adminName,password);
        session.setAttribute("admin",admin);
        return "redirect:/module/admin/admin.jsp";
    }
    @RequestMapping(value = "/adminLogout",method = RequestMethod.GET)
    public String adminLogout(HttpSession session){
        session.setAttribute("admin",null);
        return "redirect:/module/admin/adminlogin.jsp";
    }

    public AdminService getAdminService() {
        return adminService;
    }

    public void setAdminService(AdminService adminService) {
        this.adminService = adminService;
    }
}
