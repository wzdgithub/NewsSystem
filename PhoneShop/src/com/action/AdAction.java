package com.action;

import com.bean.Ad;
import com.service.AdService;
import com.utils.UploadUtil;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;


public class AdAction {
    private int id;
    private File adImg;
    private String adImgFileName;
    private String adImgType;
    private String adUrl;
    private AdService adService = new AdService();

    public String insertAd(){
        UploadUtil.upload(adImg,adImgFileName);
        Ad ad = new Ad();
        ad.setAdImg("images/"+adImgFileName);
        ad.setAdUrl(adUrl);
        adService.insertAd(ad);
        return "insertAdSuccess";
    }
    public String selectAd(){
        List<Ad> adList = adService.selectAd();
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("adList", adList);
        return "selectAdSuccess";
    }
    public String deleteAd(){
        adService.deleteAd(id);
        return "deleteAdSuccess";
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public File getAdImg() {
        return adImg;
    }

    public void setAdImg(File adImg) {
        this.adImg = adImg;
    }

    public String getAdImgFileName() {
        return adImgFileName;
    }

    public void setAdImgFileName(String adImgFileName) {
        this.adImgFileName = adImgFileName;
    }

    public String getAdUrl() {
        return adUrl;
    }

    public void setAdUrl(String adUrl) {
        this.adUrl = adUrl;
    }

    public String getAdImgType() {
        return adImgType;
    }

    public void setAdImgType(String adImgType) {
        this.adImgType = adImgType;
    }
}
