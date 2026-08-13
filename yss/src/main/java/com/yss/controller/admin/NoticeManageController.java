package com.yss.controller.admin;

import java.io.IOException;

import com.yss.dto.NoticeDTO;
import com.yss.dto.SessionInfo;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.NoticeService;
import com.yss.service.NoticeServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/support/notice/*")
public class NoticeManageController {
	private NoticeService service = new NoticeServiceImpl();
	
    @GetMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	ModelAndView mav = new ModelAndView("admin/support/notice/list");
    	
        return mav;
    }
    
    @GetMapping("write")
    public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	ModelAndView mav = new ModelAndView("admin/support/notice/write");
    	
    	mav.addObject("mode", "write");
    	
    	return mav;
    }
    
    @PostMapping("write")
    public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	HttpSession session = req.getSession();
    	SessionInfo info = (SessionInfo)session.getAttribute("member");
    	
    	
    	try {
			NoticeDTO dto = new NoticeDTO();
			
			dto.setMemberId(info.getMemberId());
			
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			
			service.insertNotice(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return new ModelAndView("redirect:/admin/support/notice/list");
    }
    
}
