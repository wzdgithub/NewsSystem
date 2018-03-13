package com.test;

import org.springframework.stereotype.Controller;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

/**
 * Created by ZhenDong on 2017/3/21.
 */

@ServerEndpoint("/webSocket")
public class WebSocketTest {

    @OnOpen
    public void onOpen(Session session){
        System.out.println("客户端连接成功");
    }

    @OnMessage
    public void onMessage(String message, Session session){
        System.out.println(message);
        session.getAsyncRemote().sendText("收到了你的消息");
    }



    @OnClose
    public void onClose() {
        System.out.println("客户端关闭");
    }
}
