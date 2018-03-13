package com.service;

import com.bean.Comment;
import com.bean.PageBean;
import com.dao.CommentDao;
import com.dao.impl.CommentDaoImpl;

import java.util.Date;
import java.util.List;


public class CommentService {
    private CommentDao commentDao = new CommentDaoImpl();
    public PageBean selectComment(int phoneid,int num,int currentPage){
        PageBean pageBean = new PageBean();
        List<Comment> comments = null;
        try {
            int allRow = commentDao.selectCommentSum(phoneid);
            comments = commentDao.selectComment(phoneid, (currentPage - 1) * num, num);
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
        return pageBean;
    }
    public void insertComment(int userid, int phoneid, String username, String icon, String content, Date date) {
        commentDao.insertComment(userid,phoneid,username,icon,content,date);
    }
    public void deleteComment(int id, int userid) {
        commentDao.deleteComment(id,userid);
    }
}
