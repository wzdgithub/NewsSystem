package com.action;

import com.bean.Comment;
import com.bean.News;
import com.bean.PageBean;
import com.bean.Score;
import com.dao.CommentDao;
import com.dao.NewsDao;
import com.dao.ScoreDao;
import com.dao.impl.CommentDaoImpl;
import com.dao.impl.NewsDaoImpl;
import com.dao.impl.ScoreDaoImpl;
import com.utils.UploadUtil;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2016/4/10.
 */
public class NewsAction {
    private int id;
    private String title;
    private String content;
    private File pic;
    private String picFileName;
    private Date date;
    private String author;
    private String category; //分类
    private int score;
    private int commentnum;
    private NewsDao newsDao = new NewsDaoImpl();

    private int currentPage = 1;
    //主页内容
    public String home(){
        HttpServletRequest request = ServletActionContext.getRequest();
        List<News> military = newsDao.selectNewsByCategory("军事", 0, 12);
        request.setAttribute("military", military);
        List<News> social = newsDao.selectNewsByCategory("社会", 0, 12);
        request.setAttribute("social", social);
        List<News> economic = newsDao.selectNewsByCategory("财经", 0, 12);
        request.setAttribute("economic", economic);
        List<News> technology = newsDao.selectNewsByCategory("科技", 0, 12);
        request.setAttribute("technology", technology);
        List<News> sports = newsDao.selectNewsByCategory("体育", 0, 12);
        request.setAttribute("sports", sports);
        List<News> entertain = newsDao.selectNewsByCategory("娱乐", 0, 12);
        request.setAttribute("entertain", entertain);
        return "homeSuccess";
    }
    //显示新闻具体信息和评论
    public String selectNews(){
        HttpServletRequest request = ServletActionContext.getRequest();
        int newsid = (int) request.getAttribute("id");
        News news = newsDao.selectNews(newsid);
        request.setAttribute("news", news);
        CommentDao commentDao = new CommentDaoImpl();
        List<Comment> comments = commentDao.selectCommentAndNews(newsid);
        request.setAttribute("comments", comments);
        return "selectNewsSuccess";
    }
    //管理员分页查看所有新闻
    public String AllNewsByAdmin(){
        PageBean pageBean = new PageBean();
        List<News> newses = null;
        int num = 10;
        try {
            int allRow = newsDao.selectNewsSum();
            newses = newsDao.selectAllNews((currentPage - 1) * num, num);
            pageBean.setPageList(newses);
            pageBean.setCurrentPage(currentPage);
            if(allRow%num == 0) {
                pageBean.setTotalPage(allRow / num);
            }else {
                pageBean.setTotalPage(allRow / num + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Map session = ServletActionContext.getContext().getSession();
        session.put("NewsPageBeanByAdmin",pageBean);
        return "AllNewsByAdminSuccess";
    }
    //添加新闻
    public String insertNews(){
        UploadUtil.upload(pic,picFileName);
        News news = new News();
        news.setTitle(title);
        news.setAuthor(author);
        news.setPic("images/" + picFileName);
        news.setContent(content);
        news.setCategory(category);
        news.setDate(new Date());
        news.setScore(0);
        news.setCommentnum(0);
        newsDao.insertNews(news);
        return "insertNewsSuccess";
    }
    //删除新闻
    public String deleteNews(){
        newsDao.deleteNews(id);
        return "deleteNewsSuccess";
    }
    //更新新闻
    public String updateNews(){
        News news = new News();
        news.setId(id);
        news.setTitle(title);
        news.setAuthor(author);
        news.setContent(content);
        news.setCategory(category);
        news.setDate(date);
        newsDao.updateNews(news);
        return "updateNewsSuccess";
    }
    //修改新闻展示图片
    public String updateNewsPic(){
        UploadUtil.upload(pic,picFileName);
        newsDao.updateNewsPic(id,picFileName);
        return "updateNewsSuccess";
    }
    //根据类型查找新闻
    public String selectNewsByCategory(){
        PageBean pageBean = new PageBean();
        List<News> newses = null;
        int num = 25;
        try {
            int allRow = newsDao.selectNewsSum(category);
            newses = newsDao.selectNewsByCategory(category,(currentPage - 1) * num, num);
            pageBean.setPageList(newses);
            pageBean.setCurrentPage(currentPage);
            if(allRow%num == 0) {
                pageBean.setTotalPage(allRow / num);
            }else {
                pageBean.setTotalPage(allRow / num + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<News> newsScore = new ArrayList<News>();
        newsScore = newsDao.selectNewsByScore(0,20);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("NewsPageBean",pageBean);
        request.setAttribute("category",category);
        request.setAttribute("newsScore",newsScore);
        return "selectNewsByCategorySuccess";
    }

    public String selectNewsByTitle(){
        PageBean pageBean = new PageBean();
        List<News> newses = null;
        int num = 25;
        try {
            int allRow = newsDao.selectNewsSumByTitle(title);
            newses = newsDao.selectNewsByTitle(title, (currentPage - 1) * num, num);
            pageBean.setPageList(newses);
            pageBean.setCurrentPage(currentPage);
            if(allRow%num == 0) {
                pageBean.setTotalPage(allRow / num);
            }else {
                pageBean.setTotalPage(allRow / num + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<News> newsScore = new ArrayList<News>();
        newsScore = newsDao.selectNewsByScore(0,20);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("NewsPageBean",pageBean);
        request.setAttribute("category","查询结果");
        request.setAttribute("newsScore",newsScore);
        request.setAttribute("title",title);
        return "selectNewsByTitleSuccess";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public File getPic() {
        return pic;
    }

    public void setPic(File pic) {
        this.pic = pic;
    }

    public String getPicFileName() {
        return picFileName;
    }

    public void setPicFileName(String picFileName) {
        this.picFileName = picFileName;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getCommentnum() {
        return commentnum;
    }

    public void setCommentnum(int commentnum) {
        this.commentnum = commentnum;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
}
