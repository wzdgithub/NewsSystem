package com.dao;

import com.bean.Score;

import java.util.List;

/**
 * Created by admin on 2016/4/12.
 */
public interface ScoreDao {
    boolean insertScore(Score score);
    boolean deleteScore(int id);
    List<Score> selectScore(int start,int end);
    List<Score> selectScore(int userid);
    int scoreSum();
}
