package com.controller;

import com.bean.Security;
import com.service.SecurityService;
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
public class SecurityController {
    @Resource(name = "securityService")
    private SecurityService securityService;

    @RequestMapping(value = "/selectSecurityByUserName",method = RequestMethod.GET)
    public String selectSecurityByUserName(@RequestParam String username, HttpSession session){
        Security security = securityService.selectSecurityByUserName(username);
        session.setAttribute("security",security);
        return "redirect:/module/user/securityQuestion.jsp";
    }

    @RequestMapping(value = "/modifySecurity",method = RequestMethod.POST)
    public String modifySecurity(String oldAnswer,String newAnswer,String newQuestion,int userId,HttpSession session){
        int n = securityService.modifySecurity(oldAnswer,newAnswer,newQuestion,userId);
        if (n>0) {
            Security security = securityService.selectSecurity(userId);
            session.setAttribute("security",security);
            return "redirect:/module/user/information.jsp";
        }else
            return "redirect:/module/failure/index.jsp";
    }

    public SecurityService getSecurityService() {
        return securityService;
    }

    public void setSecurityService(SecurityService securityService) {
        this.securityService = securityService;
    }
}
