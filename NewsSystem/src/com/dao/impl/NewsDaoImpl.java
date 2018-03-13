package com.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.bean.News;
import com.dao.NewsDao;
import com.utils.SimpleJDBCUtil;

public class NewsDaoImpl implements NewsDao {
	public List<News> newsList(ResultSet rs){
		List<News> newses = new ArrayList<News>();
		try {
			while(rs.next()){
                News news = new News();
				news.setId(rs.getInt(1));
				news.setTitle(rs.getString(2));
				news.setContent(rs.getString(3));
				news.setPic(rs.getString(4));
				news.setDate(rs.getDate(5));
				news.setAuthor(rs.getString(6));
				news.setCategory(rs.getString(7));
				news.setScore(rs.getInt(8));
				news.setCommentnum(rs.getInt(9));
				newses.add(news);
            }
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return newses;
	}

	@Override
	public boolean deleteNews(int id) {
		String sql = "delete from t_news where id = ?";
		int n = 0;
		try {
			n = SimpleJDBCUtil.executUpdate(sql,new Object[]{id});
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(n>0)
			return true;
		else
			return false;
	}

	@Override
	public boolean insertNews(News news){
		String sql = "insert into t_news (title,content,pic,date,author,category,score,comment_num) values (?,?,?,?,?,?,?,?)";
		int n = 0;
		try {
			n = SimpleJDBCUtil.executUpdate(sql, new Object[]{news.getTitle(), news.getContent(), news.getPic(),
					news.getDate(), news.getAuthor(), news.getCategory(), news.getScore(), news.getCommentnum()});
		} catch (Exception e) {
		}
		if(n>0)
			return true;
		else
			return false;
	}

	@Override
	public List<News> selectAllNews(int start,int end) {
		// TODO Auto-generated method stub
		String sql = "select * from t_news order by date desc limit ?,?";
		ResultSet rs = null;
		try {
			rs = SimpleJDBCUtil.executQuery(sql,new Object[]{start,end});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newsList(rs);
	}

	@Override
	public List<News> selectNewsByCategory(String category,int start,int end) {
		String sql = "select * from t_news where category=? order by date desc limit ?,? ";
		ResultSet resultSet = null;
		try {
			resultSet = SimpleJDBCUtil.executQuery(sql, new Object[]{category,start,end});
		} catch (Exception e) {
		}
		return newsList(resultSet);
	}

	@Override
	public List<News> selectNewsByTitle(String title,int start,int end) {
		String sql = "select * from t_news where title like ? limit ?,?";
		ResultSet rs = null;
		try {
			rs = SimpleJDBCUtil.executQuery(sql,new Object[]{"%"+title+"%",start,end});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newsList(rs);
	}

	@Override
	public News selectNews(int id) {
		String sql = "select * from t_news where id = ?";
		ResultSet resultSet = null;
		try {
			resultSet = SimpleJDBCUtil.executQuery(sql, new Object[]{id});
		} catch (Exception e) {
		}
		return newsList(resultSet).remove(0);
	}

	@Override
	public boolean updateNews(News news) {
		String sql = "update t_news set title=?,content=?,date=?,author=?,category=? where id = ?";
		int n = 0;
		try {
			n = SimpleJDBCUtil.executUpdate(sql, new Object[]{news.getTitle(), news.getContent(),
					news.getDate(), news.getAuthor(), news.getCategory(),news.getId()});
		} catch (Exception e) {
		}
		if(n>0)
			return true;
		else
			return false;
	}

	@Override
	public int selectNewsSum() {
		String sql = "select count(*) from t_news";
		ResultSet rs = null;
		int count  = 0;
		try {
			rs = SimpleJDBCUtil.executQuery(sql, new Object[]{});
			if (rs.next())
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public int selectNewsSum(String category) {
		String sql = "select count(*) from t_news where category = ?";
		ResultSet rs = null;
		int count  = 0;
		try {
			rs = SimpleJDBCUtil.executQuery(sql, new Object[]{category});
			if (rs.next())
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public int selectNewsSumByTitle(String title) {
		String sql = "select count(*) from t_news where title like ?";
		ResultSet rs = null;
		int count  = 0;
		try {
			rs = SimpleJDBCUtil.executQuery(sql, new Object[]{"%"+title+"%"});
			if (rs.next())
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public boolean updateNewsPic(int id, String pic) {
		String sql = "update t_news set pic = ? where id = ?";
		int n = 0;
		try {
			n = SimpleJDBCUtil.executUpdate(sql, new Object[]{"images/"+pic,id});
		} catch (Exception e) {
		}
		if(n>0)
			return true;
		else
			return false;
	}

	@Override
	public boolean updateNewsScore(int id, float score) {
		String sql = "update t_news set score = score + ? where id = ?";
		int n = 0;
		try {
			n = SimpleJDBCUtil.executUpdate(sql,new Object[]{score,id});
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (n>0)
			return true;
		else
			return false;
	}

	@Override
	public boolean updateNewsScoreSum(int id,int num) {
		String sql = "update t_news set comment_num = comment_num + 1 where id = ?";
		int n = 0;
		try {
			n = SimpleJDBCUtil.executUpdate(sql,new Object[]{id});
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (n>0)
			return true;
		else
			return false;
	}

	@Override
	public List<News> selectNewsByScore(int start, int end) {
		String sql = "select * from t_news order by score desc limit ?,?";
		ResultSet rs = null;
		List<News> newses = new ArrayList<News>();
		try {
			rs = SimpleJDBCUtil.executQuery(sql, new Object[]{start, end});
			while (rs.next()){
				News news = new News();
				news.setId(rs.getInt(1));
				news.setTitle(rs.getString(2));
				news.setContent(rs.getString(3));
				news.setPic(rs.getString(4));
				news.setDate(rs.getDate(5));
				news.setAuthor(rs.getString(6));
				news.setCategory(rs.getString(7));
				news.setScore(rs.getInt(8));
				news.setCommentnum(rs.getInt(9));
				newses.add(news);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newses;
	}
}
