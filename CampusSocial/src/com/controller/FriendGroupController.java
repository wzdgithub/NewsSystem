package com.controller;

import com.service.FriendGroupService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by ZhenDong on 2017/3/31.
 */
@Controller
public class FriendGroupController {
    @Resource(name = "friendGroupService")
    private FriendGroupService friendGroupService;

    @RequestMapping(value = "/addFriendGroup",method = RequestMethod.POST)
    public String addFriendGroup(@RequestParam String groupName,
                               @RequestParam int userId){
        int n = friendGroupService.addFriendGroup(groupName,userId);
        if (n>0)
            return "redirect:/module/home/index.jsp";
        else
            return "redirect:/module/failure/index.jsp";
    }

    @RequestMapping(value = "/deleteFriendGroup",method = RequestMethod.POST)
    public @ResponseBody
    String deleteFriendGroup(@RequestParam int friendGroupId){
        return friendGroupService.deleteFriendGroup(friendGroupId);
    }

    public FriendGroupService getFriendGroupService() {
        return friendGroupService;
    }

    public void setFriendGroupService(FriendGroupService friendGroupService) {
        this.friendGroupService = friendGroupService;
    }
}
