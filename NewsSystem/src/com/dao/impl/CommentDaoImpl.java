package com.dao.impl;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.bean.Comment;
import com.dao.CommentDao;
import com.sun.corba.se.spi.protocol.CorbaMessageMediator;
import com.utils.SimpleJDBCUtil;


public class CommentDaoImpl implements CommentDao{

	@Override
	public boolean deleteComment(int id) {
		String sql = "delete from t_comment where id = ?";
		int n = 0;
		try {
			n = SimpleJDBCUtil.executUpdate(sql,new Object[]{id});
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(n>0)
			return true;
		else
			return false;
	}

	@Override
	public boolean insertComment(Comment comment) {
		String sql = "insert into t_comment (userid,newsid,content,date,visible,username,icon) values (?,?,?,?,?,?,?)";
		int n = 0;
		try {
			n = SimpleJDBCUtil.executUpdate(sql,new Object[]{comment.getUserid(),comment.getNewsid(),comment.getContent(),
            new Date(),false,comment.getUsername(),comment.getIcon()});
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(n>0)
			return true;
		else
			return false;
	}

	@Override
	public List<Comment> selectAllComment(int offset,int rows) {
		String sql = "select * from t_comment limit ?,?";
		ResultSet rs = null;
		List<Comment> list = new ArrayList<Comment>();
		try {
			rs = SimpleJDBCUtil.executQuery(sql,new Object[]{offset,rows});
			while(rs.next()){
				Comment comment = new Comment();
				comment.setId(rs.getInt(1));
				comment.setUserid(rs.getInt(2));
				comment.setNewsid(rs.getInt(3));
				comment.setContent(rs.getString(4));
				comment.setDate(rs.getDate(5));
				comment.setVisible(rs.getBoolean(6));
				comment.setUsername(rs.getString(7));
				comment.setIcon(rs.getString(8));
				list.add(comment);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Comment> selectCommentAndNews(int newsid) {
		String sql = "select * from t_comment where newsid=? and visible = 1";
		List<Comment> list = new ArrayList<Comment>();
		try {
			ResultSet resultSet = SimpleJDBCUtil.executQuery(sql, new Object[]{newsid});
			while(resultSet.next()){
				Comment comment = new Comment();
				comment.setId(resultSet.getInt(1));
				comment.setUserid(resultSet.getInt(2));
				comment.setNewsid(resultSet.getInt(3));
				comment.setContent(resultSet.getString(4));
				comment.setDate(resultSet.getDate(5));
				comment.setVisible(resultSet.getBoolean(6));
				comment.setUsername(resultSet.getString(7));
				comment.setIcon(resultSet.getString(8));
				list.add(comment);
			}
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int selectCommentSum() {
		String sql = "select count(*) from t_Comment";
		ResultSet rs = null;
		int count  = 0;
		try {
			rs = SimpleJDBCUtil.executQuery(sql, new Object[]{});
			if (rs.next())
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public void commentPass(int id) {
		String sql = "update t_comment set visible=? where id = ?";
		try {
			SimpleJDBCUtil.executUpdate(sql,new Object[]{true,id});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void commentNoPass(int id) {
		String sql = "update t_comment set visible=? where id = ?";
		try {
			SimpleJDBCUtil.executUpdate(sql,new Object[]{false,id});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
