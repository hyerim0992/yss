package com.yss.controller.admin;

import java.io.IOException;

import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeManageController {

    @GetMapping("/admin")
    public ModelAndView dashboard(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("admin/dashboard/main");
    }
    @GetMapping("/admin/logistics")
    public ModelAndView logistics(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("admin/logistics/main");
    }

    @GetMapping("/admin/support")
    public ModelAndView support(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("redirect:/admin/support/inquiry/list");
    }

    @GetMapping("/admin/status")
    public ModelAndView status(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("admin/status/main");
    }
}
