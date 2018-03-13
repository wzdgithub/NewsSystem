package com.controller;

import com.bean.Question;
import com.bean.QuestionPlus;
import com.service.AnswerService;
import com.service.QuestionService;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by ZhenDong on 2017/4/30.
 */
@Controller
public class QuestionController {

    @Resource(name = "questionService")
    private QuestionService questionService;

    @Resource(name = "answerService")
    private AnswerService answerService;

    @RequestMapping(value = "/insertQuestion",method = RequestMethod.POST)
    public String insertQuestion(@RequestParam int userId, @RequestParam String title, @RequestParam String detail, @RequestParam MultipartFile[] pics,
                          HttpServletRequest request){
        Question question = new Question();
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
        question.setUserId(userId);
        question.setTitle(title);
        question.setDate(formatter.format(new Date()));
        question.setDisplay("display");
        question.setImg(picsPath);
        question.setCategory("问题");
        question.setDetail(detail);
        questionService.insertQuestion(question);
        return "redirect:/module/question/index.jsp";
    }

    @RequestMapping(value = "/showQuestionPlus",method = RequestMethod.POST)
    public @ResponseBody
    List<QuestionPlus> showQuestionPlus(@RequestParam int questionNum){
        List<QuestionPlus> questionPluses = questionService.selectQuestion(questionNum);
        return questionPluses;
    }

    @RequestMapping(value = "/selectAllQuestion",method = RequestMethod.POST)
    public @ResponseBody
    List<QuestionPlus> selectAllQuestion(@RequestParam int page){
        List<QuestionPlus> questionPluses = questionService.selectAllQuestion(page,15);
        return questionPluses;
    }

    @RequestMapping(value = "/question",method = RequestMethod.GET)
    public String question(@RequestParam int id, @RequestParam String username,HttpSession session){
        Question question = questionService.question(id);
        session.setAttribute("question",question);
        session.setAttribute("username",username);
        return "redirect:/module/question/content.jsp";
    }

    @RequestMapping(value = "/deleteQuestion",method = RequestMethod.GET)
    public String deleteQuestion(@RequestParam int id){
        int n = questionService.deleteQuestion(id);
        answerService.deleteAllQuestionAnswer(id);
        return "redirect:/module/question/index.jsp";
    }

    @RequestMapping(value = "/deleteAdminQuestion",method = RequestMethod.POST)
    public @ResponseBody
    List<QuestionPlus> deleteAdminQuestion(@RequestParam int id,int page){
        questionService.deleteQuestion(id);
        answerService.deleteAllQuestionAnswer(id);
        List<QuestionPlus> questionPluses = questionService.selectAllQuestion(page,15);
        return questionPluses;
    }

    public QuestionService getQuestionService() {
        return questionService;
    }

    public void setQuestionService(QuestionService questionService) {
        this.questionService = questionService;
    }

    public AnswerService getAnswerService() {
        return answerService;
    }

    public void setAnswerService(AnswerService answerService) {
        this.answerService = answerService;
    }
}
