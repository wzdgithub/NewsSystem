package com.dao.impl;

import com.bean.ShopCart;
import com.dao.ShopCartDao;
import com.utils.SimpleJDBCUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class ShopCartDaoImpl implements ShopCartDao {
    @Override
    public List<ShopCart> selectShopCart(int userid, int start, int end) {
        String sql = "";
        ResultSet rs = null;
        List<ShopCart> shopCarts = new ArrayList<ShopCart>();
        try {
            if (userid != -1){
                sql = "select * from t_shopcart where userid = ? limit ?,?";
                rs = SimpleJDBCUtil.executQuery(sql,new Object[]{userid,start,end});
            }else {
                sql = "select * from t_shopcart where limit ?,?";
                rs = SimpleJDBCUtil.executQuery(sql,new Object[]{start,end});
            }
            while (rs.next()){
                ShopCart shopCart = new ShopCart();
                shopCart.setId(rs.getInt(1));
                shopCart.setUserid(rs.getInt(2));
                shopCart.setIcon(rs.getString(3));
                shopCart.setShopname(rs.getString(4));
                shopCart.setPrice(rs.getFloat(5));
                shopCarts.add(shopCart);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return shopCarts;
    }

    @Override
    public int selectShopCartSum(int userid) {
        String sql = "";
        ResultSet rs = null;
        int count = 0;
        try {
            if (userid == -1){
                sql = "select count(*) from t_shopcart";
                rs = SimpleJDBCUtil.executQuery(sql,new Object[]{});
            }else {
                sql = "select count(*) from t_shopcart where userid = ?";
                rs = SimpleJDBCUtil.executQuery(sql,new Object[]{userid});
            }
            if(rs.next())
                count = rs.getInt(1);
        }catch (Exception e){
            e.printStackTrace();
        }

        return count;
    }

    @Override
    public void deleteShopCart(int id) {
        String sql = "delete from t_shopcart where id = ?";
        try {
            SimpleJDBCUtil.executUpdate(sql,new Object[]{id});
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void insertShopCart(ShopCart shopCart) {
        String sql = "insert into t_shopcart (userid,icon,shopname,price) values (?,?,?,?)";
        try{
            SimpleJDBCUtil.executUpdate(sql,new Object[]{shopCart.getUserid(),shopCart.getIcon(),shopCart.getShopname(),shopCart.getPrice()});
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
