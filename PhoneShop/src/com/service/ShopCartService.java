package com.service;

import com.bean.PageBean;
import com.bean.Phone;
import com.bean.ShopCart;
import com.dao.ShopCartDao;
import com.dao.impl.ShopCartDaoImpl;

import java.util.List;


public class ShopCartService {
    private ShopCartDao shopCartDao = new ShopCartDaoImpl();

    public PageBean selectShopCart(int userid,int num,int currentPage){
        PageBean pageBean = new PageBean();
        List<ShopCart> shopCarts = null;
        try {
            int allRow = shopCartDao.selectShopCartSum(userid);
            shopCarts = shopCartDao.selectShopCart(userid, (currentPage - 1) * num, num);
            pageBean.setPageList(shopCarts);
            pageBean.setCurrentPage(currentPage);
            if(allRow%num == 0) {
                pageBean.setTotalPage(allRow / num);
            }else {
                pageBean.setTotalPage(allRow / num + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pageBean;
    }
    public void insertShopCart(ShopCart shopCart){
        shopCartDao.insertShopCart(shopCart);
    }
    public void deleteShopCart(int id){
        shopCartDao.deleteShopCart(id);
    }
}
