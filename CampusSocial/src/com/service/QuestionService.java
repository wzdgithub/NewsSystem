package com.service;

import com.bean.Question;
import com.bean.QuestionPlus;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZhenDong on 2017/4/30.
 */
@Service
public class QuestionService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertQuestion(Question question) {
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_question(user_id,title,detail,img,q_date,display,category) values (?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,question.getUserId());
            ps.setString(2,question.getTitle());
            ps.setString(3,question.getDetail());
            ps.setString(4,question.getImg());
            ps.setString(5,question.getDate());
            ps.setString(6,question.getDisplay());
            ps.setString(7,question.getCategory());
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public List<QuestionPlus> selectQuestion(int questionNum){
        List<QuestionPlus> questionPluses = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select q.id,q.user_id,q.title,q.detail,q.img,q.q_date,q.display,q.category," +
                    "u.user_name,u.icon from t_question q,t_user u where q.user_id = u.id AND q.display = 'display' Order By q_date DESC limit "+questionNum+",15";
            Statement stmt  = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                QuestionPlus questionPlus = new QuestionPlus();
                questionPlus.setId(rs.getInt(1));
                questionPlus.setUserId(rs.getInt(2));
                questionPlus.setTitle(rs.getString(3));
                questionPlus.setDetail(rs.getString(4));
                questionPlus.setImg(rs.getString(5));
                questionPlus.setDate(rs.getString(6));
                questionPlus.setDisplay(rs.getString(7));
                questionPlus.setCategory(rs.getString(8));
                questionPlus.setUsername(rs.getString(9));
                questionPlus.setUserIcon(rs.getString(10));

                questionPluses.add(questionPlus);
            }

            rs.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questionPluses;
    }
    public Question question(int id){
        Question question = new Question();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select * from t_question where id = ? AND display = 'display'";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                question.setId(rs.getInt(1));
                question.setUserId(rs.getInt(2));
                question.setTitle(rs.getString(3));
                question.setDetail(rs.getString(4));
                question.setImg(rs.getString(5));
                question.setDate(rs.getString(6));
                question.setDisplay(rs.getString(7));
                question.setCategory(rs.getString(8));
            }

            rs.close();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return question;
    }

    public int deleteQuestion(int id){
        String sql = "delete from t_question where id = ?";
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

    public List<QuestionPlus> selectAllQuestion(int page,int num){
        List<QuestionPlus> questionPluses = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select q.id,q.user_id,q.title,q.detail,q.img,q.q_date,q.display,q.category," +
                    "u.user_name,u.icon from t_question q,t_user u where q.user_id = u.id limit "+page+","+num;
            Statement stmt  = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                QuestionPlus questionPlus = new QuestionPlus();
                questionPlus.setId(rs.getInt(1));
                questionPlus.setUserId(rs.getInt(2));
                questionPlus.setTitle(rs.getString(3));
                questionPlus.setDetail(rs.getString(4));
                questionPlus.setImg(rs.getString(5));
                questionPlus.setDate(rs.getString(6));
                questionPlus.setDisplay(rs.getString(7));
                questionPlus.setCategory(rs.getString(8));
                questionPlus.setUsername(rs.getString(9));
                questionPlus.setUserIcon(rs.getString(10));

                questionPluses.add(questionPlus);
            }

            rs.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questionPluses;
    }

    public ComboPooledDataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(ComboPooledDataSource dataSource) {
        this.dataSource = dataSource;
    }
}
