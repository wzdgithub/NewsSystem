package com.action;

import com.bean.Bill;
import com.bean.PageBean;
import com.service.BillService;
import com.service.PhoneService;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;

public class BillAction {
    private int id;
    private int userid;
    private String icon;
    private String shopname;
    private float price;
    private String consignee;
    private String telephone;
    private String address;
    private int phoneid;
    private int currentPage = 1;

    private BillService billService = new BillService();

    public String insertBill(){
        Bill bill = new Bill();
        bill.setUserid(userid);
        bill.setIcon(icon);
        bill.setShopname(shopname);
        bill.setPrice(price);
        bill.setConsignee(consignee);
        bill.setTelephone(telephone);
        bill.setAddress(address);
        billService.insertBill(bill);
        new PhoneService().updateSales(phoneid);
        return "insertBillSuccess";
    }

    public String selectBill(){
        PageBean billPage = billService.selectBill(userid, 10, currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("billPage",billPage);
        return "selectBillSuccess";
    }

    public String deleteBill(){
        billService.deleteBill(id);
        return "deleteBillSuccess";
    }
    public String selectBillAdmin(){
        PageBean billPageAdmin = billService.selectBill(-1,10,currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("billPageAdmin",billPageAdmin);
        return "selectBillAdminSuccess";
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

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public BillService getBillService() {
        return billService;
    }

    public void setBillService(BillService billService) {
        this.billService = billService;
    }

    public int getPhoneid() {
        return phoneid;
    }

    public void setPhoneid(int phoneid) {
        this.phoneid = phoneid;
    }
}
