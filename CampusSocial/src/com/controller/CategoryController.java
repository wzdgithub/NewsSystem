package com.controller;

import com.bean.Category;
import com.service.CategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by ZhenDong on 2017/5/2.
 */
@Controller
public class CategoryController {
    @Resource(name = "categoryService")
    private CategoryService categoryService;

    @RequestMapping(value = "/selectCategory",method = RequestMethod.POST)
    public @ResponseBody
    List<Category> selectCategory(){
        return categoryService.selectCategory();
    }

    @RequestMapping(value = "/deleteCategory",method = RequestMethod.POST)
    public @ResponseBody
    List<Category> deleteCategory(@RequestParam int id){
        categoryService.deleteCategory(id);
        return categoryService.selectCategory();
    }

    @RequestMapping(value = "/insertCategory",method = RequestMethod.POST)
    public String insertCategory(Category category){
        categoryService.insertCategory(category);
        return "redirect:/module/admin/categoryAdmin.jsp";
    }

    public CategoryService getCategoryService() {
        return categoryService;
    }

    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }
}
