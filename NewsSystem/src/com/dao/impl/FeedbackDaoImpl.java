package com.dao.impl;

import com.bean.Feedback;
import com.dao.FeedbackDao;
import com.utils.SimpleJDBCUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by admin on 2016/3/24.
 */
public class FeedbackDaoImpl implements FeedbackDao {
    @Override
    public void insertFeedback(Feedback feedback) {
        String sql = "insert into t_feedback (userid,content,date) values (?,?,?)";
        try {
            SimpleJDBCUtil.executUpdate(sql,new Object[]{feedback.getUserid(),feedback.getContent(),feedback.getDate()});
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int selectFeedbackSum() {
        String sql = "select count(*) from t_feedback";
        ResultSet rs = null;
        int count = 0;
        try {
            rs = SimpleJDBCUtil.executQuery(sql, new Object[]{});
            if (rs.next())
                count = rs.getInt(1);
        }catch (Exception e){}
        return count;
    }

    @Override
    public List<Feedback> selectFeedback(int start, int end) {
        String sql = "select * from t_feedback order by date desc limit ?,?";
        List<Feedback> feedbacks = new ArrayList<Feedback>();
        try {
            ResultSet rs = SimpleJDBCUtil.executQuery(sql, new Object[]{start,end});
            while(rs.next()){
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt(1));
                feedback.setUserid(rs.getInt(2));
                feedback.setContent(rs.getString(3));
                feedback.setDate(rs.getDate(4));
                feedbacks.add(feedback);
            }
        }catch (Exception e){}
        return feedbacks;
    }

    @Override
    public void deleteFeedback(int id) {
        String sql = "delete from t_feedback where id = ?";
        try{
            SimpleJDBCUtil.executUpdate(sql,new Object[]{id});
        }catch (Exception e){}
    }
}
