package com.yss.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.yss.dto.InquiryDTO;
import com.yss.dto.SessionInfo;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.InquiryService;
import com.yss.service.InquiryServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/customer/inquiry/*")
public class InquiryController {
	private InquiryService service = new InquiryServiceImpl();
	
	// 1:1 문의
    @GetMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	ModelAndView mav = new ModelAndView("customer/inquiry/list");
    	HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}
		
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
			
			int dataCount = service.dataCount(map);

			
		} catch (Exception e) {
			e.printStackTrace();
		}

        return mav;
    }
 
    @GetMapping("write")
    public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	ModelAndView mav = new ModelAndView("customer/inquiry/write");
    	mav.addObject("mode", "write");
        return mav;
    }
    
    @PostMapping("write")
    public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	SessionInfo info = (SessionInfo) session.getAttribute("member"); 
    	
    	try {
			InquiryDTO dto = new InquiryDTO();
			
			// MemberId는 세션에 저장된 정보
			dto.setMemberId(info.getMemberId());
			
			// 파라미터
			dto.setInquiryType(req.getParameter("inquiryType"));
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			
			service.insertInquiry(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
        return new ModelAndView("redirect:/customer/inquiry/list");
    }

}
