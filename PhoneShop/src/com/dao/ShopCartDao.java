package com.dao;

import com.bean.ShopCart;

import java.util.List;


public interface ShopCartDao {
    List<ShopCart> selectShopCart(int userid,int start,int end);
    int selectShopCartSum(int userid);
    void insertShopCart(ShopCart shopCart);
    void deleteShopCart(int id);
}
