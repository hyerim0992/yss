package com.yss.controller;

import java.io.IOException;
import java.util.List;

import com.yss.dto.HomeDTO;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.HomeService;
import com.yss.service.HomeServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeController {
	private HomeService service = new HomeServiceImpl();
	
    @GetMapping("/main")
    public ModelAndView main(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	
    	ModelAndView mav = new ModelAndView("home/main");
    	
    	try {
			List<HomeDTO> bestList = service.homeBestList();
			mav.addObject("bestList", bestList);
			
			List<HomeDTO> newList = service.homeNewList();
			mav.addObject("newList", newList);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
        return mav;
    }
}
