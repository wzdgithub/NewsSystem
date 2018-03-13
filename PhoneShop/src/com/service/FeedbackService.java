package com.service;

import com.bean.Feedback;
import com.bean.PageBean;
import com.dao.FeedbackDao;
import com.dao.impl.FeedbackDaoImpl;

import java.util.List;


public class FeedbackService {
    private FeedbackDao feedbackDao = new FeedbackDaoImpl();

    public void insertFeedback(Feedback feedback){
        feedbackDao.insertFeedback(feedback);
    }
    public PageBean selectFeedback(int num,int currentPage){
        PageBean pageBean = new PageBean();
        List<Feedback> feedbacks = null;
        try {
            int allRow = feedbackDao.selectFeedbackSum();
            feedbacks = feedbackDao.selectFeedback((currentPage - 1) * num, num);
            pageBean.setPageList(feedbacks);
            pageBean.setCurrentPage(currentPage);
            if(allRow%num == 0) {
                pageBean.setTotalPage(allRow / num);
            }else {
                pageBean.setTotalPage(allRow / num + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pageBean;
    }
    public void deleteFeedback(int id){
        feedbackDao.deleteFeedback(id);
    }

    public FeedbackDao getFeedbackDao() {
        return feedbackDao;
    }

    public void setFeedbackDao(FeedbackDao feedbackDao) {
        this.feedbackDao = feedbackDao;
    }
}
