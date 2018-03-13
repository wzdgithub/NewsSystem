package com.dao;

import com.bean.Ad;

import java.util.List;


public interface AdDao {
    void insertAd(Ad ad);
    void deleteAd(int id);
    List<Ad> selectAd();
}
