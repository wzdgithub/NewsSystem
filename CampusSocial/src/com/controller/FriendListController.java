package com.controller;

import com.bean.Friend;
import com.bean.FriendGroup;
import com.bean.FriendList;
import com.bean.User;
import com.service.FriendGroupService;
import com.service.FriendService;
import org.omg.PortableInterceptor.USER_EXCEPTION;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZhenDong on 2017/3/27.
 */
@Controller
public class FriendListController {
    @Resource(name ="friendGroupService")
    private FriendGroupService friendGroupService;
    @Resource(name = "friendService")
    private FriendService friendService;

    @RequestMapping(value = "/selectFriendList",method = RequestMethod.POST)
    public @ResponseBody
    FriendList selectFriendList(@RequestParam int userId,HttpSession session){
        FriendList fl = new FriendList();
        List<FriendGroup> friendGroups = friendGroupService.selectFriendGroup(userId);
        fl.setFriendGroups(friendGroups);
        session.setAttribute("friendGroups",friendGroups);
        List<Friend> friends = friendService.selectFriend(userId);
        fl.setFriends(friends);

        return fl;
    }

    @RequestMapping(value = "/selectFriendByName",method = RequestMethod.POST)
    public String selectFriendByName(@RequestParam String userName, @RequestParam int pageNum,
                                     @RequestParam int userId,HttpSession session){
        List<User> users = friendService.selectName(userName,pageNum,userId);
        session.setAttribute("users",users);
        session.setAttribute("userName",userName);
        return "redirect:/module/friends/friends.jsp";
    }

    @RequestMapping(value = "/ajaxSearchName",method = RequestMethod.POST)
    public @ResponseBody
    List<User> ajaxSearchName(@RequestParam String userName, @RequestParam int pageNum,@RequestParam int userId){
        return friendService.selectName(userName,pageNum,userId);
    }
    @RequestMapping(value = "/deleteFriend",method = RequestMethod.GET)
    public String deleteFriend(int userId,int friendId){
        friendService.deleteFriend(userId,friendId);
        friendService.deleteFriend(friendId,userId);
        return "redirect:/module/home/index.jsp";
    }

    public FriendGroupService getFriendGroupService() {
        return friendGroupService;
    }

    public void setFriendGroupService(FriendGroupService friendGroupService) {
        this.friendGroupService = friendGroupService;
    }

    public FriendService getFriendService() {
        return friendService;
    }

    public void setFriendService(FriendService friendService) {
        this.friendService = friendService;
    }
}
