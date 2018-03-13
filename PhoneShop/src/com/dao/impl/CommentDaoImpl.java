package com.dao.impl;

import com.bean.Comment;
import com.dao.CommentDao;
import com.utils.SimpleJDBCUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class CommentDaoImpl implements CommentDao {
    @Override
    public List<Comment> selectComment(int phoneid,int start,int end) {
        String sql = "";
        ResultSet rs = null;
        List<Comment> comments = new ArrayList<Comment>();
        try {
            if (phoneid != -1) {
                sql = "select * from t_comment where phoneid = ? order by date desc limit ?,?";
                rs = SimpleJDBCUtil.executQuery(sql,new Object[]{phoneid, start, end});
            }else{
                sql = "select * from t_comment order by date desc limit ?,?";
                rs = SimpleJDBCUtil.executQuery(sql,new Object[]{ start, end});
            }
            while(rs.next()){
                Comment comment = new Comment();
                comment.setId(rs.getInt(1));
                comment.setUserid(rs.getInt(2));
                comment.setPhoneid(rs.getInt(3));
                comment.setUsername(rs.getString(4));
                comment.setIcon(rs.getString(5));
                comment.setContent(rs.getString(6));
                comment.setDate(rs.getDate(7));
                comments.add(comment);
            }
        }catch (Exception e){}
        return comments;
    }

    @Override
    public void deleteComment(int id, int userid) {
        String sql = "";
        try {
            if (userid != -1) {
                sql = "delete from t_comment where id = ? and userid = ?";
                SimpleJDBCUtil.executUpdate(sql,new Object[]{id,userid});
            }else{
                sql = "delete from t_comment where id = ?";
                SimpleJDBCUtil.executUpdate(sql, new Object[]{id});
            }
        }catch (Exception e){}
    }

    @Override
    public void insertComment(int userid, int phoneid, String username, String icon, String content, Date date) {
        String sql = "insert into t_comment (userid,phoneid,username,icon,content,date) values (?,?,?,?,?,?)";
        try{
            SimpleJDBCUtil.executUpdate(sql,new Object[]{userid,phoneid,username,icon,content,date});
        }catch (Exception e){}
    }

    @Override
    public int selectCommentSum(int phoneid) {
        String sql = "";
        ResultSet rs = null;
        int count = 0;
        try {
            if (phoneid != -1) {
                sql = "select count(*) from t_comment where phoneid = ?";
                rs = SimpleJDBCUtil.executQuery(sql, new Object[]{phoneid});
            }else{
                sql = "select count(*) from t_comment";
                rs = SimpleJDBCUtil.executQuery(sql, new Object[]{});
            }
            if (rs.next())
                count = rs.getInt(1);
        }catch (Exception e){}
        return count;
    }
}
