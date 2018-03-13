package com.action;

import com.bean.PageBean;
import com.service.CommentService;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;


public class CommentAction {
    private int id;
    private int userid;
    private int phoneid;
    private String username;
    private String icon;
    private String content;
    private int currentPage = 1;
    private CommentService commentService = new CommentService();

    public String selectComment(){
        PageBean commentPage = commentService.selectComment(-1, 20, currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("commentPage",commentPage);
        return "selectCommentSuccess";
    }

    public void insertComment(){
        commentService.insertComment(userid,phoneid,username,icon,content,new Date());
        HttpServletResponse response = ServletActionContext.getResponse();
        try {
            response.sendRedirect("phone_selectPhoneById?id="+phoneid);
        }catch (Exception e){}
    }
    public void deleteComment(){
        commentService.deleteComment(id,userid);
        HttpServletResponse response = ServletActionContext.getResponse();
        try {
            if (userid != -1)
                response.sendRedirect("phone_selectPhoneById?id="+phoneid);
            else
                response.sendRedirect("comment_selectComment");
        }catch (Exception e){}
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getPhoneid() {
        return phoneid;
    }

    public void setPhoneid(int phoneid) {
        this.phoneid = phoneid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
}
