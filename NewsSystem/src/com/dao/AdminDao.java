package com.dao;

import com.bean.Admin;

/**
 * Created by admin on 2016/4/17.
 */
public interface AdminDao {
    Admin loginAdmin(String adminname,String password);
}
