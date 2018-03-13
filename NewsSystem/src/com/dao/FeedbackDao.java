package com.dao;

import com.bean.Feedback;

import java.util.List;

/**
 * Created by admin on 2016/3/24.
 */
public interface FeedbackDao {
    void insertFeedback(Feedback feedback);
    int selectFeedbackSum();
    List<Feedback> selectFeedback(int start, int end);
    void deleteFeedback(int id);
}
