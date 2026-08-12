package com.yss.controller;

import java.io.IOException;

import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.annotation.ResponseBody;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/product/detail/*")
public class ProductDetailController {
	
    @GetMapping("")
    public ModelAndView productDetailForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("product/detail");
    }
    
    @GetMapping("information")
    public ModelAndView informationForm(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/information");
    }
    
    @GetMapping("review")
    public ModelAndView reviewForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	return new ModelAndView("product/detail/review");
    }
    
    //AJAX
    @ResponseBody
    @PostMapping("review")
    public ModelAndView reviewSubmit(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/review");
    }
    
    
    @GetMapping("qna")
    public ModelAndView qnaForm(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/qna");
    }

    //AJAX
    @ResponseBody
    @PostMapping("qna")
    public ModelAndView qnaSubmit(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/qna");
    }

    //AJAX
    @ResponseBody
    @PostMapping("bookmark")
    public ModelAndView bookmarkSubmit(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/bookmark");
    }
    
    //AJAX
    @ResponseBody
    @PostMapping("share")
    public ModelAndView shareSubmit(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/share");
    }
    
    
}
