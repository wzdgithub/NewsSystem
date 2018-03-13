package com.controller;

import com.bean.Comment;
import com.bean.Post;
import com.service.CommentService;
import com.service.PostService;
import javafx.geometry.Pos;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ZhenDong on 2017/4/23.
 */
@Controller
public class PostController {
    @Resource(name = "postService")
    private PostService postService;

    @Resource(name = "commentService")
    private CommentService commentService;

    @RequestMapping("/addPost")
    public String addPost(@RequestParam int userId,@RequestParam String content,@RequestParam String category,@RequestParam MultipartFile[] pics,
                        HttpServletRequest request){
        Post post = new Post();
        String picsPath = "";
        for (MultipartFile pic : pics) {
//            System.out.println("文件长度: " + pic.getSize());
//            System.out.println("文件类型: " + pic.getContentType());
//            System.out.println("文件名称: " + pic.getName());
//            System.out.println("文件原名: " + pic.getOriginalFilename());
//            System.out.println("========================================");
            // 如果用的是Tomcat服务器，则文件会上传到\\%TOMCAT_HOME%\\webapps\\YourWebProject\\WEB-INF\\upload\\文件夹中
            // 这里不必处理IO流关闭的问题，因为FileUtils.copyInputStreamToFile()方法内部会自动把用到的IO流关掉，我是看它的源码才知道的

            String realPath = request.getSession().getServletContext()
                    .getRealPath("/upload");
            picsPath += "<img style='max-width: 50%;max-height: 200px;min-width: 25%; min-height: 200px;' " +
                    "src='http://localhost:8080/upload/"+pic.getOriginalFilename()+"'/>";
            try {
                FileUtils.copyInputStreamToFile(pic.getInputStream(), new File(
                        realPath, pic.getOriginalFilename()));
            } catch (IOException e) {
                picsPath="";
            }

        }
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        post.setUserId(userId);
        post.setContent(content);
        post.setDate(formatter.format(new Date()));
        post.setDisplay("display");
        post.setPicsPath(picsPath);
        post.setCategory(category);
        post.setUpvote(0);
        postService.insertPost(post);

        return "redirect:/module/home/index.jsp";
    }

    @RequestMapping(value = "/showPost",method = RequestMethod.POST)
    public @ResponseBody
    List<Post> showPost(@RequestParam String ids,@RequestParam int postNum){
        List<Post> posts = postService.selectPost(ids,postNum,"no");
        return posts;
    }
    @RequestMapping(value = "/selectAllPost",method = RequestMethod.POST)
    public @ResponseBody
    List<Post> selectAllPost(@RequestParam int page){
        List<Post> posts = postService.selectAllPost(page,15);
        return posts;
    }

    @RequestMapping(value = "/deletePost",method = RequestMethod.GET)
    public String deletePost(@RequestParam int postId){
        int n = postService.deletePost(postId);
        commentService.deleteAllPostComment(postId);
        return "redirect:/module/home/index.jsp";
    }
    @RequestMapping(value = "/deletePostAdmin",method = RequestMethod.POST)
    public @ResponseBody
    List<Post> deletePostAdmin(@RequestParam int id,@RequestParam int page){
        postService.deletePost(id);
        commentService.deleteAllPostComment(id);
        return postService.selectAllPost(page,15);
    }


    public PostService getPostService() {
        return postService;
    }

    public void setPostService(PostService postService) {
        this.postService = postService;
    }

    public CommentService getCommentService() {
        return commentService;
    }

    public void setCommentService(CommentService commentService) {
        this.commentService = commentService;
    }
}
