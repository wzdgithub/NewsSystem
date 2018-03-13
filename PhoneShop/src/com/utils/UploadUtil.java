package com.utils;

import org.apache.struts2.ServletActionContext;

import java.io.*;


public class UploadUtil {
    public static boolean upload(File file,String fileName) {
        byte[] b = new byte[1024];
        int i = 0;
        try {
            FileInputStream in = new FileInputStream(file);
            String path = ServletActionContext.getServletContext().getRealPath("/") + "\\images\\" + fileName;
            FileOutputStream out = new FileOutputStream(path);
            while((i = in.read(b)) > 0){
                out.write(b,0,i);
            }
            in.close();
            out.close();
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }
}
