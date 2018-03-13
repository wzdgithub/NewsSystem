package com.controller;

import com.bean.AnswerPlus;
import com.service.AnswerService;
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
 * Created by ZhenDong on 2017/5/1.
 */
@Controller
public class AnswerController {
    @Resource(name = "answerService")
    private AnswerService answerService;

    @RequestMapping(value = "/insertAnswerPlus",method = RequestMethod.POST)
    public String insertAnswerPlus(@RequestParam int userId, @RequestParam int questionId, @RequestParam String content, @RequestParam MultipartFile[] pics,
                                 HttpServletRequest request){
        AnswerPlus answerPlus = new AnswerPlus();
        String picsPath = "";
        for (MultipartFile pic : pics) {
            String realPath = request.getSession().getServletContext()
                    .getRealPath("/upload");
            picsPath += "<img style='max-width: 50%;max-height: 250px;min-width: 50%; min-height: 200px;' " +
                    "src='http://localhost:8080/upload/"+pic.getOriginalFilename()+"'/>";
            try {
                FileUtils.copyInputStreamToFile(pic.getInputStream(), new File(
                        realPath, pic.getOriginalFilename()));
            } catch (IOException e) {
                picsPath="";
            }

        }
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        answerPlus.setUserId(userId);
        answerPlus.setQuestionId(questionId);
        answerPlus.setDate(formatter.format(new Date()));
        answerPlus.setDisplay("display");
        answerPlus.setImg(picsPath);
        answerPlus.setContent(content);
        answerService.insertAnswerPlus(answerPlus);
        return "redirect:/module/question/content.jsp";
    }

    @RequestMapping(value = "/showAnswerPlus",method = RequestMethod.POST)
    public @ResponseBody
    List<AnswerPlus> showAnswerPlus(@RequestParam int questionId,@RequestParam int answerNum){
        List<AnswerPlus> answerPluses = answerService.selectAnswerPlus(questionId,answerNum);
        return answerPluses;
    }


    @RequestMapping(value = "/deleteAnswer",method = RequestMethod.GET)
    public String deleteAnswer(@RequestParam int id){
        int n = answerService.deleteAnswer(id);
        return "redirect:/module/question/content.jsp";
    }

    public AnswerService getAnswerService() {
        return answerService;
    }

    public void setAnswerService(AnswerService answerService) {
        this.answerService = answerService;
    }
}
