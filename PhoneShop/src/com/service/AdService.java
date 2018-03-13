package com.service;

import com.bean.Ad;
import com.dao.AdDao;
import com.dao.impl.AdDaoImpl;

import java.util.List;


public class AdService {
    private AdDao adDao = new AdDaoImpl();
    public void insertAd(Ad ad){
        adDao.insertAd(ad);
    }
    public void deleteAd(int id){
        adDao.deleteAd(id);
    }
    public List<Ad> selectAd(){
        return adDao.selectAd();
    }
}
