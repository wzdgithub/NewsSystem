package com.action;

import com.bean.Feedback;
import com.bean.PageBean;
import com.utils.FeedbackService;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * Created by admin on 2016/3/24.
 */
public class FeedbackAction {
    private int id;
    private int userid;
    private String content;
    private int currentPage = 1;

    private FeedbackService feedbackService = new FeedbackService();
    public String insertFeedback(){
        Feedback feedback = new Feedback();
        feedback.setUserid(userid);
        feedback.setContent(content);
        feedback.setDate(new Date());
        feedbackService.insertFeedback(feedback);
        return "insertFeedbackSuccess";
    }

    public String selectFeedback(){
        PageBean feedbackPage =  feedbackService.selectFeedback(20,currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("feedbackPage",feedbackPage);
        return "selectFeedbackSuccess";
    }

    public String deleteFeedback(){
        feedbackService.deleteFeedback(id);
        return "deleteFeedback";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
}
