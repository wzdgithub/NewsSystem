package com.dao;

import java.util.List;

import com.bean.News;

public interface NewsDao {
	List<News> selectNewsByCategory(String category, int start, int end); //分类查找新闻
	List<News> selectNewsByTitle(String title,int start,int end); //根据标题查找新闻
	List<News> selectNewsByScore(int start,int end);
	boolean insertNews(News news); //添加新闻
	boolean deleteNews(int id); //删除新闻
	boolean updateNews(News news); //修改新闻
	List<News> selectAllNews(int start,int end); //查看所有新闻
	News selectNews(int id); //显示新闻内容
	int selectNewsSum();
	int selectNewsSum(String category);
	int selectNewsSumByTitle(String title);
	boolean updateNewsPic(int id,String pic);
	boolean updateNewsScore(int id,float score);
	boolean updateNewsScoreSum(int id,int num);
}
