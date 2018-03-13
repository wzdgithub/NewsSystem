package com.controller;

import com.bean.Album;
import com.service.AlbumService;
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
import java.util.Date;
import java.util.List;

/**
 * Created by ZhenDong on 2017/4/27.
 */
@Controller
public class AlbumController {
    @Resource(name = "albumService")
    private AlbumService albumService;

    @Resource(name = "photoService")
    private PhotoService photoService;

    @RequestMapping(value = "/createAlbum",method = RequestMethod.POST)
    public String createAlbum(@RequestParam int userId,@RequestParam String name, @RequestParam String info,
                              @RequestParam String category,@RequestParam MultipartFile icon,
                              HttpServletRequest request){
        String iconPath="";
        Album album = new Album();
        album.setUserId(userId);
        album.setName(name);
        album.setInfo(info);
        album.setCategory(category);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        album.setDate(formatter.format(new Date()));
        try {
            if (icon.getOriginalFilename() !=null&&icon.getOriginalFilename()!=""){
                iconPath = "<img src='http://localhost:8080/icon/album/"+icon.getOriginalFilename()+"'/>";

                String realPath = request.getSession().getServletContext()
                        .getRealPath("/icon/album");

                FileUtils.copyInputStreamToFile(icon.getInputStream(), new File(
                        realPath, icon.getOriginalFilename()));

            }else{
                iconPath ="<img src='http://localhost:8080/icon/album/pic-none.png'>";
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        album.setIcon(iconPath);
        albumService.insertAlbum(album);
        return "redirect:/module/photoAlbum/album.jsp";
    }

    @RequestMapping(value = "/selectAlbums",method = RequestMethod.POST)
    public @ResponseBody
    List<Album> selectAlbums(@RequestParam int userId){
        return albumService.selectAlbum(userId);
    }

    @RequestMapping(value = "/deleteAlbum",method = RequestMethod.GET)
    public String deleteAlbum(@RequestParam int id){
        int n = albumService.deleteAlbum(id);
        photoService.deleteAllAlbumPhoto(id);
        if (n>0)
            return "redirect:/module/photoAlbum/album.jsp";
        return "redirect:/module/failure/index.jsp";
    }

    public AlbumService getAlbumService() {
        return albumService;
    }

    public void setAlbumService(AlbumService albumService) {
        this.albumService = albumService;
    }

    public PhotoService getPhotoService() {
        return photoService;
    }

    public void setPhotoService(PhotoService photoService) {
        this.photoService = photoService;
    }
}
