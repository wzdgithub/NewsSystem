package com.service;

import com.bean.Post;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZhenDong on 2017/4/24.
 */
@Service
public class PostService {

    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertPost(Post post) {
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_post(user_id,content,p_date,display,pics_path,category,question,upvote) values (?,?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,post.getUserId());
            ps.setString(2,post.getContent());
            ps.setString(3,post.getDate());
            ps.setString(4,post.getDisplay());
            ps.setString(5,post.getPicsPath());
            ps.setString(6,post.getCategory());
            ps.setString(7,"no");
            ps.setInt(8,post.getUpvote());
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
    public List<Post> selectPost(String ids,int postNum,String q){
        List<Post> posts = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_post where user_id in("+ids+") AND display='display' AND question = '"+q+"' Order By p_date DESC limit "+postNum+",15";
            Statement stmt  = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                Post post = new Post();
                post.setId(rs.getInt(1));
                post.setUserId(rs.getInt(2));
                post.setContent(rs.getString(3));
                post.setDate(rs.getString(4));
                post.setDisplay(rs.getString(5));
                post.setPicsPath(rs.getString(6));
                post.setCategory(rs.getString(7));
                post.setUpvote(rs.getInt(9));
                post.setTitle(rs.getString(10));

                posts.add(post);
            }

            rs.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    public List<Post> selectAllPost(int page,int num){
        List<Post> posts = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_post limit "+page+","+num;
            Statement stmt  = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                Post post = new Post();
                post.setId(rs.getInt(1));
                post.setUserId(rs.getInt(2));
                post.setContent(rs.getString(3));
                post.setDate(rs.getString(4));
                post.setDisplay(rs.getString(5));
                post.setPicsPath(rs.getString(6));
                post.setCategory(rs.getString(7));
                post.setUpvote(rs.getInt(9));
                post.setTitle(rs.getString(10));

                posts.add(post);
            }

            rs.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public int deletePost(int postId){
        String sql = "delete from t_post where id = ?";
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
}
