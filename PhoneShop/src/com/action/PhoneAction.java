package com.action;

import com.bean.Ad;
import com.bean.PageBean;
import com.bean.Phone;
import com.opensymphony.xwork2.ActionContext;
import com.service.AdService;
import com.service.CommentService;
import com.service.PhoneService;
import com.utils.UploadUtil;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class PhoneAction {
    private int id;
    private String category;
    private String name;
    private File introduction_img;
    private String introduction_imgFileName;
    private File preview_img;
    private String preview_imgFileName;
    private String price;
    private String brand;
    private String model;
    private String color;
    private String cpu;
    private String internal_storage;
    private String external_storage;
    private String screen_size;
    private String resolution_ratio;
    private String later_camera;
    private String before_camera;
    private String shop;
    private String sales;
    private Date date;
    private int currentPage = 1;
    private int CommentCurrentPage = 1;

    private PhoneService phoneService = new PhoneService();
    private CommentService commentService = new CommentService();
    private AdService adService = new AdService();

    public String home(){
        selectSales();
        selectDate();
        selectAd();
        return "homeSuccess";
    }

    public String insertPhone(){
        UploadUtil.upload(introduction_img,introduction_imgFileName);
        UploadUtil.upload(preview_img,preview_imgFileName);
        Phone phone = becomePhone();
        if(phoneService.insertPhone(phone))
            return "insertPhoneSuccess";
        else
            return "insertPhoneFailed";

    }
    public String selectPhoneByCategory(){
        PageBean pagePhone = phoneService.selectPhoneByCategory(category,20,currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("pagePhone",pagePhone);
        return "selectPhoneByCategorySuccess";
    }
    public String selectPhoneBySales(){
        PageBean pagePhone = phoneService.selectPhoneBySales(category, 20, currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("pagePhone",pagePhone);
        return "selectPhoneBySalesSuccess";
    }
    public String selectPhoneByPrice(){
        PageBean pagePhone = phoneService.selectPhoneByPrice(category,20,currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("pagePhone",pagePhone);
        return "selectPhoneByPriceSuccess";
    }
    public String selectPhoneByDate(){
        PageBean pagePhone = phoneService.selectPhoneByDate(category, 20, currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("pagePhone",pagePhone);
        return "selectPhoneByDateSuccess";
    }
    public String selectPhoneById(){
        Phone phone = phoneService.selectPhoneById(id);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("phone",phone);

        PageBean commentPage = commentService.selectComment(id,20,CommentCurrentPage);
        request.setAttribute("commentPage",commentPage);

        return "selectPhoneByIdSuccess";
    }
    public String selectPhone(){
        PageBean pageAdminPhone = phoneService.selectPhone(8,currentPage);
        Map session = ActionContext.getContext().getSession();
        session.put("pageAdminPhone",pageAdminPhone);
        return "selectPhoneSuccess";
    }
    public String updatePhoneById(){
        UploadUtil.upload(introduction_img,introduction_imgFileName);
        UploadUtil.upload(preview_img,preview_imgFileName);
        Phone phone = becomePhone();
        phone.setId(id);
        phoneService.updatePhoneById(phone);
        return "updatePhoneByIdSuccess";
    }
    public String deletePhoneById(){
        phoneService.deletePhoneById(id);
        return "deletePhoneByIdSuccess";
    }
    public String selectPhoneByName(){
        PageBean pagePhone = phoneService.selectPhoneByName(name, 20, currentPage);
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("pagePhone",pagePhone);
        return "selectPhoneByNameSuccess";
    }


    public Phone becomePhone(){
        Phone phone = new Phone();
        phone.setCategory(category);
        phone.setName(name);
        phone.setIntroduction_img("images//"+introduction_imgFileName);
        phone.setPreview_img("images//" + preview_imgFileName);
        phone.setPrice(Float.parseFloat(price));
        phone.setBrand(brand);
        phone.setModel(model);
        phone.setColor(color);
        phone.setCpu(cpu);
        phone.setInternal_storage(internal_storage);
        phone.setExternal_storage(external_storage);
        phone.setScreen_size(screen_size);
        phone.setResolution_ratio(resolution_ratio);
        phone.setLater_camera(later_camera);
        phone.setBefore_camera(before_camera);
        phone.setShop(shop);
        return phone;
    }
    public void selectSales(){
        List<Phone> phoneSales = phoneService.selectSales();
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("phoneSales",phoneSales);
    }
    public void selectDate(){
        List<Phone> phoneDate = phoneService.selectDate();
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("phoneDate",phoneDate);
    }
    public void selectAd(){
        List<Ad> adList = adService.selectAd();
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setAttribute("adList",adList);
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public File getIntroduction_img() {
        return introduction_img;
    }

    public void setIntroduction_img(File introduction_img) {
        this.introduction_img = introduction_img;
    }

    public String getIntroduction_imgFileName() {
        return introduction_imgFileName;
    }

    public void setIntroduction_imgFileName(String introduction_imgFileName) {
        this.introduction_imgFileName = introduction_imgFileName;
    }

    public File getPreview_img() {
        return preview_img;
    }

    public void setPreview_img(File preview_img) {
        this.preview_img = preview_img;
    }

    public String getPreview_imgFileName() {
        return preview_imgFileName;
    }

    public void setPreview_imgFileName(String preview_imgFileName) {
        this.preview_imgFileName = preview_imgFileName;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getInternal_storage() {
        return internal_storage;
    }

    public void setInternal_storage(String internal_storage) {
        this.internal_storage = internal_storage;
    }

    public String getExternal_storage() {
        return external_storage;
    }

    public void setExternal_storage(String external_storage) {
        this.external_storage = external_storage;
    }

    public String getScreen_size() {
        return screen_size;
    }

    public void setScreen_size(String screen_size) {
        this.screen_size = screen_size;
    }

    public String getResolution_ratio() {
        return resolution_ratio;
    }

    public void setResolution_ratio(String resolution_ratio) {
        this.resolution_ratio = resolution_ratio;
    }

    public String getLater_camera() {
        return later_camera;
    }

    public void setLater_camera(String later_camera) {
        this.later_camera = later_camera;
    }

    public String getBefore_camera() {
        return before_camera;
    }

    public void setBefore_camera(String before_camera) {
        this.before_camera = before_camera;
    }

    public String getShop() {
        return shop;
    }

    public void setShop(String shop) {
        this.shop = shop;
    }

    public String getSales() {
        return sales;
    }

    public void setSales(String sales) {
        this.sales = sales;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public PhoneService getPhoneService() {
        return phoneService;
    }

    public void setPhoneService(PhoneService phoneService) {
        this.phoneService = phoneService;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getCommentCurrentPage() {
        return CommentCurrentPage;
    }

    public void setCommentCurrentPage(int commentCurrentPage) {
        CommentCurrentPage = commentCurrentPage;
    }
}
