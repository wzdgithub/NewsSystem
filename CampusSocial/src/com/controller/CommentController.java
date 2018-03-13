package com.controller;

import com.bean.Comment;
import com.service.CommentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by ZhenDong on 2017/4/24.
 */
@Controller
public class CommentController {
    @Resource(name = "commentService")
    private CommentService commentService;

    @RequestMapping(value = "/addComemnt",method = RequestMethod.POST)
    public void addComemnt(Comment comment){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        comment.setDate(formatter.format(new Date()));
        int n = commentService.insertComment(comment);
    }

    @RequestMapping(value = "/selectComments",method = RequestMethod.POST)
    public @ResponseBody
    List<Comment> selectComments(@RequestParam int postId){
        List<Comment> comments = commentService.selectComment(postId);
        return comments;
    }

    @RequestMapping(value = "/deleteCommemt",method = RequestMethod.GET)
    public String deleteCommemt(@RequestParam int id){
        int n = commentService.deleteComment(id);
        return "redirect:/module/home/index.jsp";
    }

    public CommentService getCommentService() {
        return commentService;
    }

    public void setCommentService(CommentService commentService) {
        this.commentService = commentService;
    }
}
