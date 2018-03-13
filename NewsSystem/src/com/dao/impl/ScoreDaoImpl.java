package com.dao.impl;

import com.bean.Score;
import com.dao.ScoreDao;
import com.utils.SimpleJDBCUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by admin on 2016/4/12.
 */
public class ScoreDaoImpl implements ScoreDao {
    @Override
    public boolean insertScore(Score score) {
        String sql = "insert into t_score (userid,username,newsid,newstitle,score) values (?,?,?,?,?)";
        int n = 0;
        try {
            n = SimpleJDBCUtil.executUpdate(sql,new Object[]{score.getUserid(),score.getUsername(),score.getNewsid(),
            score.getNewstitle(),score.getScore()});
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (n>0)
            return true;
        else
            return false;
    }

    @Override
    public boolean deleteScore(int id) {
        String sql = "delete from t_score where id = ?";
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
    public List<Score> selectScore(int start, int end) {
        String sql = "select * from t_score limit ?,?";
        ResultSet rs = null;
        List<Score> scores = new ArrayList<Score>();
        try {
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{start,end});
            while (rs.next()){
                Score score = new Score();
                score.setId(rs.getInt(1));
                score.setUserid(rs.getInt(2));
                score.setUsername(rs.getString(3));
                score.setNewsid(rs.getInt(4));
                score.setNewstitle(rs.getString(5));
                score.setScore(rs.getFloat(6));
                scores.add(score);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return scores;
    }

    @Override
    public List<Score> selectScore(int userid) {
        List<Score> scores = new ArrayList<Score>();
        String sql = "select * from t_score where userid = ?";
        ResultSet rs = null;
        try {
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{userid});
            while (rs.next()){
                Score score = new Score();
                score.setId(rs.getInt(1));
                score.setUserid(rs.getInt(2));
                score.setUsername(rs.getString(3));
                score.setNewsid(rs.getInt(4));
                score.setNewstitle(rs.getString(5));
                score.setScore(rs.getFloat(6));
                scores.add(score);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return scores;
    }

    @Override
    public int scoreSum() {
        String sql = "select count(*) from t_score";
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
}
