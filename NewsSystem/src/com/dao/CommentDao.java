package com.dao;

import java.util.List;

import com.bean.Comment;


public interface CommentDao {
	boolean insertComment(Comment comment); 
	boolean deleteComment(int id);
	List<Comment> selectAllComment(int offset,int rows);
	List<Comment> selectCommentAndNews(int newsid);
	int selectCommentSum();
	void commentPass(int id);
	void commentNoPass(int id);
}
