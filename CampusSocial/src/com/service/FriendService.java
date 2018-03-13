package com.service;

import com.bean.Friend;
import com.bean.User;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZhenDong on 2017/3/27.
 */
@Service
public class FriendService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;
    public List<Friend> selectFriend(int userId){
        List<Friend> friends = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select t_friend.id,t_friend.user_id,t_friend.friend_id,t_friend.friend_group_id,t_friend.f_date,t_user.user_name,t_user.icon" +
                    " from t_friend join t_user where t_friend.user_id = ? and t_friend.friend_id = t_user.id ";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Friend friend = new Friend();
                friend.setId(rs.getInt(1));
                friend.setUserId(rs.getInt(2));
                friend.setFriendId(rs.getInt(3));
                friend.setFriendGroupId(rs.getInt(4));
                friend.setDate(rs.getString(5));
                friend.setFriendName(rs.getString(6));
                friend.setUserIcon(rs.getString(7));

                friends.add(friend);
            }

            rs.close();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return friends;
    }

    public List<User> selectName(String username,int pageNum,int userId){
        List<User> users = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_user u where " +
                    "not exists(select * from t_friend f where u.id = f.friend_id and f.user_id = "+userId+") " +
                    "and u.id != "+userId+" and u.user_name like '%"+username+"%' limit "+pageNum+",15";
            Statement stmt  = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                User user = new User();
                user.setId(rs.getInt(1));
                user.setUsername(rs.getString(2));
                user.setIcon(rs.getString(8));
                user.setAutograph(rs.getString(11));

                users.add(user);
            }

            rs.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    public int insertFriend(int userId,int friendId,int fgId,String date){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_friend(user_id,friend_id,friend_group_id,f_date) values (?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,userId);
            ps.setInt(2,friendId);
            ps.setInt(3,fgId);
            ps.setString(4,date);
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
    public int deleteFriend(int userId,int friendId ){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "delete from t_friend  where user_id = ? and friend_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,userId);
            ps.setInt(2,friendId);
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
    public boolean selectIsFriend(int userId,int friendId){
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_friend where user_id = ? and friend_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,userId);
            ps.setInt(2,friendId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                rs.close();
                ps.close();
                connection.close();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ComboPooledDataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(ComboPooledDataSource dataSource) {
        this.dataSource = dataSource;
    }
}
