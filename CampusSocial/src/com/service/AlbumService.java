package com.service;

import com.bean.Album;
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
 * Created by ZhenDong on 2017/4/27.
 */
@Service
public class AlbumService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertAlbum(Album album){
        int n = 0;
        String sql = "insert into t_album(user_id,a_name,a_info,a_date,a_category,a_icon)" +
                "values(?,?,?,?,?,?)";
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,album.getUserId());
            ps.setString(2,album.getName());
            ps.setString(3,album.getInfo());
            ps.setString(4,album.getDate());
            ps.setString(5,album.getCategory());
            ps.setString(6,album.getIcon());
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public List<Album> selectAlbum(int userId){
        List<Album> albumList = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_album where user_id = ? ";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,userId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Album album = new Album();
                album.setId(rs.getInt(1));
                album.setUserId(rs.getInt(2));
                album.setName(rs.getString(3));
                album.setInfo(rs.getString(4));
                album.setDate(rs.getString(5));
                album.setCategory(rs.getString(6));
                album.setIcon(rs.getString(7));

                albumList.add(album);
            }

            rs.close();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return albumList;
    }

    public int deleteAlbum(int id){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "delete from t_album where id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,id);
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
