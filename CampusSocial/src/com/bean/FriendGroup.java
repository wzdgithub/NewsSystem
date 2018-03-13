package com.bean;

import org.springframework.stereotype.Component;

/**
 * Created by ZhenDong on 2017/3/20.
 */
@Component
public class FriendGroup {
    private int id;
    private String groupName;
    private int userId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
