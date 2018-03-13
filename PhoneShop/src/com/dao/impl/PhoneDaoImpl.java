package com.dao.impl;

import com.bean.Phone;
import com.dao.PhoneDao;
import com.utils.SimpleJDBCUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class PhoneDaoImpl implements PhoneDao {
    public List<Phone> phoneList(ResultSet rs) throws Exception{
        List<Phone> phones = new ArrayList<Phone>();
        while(rs.next()){
            Phone phone = new Phone();
            phone.setId(rs.getInt(1));
            phone.setCategory(rs.getString(2));
            phone.setName(rs.getString(3));
            phone.setIntroduction_img(rs.getString(4));
            phone.setPreview_img(rs.getString(5));
            phone.setPrice(rs.getFloat(6));
            phone.setBrand(rs.getString(7));
            phone.setModel(rs.getString(8));
            phone.setColor(rs.getString(9));
            phone.setCpu(rs.getString(10));
            phone.setInternal_storage(rs.getString(11));
            phone.setExternal_storage(rs.getString(12));
            phone.setScreen_size(rs.getString(13));
            phone.setResolution_ratio(rs.getString(14));
            phone.setLater_camera(rs.getString(15));
            phone.setBefore_camera(rs.getString(16));
            phone.setShop(rs.getString(17));
            phone.setSales(rs.getInt(18));
            phone.setDate(rs.getDate(19));
            phones.add(phone);
        }
        return phones;
    }
    @Override
    public List<Phone> selectPhone(int start,int end) throws Exception{
        String sql = "select * from t_phone limit ?,?";
        ResultSet rs = SimpleJDBCUtil.executQuery(sql,new Object[]{start,end});
        return phoneList(rs);
    }

    @Override
    public List<Phone> selectPhoneByName(String name,int start,int end) throws Exception{
        String sql = "select * from t_phone where name like ? limit ?,?";
        ResultSet rs = SimpleJDBCUtil.executQuery(sql,new Object[]{"%"+name+"%",start,end});
        return phoneList(rs);
    }

    @Override
    public List<Phone> selectPhoneByCategory(String category,int start,int end) throws Exception{
        String sql = "select * from t_phone where category = ? limit ?,?";
        ResultSet rs = SimpleJDBCUtil.executQuery(sql,new Object[]{category,start,end});
        return phoneList(rs);
    }

    @Override
    public List<Phone> selectPhoneBySales(String category,int start,int end) throws Exception{
        String sql = "";
        ResultSet rs = null;
        if(category.equals("null")) {
            sql = "select * from t_phone order by sales desc limit ?,? ";
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{start,end});
        }else{
            sql = "select * from t_phone where category = ? order by sales desc limit ?,? ";
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{category,start,end});
        }
        return phoneList(rs);
    }

    @Override
    public List<Phone> selectPhoneByPrice(String category,int start,int end) throws Exception{
        String sql = "";
        ResultSet rs = null;
        if(category.equals("null")){
            sql = "select * from t_phone order by price limit ?,? ";
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{start,end});
        }else{
            sql = "select * from t_phone where category = ? order by price limit ?,? ";
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{category,start,end});
        }
        return phoneList(rs);
    }

    @Override
    public List<Phone> selectPhoneByDate(String category,int start,int end) throws Exception{
        String sql = "";
        ResultSet rs = null;
        if(category.equals("null")){
            sql = "select * from t_phone order by date desc limit ?,? ";
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{start,end});
        }else{
            sql = "select * from t_phone where category = ? order by date desc limit ?,? ";
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{category,start,end});
        }
        return phoneList(rs);
    }

    @Override
    public Phone selectPhoneById(int id) throws Exception{
        String sql = "select * from t_phone where id = ?";
        ResultSet rs = SimpleJDBCUtil.executQuery(sql,new Object[]{id});
        return phoneList(rs).remove(0);
    }

    @Override
    public int selectPhoneSum(String category) throws Exception {
        String sql = "";
        ResultSet rs = null;
        if (category != null) {
            sql = "select count(*) from t_phone where category = ?";
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{category});
        }else {
            sql = "select count(*) from t_phone";
            rs = SimpleJDBCUtil.executQuery(sql,new Object[]{});
        }
        int count  = 0;
        if (rs.next())
            count = rs.getInt(1);
        return count;
    }

    @Override
    public boolean insertPhone(Phone phone) throws Exception{
        String sql = "insert into t_phone (category,name,introduction_img,preview_img,price,brand,model,color," +
                "cpu,internal_storage,external_storage,screen_size,resolution_ratio,later_camera,before_camera,shop,sales,date) " +
                "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        int n = SimpleJDBCUtil.executUpdate(sql,new Object[]{
                phone.getCategory(),phone.getName(),phone.getIntroduction_img(),phone.getPreview_img(),phone.getPrice(),
                phone.getBrand(),phone.getModel(),phone.getColor(),phone.getCpu(),phone.getInternal_storage(),phone.getExternal_storage(),
                phone.getScreen_size(),phone.getResolution_ratio(),phone.getLater_camera(),phone.getBefore_camera(),
                phone.getShop(),0,new Date()
        });
        if (n>0)
            return true;
        else
            return false;
    }

    @Override
    public boolean deletePhoneById(int id) throws Exception{
        String sql = "delete from t_phone where id = ?";
        int n = SimpleJDBCUtil.executUpdate(sql,new Object[]{id});
        if (n>0)
            return true;
        else
            return false;
    }

    @Override
    public boolean updatePhoneById(Phone phone) throws Exception{
        String sql = "update t_phone set category = ?,name = ?,introduction_img = ?,preview_img = ?,price = ?,brand = ?,model = ?,color = ?," +
                "cpu = ?,internal_storage = ?,external_storage = ?,screen_size = ?,resolution_ratio = ?,later_camera = ?,before_camera = ?,shop = ?" +
                "where id = ?";
        int n = SimpleJDBCUtil.executUpdate(sql,new Object[]{
                phone.getCategory(),phone.getName(),phone.getIntroduction_img(),phone.getPreview_img(),phone.getPrice(),
                phone.getBrand(),phone.getModel(),phone.getColor(),phone.getCpu(),phone.getInternal_storage(),phone.getExternal_storage(),
                phone.getScreen_size(),phone.getResolution_ratio(),phone.getLater_camera(),phone.getBefore_camera(),
                phone.getShop(),phone.getId()
        });
        if (n>0)
            return true;
        else
            return false;
    }

    @Override
    public List<Phone> selectSales() throws Exception {
        String sql = "select * from t_phone order by sales desc limit ?,? ";
        ResultSet rs = SimpleJDBCUtil.executQuery(sql,new Object[]{0,5});
        return phoneList(rs);
    }

    @Override
    public List<Phone> selectDate() throws Exception {
        String sql = "select * from t_phone order by date desc limit ?,? ";
        ResultSet rs = SimpleJDBCUtil.executQuery(sql,new Object[]{0,5});
        return phoneList(rs);
    }

    @Override
    public boolean updateSales(int id) {
        String sql = "update t_phone set sales = sales + 1 where id =?";
        int n = 0;
        try {
            n = SimpleJDBCUtil.executUpdate(sql,new Object[]{id});
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (n>0)
            return true;
        else
            return false;
    }
}
