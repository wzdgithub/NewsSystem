package com.service;

import com.bean.PageBean;
import com.bean.Phone;
import com.dao.PhoneDao;
import com.dao.impl.PhoneDaoImpl;

import java.util.ArrayList;
import java.util.List;


public class PhoneService {
    private PhoneDao phoneDao = new PhoneDaoImpl();
    public boolean insertPhone(Phone phone){
        boolean isInsert = false;
        try {
            isInsert = phoneDao.insertPhone(phone);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isInsert;
    }
    public PageBean selectPhone(int num,int currentPage){
        PageBean pageBean = new PageBean();
        List<Phone> phones = null;
        try {
            int allRow = phoneDao.selectPhoneSum(null);
            phones = phoneDao.selectPhone((currentPage - 1) * num,num);
            pageBean.setPageList(phones);
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
    public PageBean selectPhoneByName(String name,int num,int currentPage){
        PageBean pageBean = new PageBean();
        List<Phone> phones = null;
        try {
            int allRow = phoneDao.selectPhoneSum(null);
            phones = phoneDao.selectPhoneByName(name, (currentPage - 1) * num, num);
            pageBean.setPageList(phones);
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
    public PageBean selectPhoneByCategory(String category,int num,int currentPage) {
        PageBean pageBean = new PageBean();
        List<Phone> phones = null;
        try {
            int allRow = phoneDao.selectPhoneSum(category);
            phones = phoneDao.selectPhoneByCategory(category,(currentPage - 1) * num,num);
            pageBean.setPageList(phones);
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
    public PageBean selectPhoneBySales(String category,int num,int currentPage) {
        PageBean pageBean = new PageBean();
        List<Phone> phones = null;
        try {
            int allRow = phoneDao.selectPhoneSum(category);
            phones = phoneDao.selectPhoneBySales(category, (currentPage - 1) * num, num);
            pageBean.setPageList(phones);
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
    public PageBean selectPhoneByPrice(String category,int num,int currentPage){
        PageBean pageBean = new PageBean();
        List<Phone> phones = null;
        try {
            int allRow = phoneDao.selectPhoneSum(category);
            phones = phoneDao.selectPhoneByPrice(category, (currentPage - 1) * num, num);
            pageBean.setPageList(phones);
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
    public PageBean selectPhoneByDate(String category,int num,int currentPage) {
        PageBean pageBean = new PageBean();
        List<Phone> phones = null;
        try {
            int allRow = phoneDao.selectPhoneSum(category);
            phones = phoneDao.selectPhoneByDate(category, (currentPage - 1) * num,num);
            pageBean.setPageList(phones);
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
    public Phone selectPhoneById(int id) {
        Phone phone = null;
        try {
            phone = phoneDao.selectPhoneById(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return phone;
    }
    public boolean deletePhoneById(int id) {
        boolean isDelete = false;
        try {
            isDelete = phoneDao.deletePhoneById(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isDelete;
    }
    public boolean updatePhoneById(Phone phone) {
        boolean isUpdate = false;
        try {
            isUpdate = phoneDao.updatePhoneById(phone);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdate;
    }
    public List<Phone> selectSales(){
        List<Phone> phones = new ArrayList<Phone>();
        try {
            phones = phoneDao.selectSales();
        }catch (Exception e){
            e.printStackTrace();
        }
        return phones;
    }
    public List<Phone> selectDate(){
        List<Phone> phones = new ArrayList<Phone>();
        try {
            phones = phoneDao.selectDate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return phones;
    }
    public boolean updateSales(int id){
        return phoneDao.updateSales(id);
    }
}
