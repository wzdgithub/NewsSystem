package com.controller;

import com.bean.LeaveMessage;
import com.service.LeaveMessageService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by ZhenDong on 2017/5/1.
 */
@Controller
public class LeaveMessageController {
    @Resource(name = "leaveMessageService")
    private LeaveMessageService leaveMessageService;

    @RequestMapping(value = "/insertLeaveMessage",method = RequestMethod.POST)
    public String insertLeaveMessage(LeaveMessage leaveMessage){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            leaveMessage.setDate(sdf.format(new Date()));
            leaveMessageService.insertLeaveMessage(leaveMessage);
            return "redirect:/module/home/index.jsp";
    }

    @RequestMapping(value = "/selectLeaveMessage",method = RequestMethod.GET)
     public String selectLeaveMessage(@RequestParam int userId,HttpSession session){
        List<LeaveMessage> leaveMessages = leaveMessageService.selectLeaveMessage(userId);
        session.setAttribute("leaveMessages",leaveMessages);
        return "redirect:/module/message/LeaveMessage.jsp";
    }

    @RequestMapping(value = "/deleteLeaveMessage",method = RequestMethod.GET)
    public String deleteLeaveMessage(@RequestParam int id,@RequestParam int userId,HttpSession session){
        leaveMessageService.deleteLeaveMessage(id);
        List<LeaveMessage> leaveMessages = leaveMessageService.selectLeaveMessage(userId);
        session.setAttribute("leaveMessages",leaveMessages);
        return "redirect:/module/message/LeaveMessage.jsp";
    }

    public LeaveMessageService getLeaveMessageService() {
        return leaveMessageService;
    }

    public void setLeaveMessageService(LeaveMessageService leaveMessageService) {
        this.leaveMessageService = leaveMessageService;
    }
}
