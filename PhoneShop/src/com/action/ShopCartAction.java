package com.action;

import com.bean.PageBean;
import com.bean.ShopCart;
import com.service.ShopCartService;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;


public class ShopCartAction {
    private int id;
    private int userid;
    private String icon;
    private String shopname;
    private float price;
    private int currentPage = 1;

    private ShopCartService shopCartService = new ShopCartService();

    public String insertShopCart(){
        ShopCart shopCart = new ShopCart();
        shopCart.setUserid(userid);
        shopCart.setIcon(icon);
        shopCart.setShopname(shopname);
        shopCart.setPrice(price);
        shopCartService.insertShopCart(shopCart);
        return "insertShopCartSuccess";
    }
    public String selectShopCart(){
        PageBean shopCartPage = shopCartService.selectShopCart(userid, 10, currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("shopCartPage",shopCartPage);
        return "selectShopCartSuccess";
    }
    public String deleteShopCart(){
        shopCartService.deleteShopCart(id);
        return "deleteShopCartSuccess";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getShopname() {
        return shopname;
    }

    public void setShopname(String shopname) {
        this.shopname = shopname;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
}
