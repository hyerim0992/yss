package com.yss.controller;

import java.io.IOException;

import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeController {
    @GetMapping("/main")
    public ModelAndView main(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("home/main");
    }
}
