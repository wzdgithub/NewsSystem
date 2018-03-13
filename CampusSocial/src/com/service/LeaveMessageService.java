package com.service;

import com.bean.LeaveMessage;
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
 * Created by ZhenDong on 2017/5/1.
 */
@Service
public class LeaveMessageService {

    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertLeaveMessage(LeaveMessage leaveMessage){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_leavemessage(user_id,friend_id,content,l_date) values (?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,leaveMessage.getUserId());
            ps.setInt(2,leaveMessage.getFriendId());
            ps.setString(3,leaveMessage.getContent());
            ps.setString(4,leaveMessage.getDate());

            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public List<LeaveMessage> selectLeaveMessage(int userId){
        List<LeaveMessage> leaveMessages = new ArrayList<>();
        String sql = "select l.id,l.user_id,l.friend_id,l.content,l.l_date,u.user_name  from t_leavemessage l,t_user u where l.user_id = u.id AND l.friend_id = ?";
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,userId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                LeaveMessage leaveMessage = new LeaveMessage();
                leaveMessage.setId(rs.getInt(1));
                leaveMessage.setUserId(rs.getInt(2));
                leaveMessage.setFriendId(rs.getInt(3));
                leaveMessage.setContent(rs.getString(4));
                leaveMessage.setDate(rs.getString(5));
                leaveMessage.setUserName(rs.getString(6));

                leaveMessages.add(leaveMessage);
            }

            rs.close();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leaveMessages;
    }

    public int deleteLeaveMessage(int id){
        String sql = "delete from t_leavemessage where id = ?";
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

    public ComboPooledDataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(ComboPooledDataSource dataSource) {
        this.dataSource = dataSource;
    }
}
