package com.service;

import com.bean.Category;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZhenDong on 2017/5/2.
 */
@Service
public class CategoryService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertCategory(Category category){
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_category(content,part) values (?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,category.getContent());
            ps.setString(2,category.getPart());
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public List<Category> selectCategory(){
        List<Category> categories = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_category ";
            Statement stmt  = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                Category category = new Category();
                category.setId(rs.getInt(1));
                category.setContent(rs.getString(2));
                category.setPart(rs.getString(3));

                categories.add(category);
            }

            rs.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<Category> selectPartCategory(String part){
        List<Category> categories = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_category where part = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,part);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Category category = new Category();
                category.setId(rs.getInt(1));
                category.setContent(rs.getString(2));
                category.setPart(rs.getString(3));

                categories.add(category);
            }

            rs.close();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public int deleteCategory(int id){
        String sql = "delete from t_category where id = ?";
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
