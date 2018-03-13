package com.dao;

import com.bean.Admin;


public interface AdminDao {
    Admin loginAdmin(String username,String password);
}
