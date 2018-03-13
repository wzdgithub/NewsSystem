package com.controller;

import com.bean.Photo;
import com.service.PhotoService;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ZhenDong on 2017/4/27.
 */
@Controller
public class PhotoController {

    @Resource(name = "photoService")
    private PhotoService photoService;

    @RequestMapping(value = "/uploadPhotos",method = RequestMethod.POST)
    public String uploadPhotos(@RequestParam int userId,@RequestParam int albumId,@RequestParam String name,
                               @RequestParam MultipartFile[] pics, HttpServletRequest request){
        List<Photo> photos = new ArrayList();
        for (MultipartFile pic : pics) {
            Photo photo = new Photo();
            photo.setUserId(userId);
            photo.setAlbumId(albumId);
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            photo.setDate(formatter.format(new Date()));
            photo.setName(name);
            photo.setUrl("/photos/"+pic.getOriginalFilename());
            String realPath = request.getSession().getServletContext()
                    .getRealPath("/photos");
            try {
                FileUtils.copyInputStreamToFile(pic.getInputStream(), new File(
                        realPath, pic.getOriginalFilename()));
            } catch (IOException e) {
                e.printStackTrace();
            }
            photos.add(photo);
        }
        photoService.insertPhotos(photos);
        return "redirect:/module/photoAlbum/album.jsp";
    }

    @RequestMapping(value = "/selectPhotos",method = RequestMethod.POST)
    public @ResponseBody
    List<Photo> selectPhotos(@RequestParam int albumId){
        return photoService.selectPhotosByAlbum(albumId);
    }

    @RequestMapping(value = "/deletePhoto",method = RequestMethod.GET)
    public String deletePhoto(@RequestParam int id,@RequestParam int albumId,@RequestParam int num){
        int n = photoService.deletePhoto(id);
        if (n>0)
            return "redirect:/module/photoAlbum/photos.jsp?albumId="+albumId+"&num="+num;
        return "redirect:/module/failure/index.jsp";
    }

    public PhotoService getPhotoService() {
        return photoService;
    }

    public void setPhotoService(PhotoService photoService) {
        this.photoService = photoService;
    }
}
