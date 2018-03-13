package com.dao;

import com.bean.Phone;

import java.util.List;


public interface PhoneDao {
    List<Phone> selectPhone(int start,int end) throws Exception;
    List<Phone> selectPhoneByName(String name,int start,int end) throws Exception;
    List<Phone> selectPhoneByCategory(String category,int start,int end) throws Exception;
    List<Phone> selectPhoneBySales(String category,int start,int end) throws Exception;
    List<Phone> selectPhoneByPrice(String category,int start,int end) throws Exception;
    List<Phone> selectPhoneByDate(String category,int start,int end) throws Exception;
    Phone selectPhoneById(int id) throws Exception;
    int selectPhoneSum(String category) throws Exception;
    boolean insertPhone(Phone phone) throws Exception;
    boolean deletePhoneById(int id) throws Exception;
    boolean updatePhoneById(Phone phone) throws Exception;
    List<Phone> selectSales() throws Exception;
    List<Phone> selectDate() throws Exception;
    boolean updateSales(int id);
}
