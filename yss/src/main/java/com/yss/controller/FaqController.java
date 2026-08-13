package com.yss.controller;

import java.io.IOException;
import java.util.List;

import com.yss.dto.FaqDTO;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.FaqService;
import com.yss.service.FaqServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/customer/faq/*")
public class FaqController {
	
	private FaqService service = new FaqServiceImpl();
	
	@GetMapping("list")
	public ModelAndView list(
			HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {
		
		ModelAndView mav =
				new ModelAndView("customer/faq/list");
		
		try {
			List<FaqDTO> list = service.listFaq();
			
			mav.addObject("list", list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
}