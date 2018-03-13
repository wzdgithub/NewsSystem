package com.controller;

import org.springframework.stereotype.Controller;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Hashtable;
import java.util.Map;

/**
 * Created by ZhenDong on 2017/3/21.
 */

@ServerEndpoint("/instantChat/{userId}/{friendId}")
public class InstantChatController {
    private static final Map<Integer,Session> map = new Hashtable<>();
    private Session mySession;
    private Session friendSession;
    private int userId;
    private int friendId;
    @OnOpen
    public void start(Session session,@PathParam("userId")int userId,@PathParam("friendId") int friendId){
        mySession = session;
        this.userId = userId;
        this.friendId = friendId;
        map.put(userId,session);
        friendSession = map.get(friendId);
        System.out.println(userId + ":" + friendId);
    }

    @OnMessage
    public void incoming(String message){
        friendSession = map.get(friendId);
        try {
            if (friendSession == null) {
                mySession.getBasicRemote().sendText("此用户离线");
            }else{
                friendSession.getBasicRemote().sendText(message);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @OnError
    public void onError(Throwable t) throws Throwable {
        System.out.println("Chat Error: " + t.toString());
    }
    @OnClose
    public void end(){
        map.remove(userId);
        System.out.println("结束");
    }
}
