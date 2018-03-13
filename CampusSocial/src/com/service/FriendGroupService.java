package com.service;

import com.bean.FriendGroup;
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
 * Created by ZhenDong on 2017/3/20.
 */
@Service
public class FriendGroupService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int addFriendGroup(String groupName,int userId) {
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_friend_group(group_name,user_id) values (?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,groupName);
            ps.setInt(2,userId);
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public List<FriendGroup> selectFriendGroup(int userId){
        List<FriendGroup> friendGroups = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_friend_group where user_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                FriendGroup fg = new FriendGroup();
                fg.setId(rs.getInt(1));
                fg.setGroupName(rs.getString(2));
                fg.setUserId(rs.getInt(3));

                friendGroups.add(fg);
            }

            rs.close();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return friendGroups;
    }

    public String deleteFriendGroup(int friendGroupId){
        String sql1 = "delete from t_friend_group where id = ?";
        String sql2 = "update t_friend set friend_group_id = 0 where friend_group_id = ?";

        if (FGExecuteUpdate(sql1,friendGroupId) != -1)
            if (FGExecuteUpdate(sql2,friendGroupId) != -1)
                return "success";
        return null;
    }

    private int FGExecuteUpdate(String sql,int friendGroupId){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,friendGroupId);
            n = ps.executeUpdate();

            ps.close();
            connection.close();
        } catch (SQLException e) {
            n = -1;
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
