package com.action;

import com.bean.Comment;
import com.bean.PageBean;
import com.dao.CommentDao;
import com.dao.impl.CommentDaoImpl;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * Created by admin on 2016/4/11.
 */
public class CommentAction {
    private int id;
    private int userid;
    private int newsid;
    private String content;
    private Date date;
    private boolean visible;
    private String username;
    private String icon;

    private int currentPage = 1;
    private CommentDao commentDao = new CommentDaoImpl();

    public String insertComment(){
        Comment comment = new Comment();
        comment.setUserid(userid);
        comment.setNewsid(newsid);
        comment.setContent(content);
        comment.setUsername(username);
        comment.setIcon(icon);
        commentDao.insertComment(comment);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("id",newsid);
        return "insertCommentSuccess";
    }
    public String allCommentByAdmin(){
        PageBean pageBean = new PageBean();
        List<Comment> comments = null;
        int num = 10;
        try {
            int allRow = commentDao.selectCommentSum();
            comments = commentDao.selectAllComment((currentPage - 1) * num, num);
            pageBean.setPageList(comments);
            pageBean.setCurrentPage(currentPage);
            if(allRow%num == 0) {
                pageBean.setTotalPage(allRow / num);
            }else {
                pageBean.setTotalPage(allRow / num + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("commentPageBean",pageBean);
        return "allCommentByAdminSuccess";
    }
    public String deleteComment(){
        commentDao.deleteComment(id);
        return "deleteCommentSuccess";
    }
    public String commentPass(){
        commentDao.commentPass(id);
        return "commentPassSuccess";
    }
    public String commentNoPass(){
        commentDao.commentNoPass(id);
        return "commentNoPassSuccess";
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
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public Date getDate() {
        return date;
    }
    public void setDate(Date date) {
        this.date = date;
    }
    public boolean isVisible() {
        return visible;
    }
    public void setVisible(boolean visible) {
        this.visible = visible;
    }
    public int getNewsid() {
        return newsid;
    }
    public void setNewsid(int newsid) {
        this.newsid = newsid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }
}
