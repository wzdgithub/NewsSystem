package com.controller;

import com.bean.Friend;
import com.bean.Message;
import com.service.FriendService;
import com.service.MessageService;
import com.sun.org.apache.bcel.internal.generic.NEW;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ZhenDong on 2017/4/29.
 */
@Controller
public class MessageController {

    @Resource(name = "messageService")
    private MessageService messageService;
    @Resource(name = "friendService")
    private FriendService friendService;

    @RequestMapping(value = "/insertMessage",method = RequestMethod.POST)
    public @ResponseBody
    int insertMessage(Message message,@RequestParam String userName){
        message.setContent(userName + ":请求加为好友");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        message.setDate(sdf.format(new Date()));
        message.setCategory("好友请求");
        message.setType("未读");
        return messageService.insertMessage(message);

    }

    @RequestMapping(value = "/readMessage",method = RequestMethod.POST)
    public @ResponseBody
    List<Message> readMessage(int userId, String category, String type){
       return messageService.selectMessage(userId,category,type);
    }
    @RequestMapping(value = "/messageList",method = RequestMethod.GET)
    public String messageList(@RequestParam int userId, @RequestParam String category, HttpSession session){
        List<Message> messages = messageService.selectMessage(userId,category,null);
        session.setAttribute("messages",messages);
        return "redirect:/module/message/message.jsp";
    }

    @RequestMapping(value = "/agreeAddFriend",method = RequestMethod.GET)
    public String agreeAddFriend(@RequestParam int rootId,int sourceId,int fgId1,int fgId2,HttpSession session){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = simpleDateFormat.format(new Date());
        if(!friendService.selectIsFriend(rootId,sourceId)) {
            if (friendService.insertFriend(sourceId, rootId, fgId1, date) > 0 && friendService.insertFriend(rootId, sourceId, fgId2, date) > 0) {
                if (messageService.updateMessageType(rootId, sourceId, "已读") > 0) {
                    List<Message> messages = messageService.selectMessage(rootId, "好友请求", null);
                    session.setAttribute("messages", messages);
                }
            }
        }else{
            if (messageService.updateMessageType(rootId, sourceId, "已读") > 0) {
                List<Message> messages = messageService.selectMessage(rootId, "好友请求", null);
                session.setAttribute("messages", messages);
            }
        }
        return "redirect:/module/message/message.jsp";
    }

    public MessageService getMessageService() {
        return messageService;
    }

    public void setMessageService(MessageService messageService) {
        this.messageService = messageService;
    }

    public FriendService getFriendService() {
        return friendService;
    }

    public void setFriendService(FriendService friendService) {
        this.friendService = friendService;
    }
}
