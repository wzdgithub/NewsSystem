package com.action;

import com.bean.PageBean;
import com.bean.Score;
import com.dao.NewsDao;
import com.dao.ScoreDao;
import com.dao.impl.NewsDaoImpl;
import com.dao.impl.ScoreDaoImpl;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/4/12.
 */
public class ScoreAction {
    private int id;
    private int userid;
    private String username;
    private int newsid;
    private String newstitle;
    private float score;

    private ScoreDao scoreDao = new ScoreDaoImpl();
    private NewsDao newsDao = new NewsDaoImpl();

    private int currentPage = 1;

    public String insertScore(){
        newsDao.updateNewsScore(newsid,score);
        newsDao.updateNewsScoreSum(newsid,1);
        Score s = new Score();
        s.setUserid(userid);
        s.setUsername(username);
        s.setNewsid(newsid);
        s.setNewstitle(newstitle);
        s.setScore(score);
        scoreDao.insertScore(s);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("id",newsid);
        Map session = ServletActionContext.getContext().getSession();
        List<Score> scores = scoreDao.selectScore(userid);
        session.put("scores",scores);
        return "insertScoreSuccess";
    }
    public String selectScore(){
        PageBean pageBean = new PageBean();
        List<Score> scores = null;
        int num = 25;
        try {
            int allRow = scoreDao.scoreSum();
            scores = scoreDao.selectScore((currentPage - 1) * num, num);
            pageBean.setPageList(scores);
            pageBean.setCurrentPage(currentPage);
            if(allRow%num == 0) {
                pageBean.setTotalPage(allRow / num);
            }else {
                pageBean.setTotalPage(allRow / num + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("ScorePageBean",pageBean);
        return "selectScoreSuccess";
    }
    public String deleteScore(){
        newsDao.updateNewsScore(newsid,-score);
        newsDao.updateNewsScoreSum(newsid,-1);
        scoreDao.deleteScore(id);
        Map session = ServletActionContext.getContext().getSession();
        List<Score> scores = scoreDao.selectScore(userid);
        session.put("scores",scores);
        return "deleteScoreSuccess";
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getNewsid() {
        return newsid;
    }

    public void setNewsid(int newsid) {
        this.newsid = newsid;
    }

    public String getNewstitle() {
        return newstitle;
    }

    public void setNewstitle(String newstitle) {
        this.newstitle = newstitle;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
}
