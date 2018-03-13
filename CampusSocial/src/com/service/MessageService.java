package com.service;

import com.bean.Message;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZhenDong on 2017/4/29.
 */
@Service
public class MessageService {

    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertMessage(Message message){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_message(root_id,source_id,content,category,m_date,m_type,extend) values (?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,message.getRootId());
            ps.setInt(2,message.getSourceId());
            ps.setString(3,message.getContent());
            ps.setString(4,message.getCategory());
            ps.setString(5,message.getDate());
            ps.setString(6,message.getType());
            ps.setInt(7,message.getExtend());

            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public List<Message> selectMessage(int userId,String category,String type){
        List<Message> messages = new ArrayList<>();
        String sql = "";
        if (type==null)
            sql = "select * from t_message where root_id = ? AND category = ?";
        else
            sql = "select * from t_message where root_id = ? AND category = ? and m_type = ?";
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,userId);
            ps.setString(2,category);
            if (type != null)
                ps.setString(3,type);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Message message = new Message();
                message.setId(rs.getInt(1));
                message.setRootId(rs.getInt(2));
                message.setSourceId(rs.getInt(3));
                message.setContent(rs.getString(4));
                message.setCategory(rs.getString(5));
                message.setDate(rs.getString(6));
                message.setType(rs.getString(7));
                message.setExtend(rs.getInt(8));
                messages.add(message);
            }

            rs.close();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }
    public boolean selectMessage(int rootId,int sourceId){
        String sql = "select * from t_message where root_id = ? AND source_id = ?";
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,rootId);
            ps.setInt(2,sourceId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            }
            rs.close();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public int updateMessageType(int rootId,int sourceId,String type){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "update t_message set m_type=? WHERE root_id = ? and source_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,type);
            ps.setInt(2,rootId);
            ps.setInt(3,sourceId);
            n = ps.executeUpdate();
            ps.close();
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
