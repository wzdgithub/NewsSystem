package com.service;

import com.bean.Bill;
import com.bean.PageBean;
import com.dao.BillDao;
import com.dao.impl.BillDaoImpl;

import java.util.List;


public class BillService {
    private BillDao billDao = new BillDaoImpl();

    public PageBean selectBill(int userid,int num,int currentPage){
        PageBean pageBean = new PageBean();
        List<Bill> bills = null;
        try {
            int allRow = billDao.selectBillSum(userid);
            bills = billDao.selectBill(userid, (currentPage - 1) * num, num);
            pageBean.setPageList(bills);
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

    public void insertBill(Bill bill){
        billDao.insertBill(bill);
    }

    public void deleteBill(int id){
        billDao.deleteBill(id);
    }
}
