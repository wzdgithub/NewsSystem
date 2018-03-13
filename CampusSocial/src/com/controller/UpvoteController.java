package com.controller;

import com.service.UpvoteService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by ZhenDong on 2017/4/28.
 */
@Controller
public class UpvoteController {

    @Resource(name = "upvoteService")
    private UpvoteService upvoteService;

    @RequestMapping(value = "/isUpvote",method = RequestMethod.POST)
    public @ResponseBody
    int isUpvote(@RequestParam int postId,@RequestParam int userId){
        return upvoteService.isUpvote(postId,userId);
    }
    @RequestMapping(value = "/plusUpvote",method = RequestMethod.GET)
    public @ResponseBody
    int plusUpvote(@RequestParam int postId,@RequestParam int userId){
        return upvoteService.plusUpvote(postId,userId);
    }

    @RequestMapping(value = "/minusUpvote",method = RequestMethod.GET)
    public @ResponseBody
    int minusUpvote(@RequestParam int postId,@RequestParam int userId){
        return upvoteService.minusUpvote(postId,userId);
    }

    public UpvoteService getUpvoteService() {
        return upvoteService;
    }

    public void setUpvoteService(UpvoteService upvoteService) {
        this.upvoteService = upvoteService;
    }
}
