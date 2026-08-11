package com.yss.controller;

import java.io.IOException;

import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * UI 화면 확인용 Controller.
 * WEB-INF/views 아래 JSP는 직접 접근할 수 없으므로 URL과 JSP를 연결한다.
 */
@Controller
public class ViewController {
@GetMapping("/member/join")
    public ModelAndView join(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("member/join");
    }


    @GetMapping("/product/category")
    public ModelAndView category(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("product/category");
    }

    @GetMapping("/product/detail")
    public ModelAndView detail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("product/detail");
    }

    @GetMapping("/product/search")
    public ModelAndView search(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("product/search");
    }

    @GetMapping("/mypage")
    public ModelAndView mypage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("mypage/mypage");
    }

    @GetMapping("/customer/contact")
    public ModelAndView contact(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("customer/contact");
    }

    @GetMapping("/order/agreement")
    public ModelAndView agreement(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("order/agreement");
    }

    @GetMapping("/order/checkout")
    public ModelAndView checkout(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("order/checkout");
    }

    @GetMapping("/order/complete")
    public ModelAndView complete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("order/complete");
    }

    @GetMapping("/common/search-modal")
    public ModelAndView searchModal(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        return new ModelAndView("common/search-modal");
    }
}
