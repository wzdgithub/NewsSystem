package com.service;

import com.bean.AnswerPlus;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ZhenDong on 2017/5/1.
 */
@Service
public class AnswerService {
    @Resource(name = "dataSource")
    private ComboPooledDataSource dataSource;

    public int insertAnswerPlus(AnswerPlus answerPlus) {
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            String sql = "insert into t_answer(user_id,question_id,content,img,a_date,display) values (?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,answerPlus.getUserId());
            ps.setInt(2,answerPlus.getQuestionId());
            ps.setString(3,answerPlus.getContent());
            ps.setString(4,answerPlus.getImg());
            ps.setString(5,answerPlus.getDate());
            ps.setString(6,answerPlus.getDisplay());
            n = ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }

    public List<AnswerPlus> selectAnswerPlus(int questionId,int answerNum){
        List<AnswerPlus> answerPluses = new ArrayList<>();
        try {
            Connection connection = dataSource.getConnection();
            String sql = "select a.id,a.user_id,a.question_id,a.content,a.img,a.a_date,a.display," +
                    "u.user_name,u.icon from t_answer a,t_user u where a.user_id = u.id AND a.question_id="+questionId+" AND a.display = 'display' Order By a_date DESC limit "+answerNum+",15";
            Statement stmt  = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                AnswerPlus answerPlus = new AnswerPlus();
                answerPlus.setId(rs.getInt(1));
                answerPlus.setUserId(rs.getInt(2));
                answerPlus.setQuestionId(rs.getInt(3));
                answerPlus.setContent(rs.getString(4));
                answerPlus.setImg(rs.getString(5));
                answerPlus.setDate(rs.getString(6));
                answerPlus.setDisplay(rs.getString(7));
                answerPlus.setUserName(rs.getString(8));
                answerPlus.setUserIcon(rs.getString(9));

                answerPluses.add(answerPlus);
            }

            rs.close();
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return answerPluses;
    }
    public int deleteAnswer(int id){
        String sql = "delete from t_answer where id = ?";
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
    public int deleteAllQuestionAnswer(int questionId){
        String sql = "delete from t_answer where question_id = ?";
        int n = 0;
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, questionId);
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
