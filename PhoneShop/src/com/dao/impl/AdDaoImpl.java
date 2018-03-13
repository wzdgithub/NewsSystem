package com.dao.impl;

import com.bean.Ad;
import com.dao.AdDao;
import com.utils.SimpleJDBCUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class AdDaoImpl implements AdDao {
    @Override
    public void insertAd(Ad ad) {
        String sql = "insert into t_ad (adimg,adurl) values (?,?)";
        try {
            SimpleJDBCUtil.executUpdate(sql,new Object[]{ad.getAdImg(),ad.getAdUrl()});
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteAd(int id) {
        String sql = "delete from t_ad where id = ?";
        try {
            SimpleJDBCUtil.executUpdate(sql,new Object[]{id});
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Ad> selectAd() {
        String sql = "select * from t_ad";
        List<Ad> adList = new ArrayList<Ad>();
        try {
            ResultSet rs = SimpleJDBCUtil.executQuery(sql,new Object[]{});
            while(rs.next()){
                Ad ad = new Ad();
                ad.setId(rs.getInt(1));
                ad.setAdImg(rs.getString(2));
                ad.setAdUrl(rs.getString(3));
                adList.add(ad);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return adList;
    }
}
