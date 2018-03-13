package com.service;

import com.bean.Photo;
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
public class PhotoService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertPhotos(List<Photo> photos){
        int n = 0;
        String sql = "insert into t_photos(user_id,album_id,p_name,p_url,p_date)" +
                "values(?,?,?,?,?)";
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            for(Photo photo:photos){
                ps.setInt(1,photo.getUserId());
                ps.setInt(2,photo.getAlbumId());
                ps.setString(3,photo.getName());
                ps.setString(4,photo.getUrl());
                ps.setString(5,photo.getDate());
                n = ps.executeUpdate();
            }
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public List<Photo> selectPhotosByAlbum(int albumId){
        List<Photo> photos = new ArrayList<>();
        String sql = "select * from t_photos where album_id = ?";
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,albumId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Photo photo = new Photo();

                photo.setId(rs.getInt(1));
                photo.setUserId(rs.getInt(2));
                photo.setAlbumId(rs.getInt(3));
                photo.setName(rs.getString(4));
                photo.setDisplay(rs.getString(5));
                photo.setUrl(rs.getString(6));
                photo.setDate(rs.getString(7));

                photos.add(photo);
            }
            rs.close();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return photos;
    }

    public int deletePhoto(int id ){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "delete from t_photos where id = ?";
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
    public int deleteAllAlbumPhoto(int albumId ){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "delete from t_photos where album_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,albumId);
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
