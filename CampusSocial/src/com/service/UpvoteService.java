package com.service;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ZhenDong on 2017/4/28.
 */
@Service
public class UpvoteService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int isUpvote(int postId,int userId){
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_upvote where post_id = ? and user_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,postId);
            ps.setInt(2,userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next())
                return 1;
            rs.close();
            ps.close();
            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int plusUpvote(int postId,int userId){
        int n = 0;
        String sql = "INSERT INTO t_upvote(post_id,user_id) values(?,?)";
        String sql1 = "update t_post set upvote = upvote + 1 WHERE id = ?";

        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,postId);
            ps.setInt(2,userId);
            if(ps.executeUpdate()>0)
                n++;
            ps.close();

            PreparedStatement ps1 = connection.prepareStatement(sql1);
            ps1.setInt(1,postId);
            if(ps1.executeUpdate()>0)
                n++;
            ps1.close();

            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public int minusUpvote(int postId,int userId){
        int n = 0;
        String sql = "delete from t_upvote WHERE post_id =? AND user_id = ?";
        String sql1 = "update t_post set upvote = upvote - 1 WHERE id = ?";

        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,postId);
            ps.setInt(2,userId);
            if(ps.executeUpdate()>0)
                n++;
            ps.close();

            PreparedStatement ps1 = connection.prepareStatement(sql1);
            ps1.setInt(1,postId);
            if(ps1.executeUpdate()>0)
                n++;
            ps1.close();

            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
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
