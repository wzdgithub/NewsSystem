package com.dao;

import com.bean.Bill;

import java.util.List;


public interface BillDao {
    List<Bill> selectBill(int userid,int start,int end);
    int selectBillSum(int userid);
    void insertBill(Bill bill);
    void deleteBill(int id);
}
