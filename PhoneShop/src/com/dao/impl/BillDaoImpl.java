package com.dao.impl;

import com.bean.Bill;
import com.dao.BillDao;
import com.utils.SimpleJDBCUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class BillDaoImpl implements BillDao {
    @Override
    public List<Bill> selectBill(int userid, int start, int end) {
        String sql = "";
        ResultSet rs = null;
        List<Bill> bills = new ArrayList<Bill>();
        try {
            if (userid != -1){
                sql = "select * from t_bill where userid = ? limit ?,?";
                rs = SimpleJDBCUtil.executQuery(sql, new Object[]{userid, start, end});
            }else {
                sql = "select * from t_bill limit ?,?";
                rs = SimpleJDBCUtil.executQuery(sql,new Object[]{start,end});
            }
            while (rs.next()){
                Bill bill = new Bill();
                bill.setId(rs.getInt(1));
                bill.setUserid(rs.getInt(2));
                bill.setIcon(rs.getString(3));
                bill.setShopname(rs.getString(4));
                bill.setPrice(rs.getFloat(5));
                bill.setConsignee(rs.getString(6));
                bill.setTelephone(rs.getString(7));
                bill.setAddress(rs.getString(8));
                bills.add(bill);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return bills;
    }

    @Override
    public int selectBillSum(int userid) {
        String sql = "";
        ResultSet rs = null;
        int count = 0;
        try {
            if (userid == -1){
                sql = "select count(*) from t_bill";
                rs = SimpleJDBCUtil.executQuery(sql,new Object[]{});
            }else {
                sql = "select count(*) from t_bill where userid = ?";
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
    public void insertBill(Bill bill) {
        String sql = "insert into t_bill (userid,icon,shopname,price,consignee,telephone,address) values (?,?,?,?,?,?,?)";
        try{
            SimpleJDBCUtil.executUpdate(sql,new Object[]{bill.getUserid(),bill.getIcon(),bill.getShopname(),bill.getPrice(),
            bill.getConsignee(),bill.getTelephone(),bill.getAddress()});
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void deleteBill(int id) {
        String sql = "delete from t_bill where id = ?";
        try{
            SimpleJDBCUtil.executUpdate(sql,new Object[]{id});
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
