package com.dao;

import com.bean.Comment;

import java.util.Date;
import java.util.List;


public interface CommentDao {
    List<Comment> selectComment(int phoneid,int start,int end);
    void deleteComment(int id,int userid);
    void insertComment(int userid,int phoneid,String username,String icon,String content,Date date);
    int selectCommentSum(int phoneid);
}
