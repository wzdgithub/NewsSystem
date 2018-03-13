package com.service;

import com.bean.Comment;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZhenDong on 2017/4/24.
 */
@Service
public class CommentService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertComment(Comment comment){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_comment(post_id,user_id,content,c_date) values (?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,comment.getPostId());
            ps.setInt(2,comment.getUserId());
            ps.setString(3,comment.getContent());
            ps.setString(4,comment.getDate());
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public List<Comment> selectComment(int postId){
        List<Comment> comments = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_comment where post_id = ? ORDER BY c_date DESC ";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,postId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Comment comment = new Comment();
                comment.setId(rs.getInt(1));
                comment.setPostId(rs.getInt(2));
                comment.setUserId(rs.getInt(3));
                comment.setContent(rs.getString(4));
                comment.setDate(rs.getString(5));

                comments.add(comment);
            }

            rs.close();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

    public int deleteComment(int id){
        String sql = "delete from t_comment where id = ?";
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
        }
        return n;
    }
    public int deleteAllPostComment(int postId){
        String sql = "delete from t_comment where post_id = ?";
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, postId);
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
        }
        return n;
    }
    public ComboPooledDataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(ComboPooledDataSource dataSource) {
        this.dataSource = dataSource;
    }
}
