package com.bean;


/**
 * Created by ZhenDong on 2017/3/27.
 */
public class Friend {
    private int id;
    private int userId;  //登录者ID
    private String friendName;  //朋友的用户名
    private int friendId;  //朋友的ID
    private int friendGroupId;  //此朋友所在组
    private String date;
    private String userIcon;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getFriendId() {
        return friendId;
    }

    public void setFriendId(int friendId) {
        this.friendId = friendId;
    }

    public int getFriendGroupId() {
        return friendGroupId;
    }

    public void setFriendGroupId(int friendGroupId) {
        this.friendGroupId = friendGroupId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getFriendName() {
        return friendName;
    }

    public void setFriendName(String friendName) {
        this.friendName = friendName;
    }

    public String getUserIcon() {
        return userIcon;
    }

    public void setUserIcon(String userIcon) {
        this.userIcon = userIcon;
    }
}
