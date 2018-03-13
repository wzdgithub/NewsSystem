package com.bean;

import java.util.List;

/**
 * Created by ZhenDong on 2017/3/27.
 */
public class FriendList {
    private List<FriendGroup> friendGroups;
    private List<Friend> friends;

    public List<FriendGroup> getFriendGroups() {
        return friendGroups;
    }

    public void setFriendGroups(List<FriendGroup> friendGroups) {
        this.friendGroups = friendGroups;
    }

    public List<Friend> getFriends() {
        return friends;
    }

    public void setFriends(List<Friend> friends) {
        this.friends = friends;
    }
}
