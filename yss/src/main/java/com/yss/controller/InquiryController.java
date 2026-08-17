package com.yss.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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
import com.yss.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/customer/inquiry/*")
public class InquiryController {
	private PaginateUtil paginateUtil = new PaginateUtil();
	private InquiryService service = new InquiryServiceImpl();
	
	// 1:1 문의
    @GetMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	// 게시물 리스트
    	ModelAndView mav = new ModelAndView("customer/inquiry/list");
    	HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberId", info.getMemberId());
			
			// 전체 데이터
			dataCount = service.dataCount(map);
			
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			// 게시물 가져오기
			int offset = (current_page - 1) * size;
			if (offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<InquiryDTO> list = service.listInquiry(map);
			
			// 페이징 처리
			String cp = req.getContextPath();
			String listUrl = cp + "/customer/inquiry/list";
			String articleUrl = cp + "/customer/inquiry/article?page=" + current_page;

			String paging = paginateUtil.paging(current_page, total_page, listUrl);	
			
			// 포워딩할 JSP에 전달할 속성
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("paging", paging);
						
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
