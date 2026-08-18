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
import com.yss.util.MyUtil;
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
	private MyUtil util = new MyUtil();
	
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
    
    @GetMapping("article")
    public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	// 글보기
        String page = req.getParameter("page");
        String query = "page=" + page;
        
        try {
            long inquiryId = Long.parseLong(req.getParameter("inquiryId")); 
            
        // 게시물 가져오기
        InquiryDTO dto = service.findById(inquiryId);
        if (dto == null) { // 게시물이 없으면 다시 리스트로
            return new ModelAndView("redirect:/customer/inquiry/list?" + query);
        }
        
        dto.setContent(util.htmlSymbols(dto.getContent()));
        
        // 이전글 다음글
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("num", inquiryId);
        map.put("inquiryId", inquiryId);
        map.put("memberId", info.getMemberId());
        
        InquiryDTO prevDto = service.findByPrev(map);
        InquiryDTO nextDto = service.findByNext(map);
        
        ModelAndView mav = new ModelAndView("customer/inquiry/article");
        
        // JSP로 전달할 속성
        mav.addObject("dto", dto);
        mav.addObject("page", page);
        mav.addObject("query", query);
        mav.addObject("prevDto", prevDto);
        mav.addObject("nextDto", nextDto);
        
        // 포워딩
        return mav;
        
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    return new ModelAndView("redirect:/customer/inquiry/list?" + query);
    	
    	
    }
    
    @GetMapping("update")
    public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 수정 폼
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        String page = req.getParameter("page");
        try {
            long inquiryId = Long.parseLong(req.getParameter("inquiryId"));
            InquiryDTO dto = service.findById(inquiryId);
            if (dto == null) {
                return new ModelAndView("redirect:/customer/inquiry/list?page=" + page);
            }
            
            // 게시물을 올린 사용자가 아니면
            if (dto.getMemberId() != info.getMemberId()) {
                return new ModelAndView("redirect:/customer/inquiry/list?page=" + page);
            }
            
            ModelAndView mav = new ModelAndView("customer/inquiry/write");

            mav.addObject("dto", dto);
            mav.addObject("page", page);
            mav.addObject("mode", "update");
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/customer/inquiry/list?page=" + page);
    }

    @PostMapping("update")
    public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 수정 완료
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        String page = req.getParameter("page");
        try {
            InquiryDTO dto = new InquiryDTO();

            dto.setInquiryId(Long.parseLong(req.getParameter("inquiryId")));
            dto.setInquiryType(req.getParameter("inquiryType"));
            dto.setTitle(req.getParameter("title"));
            dto.setContent(req.getParameter("content"));
            dto.setMemberId(info.getMemberId());

            service.updateInquiry(dto);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/customer/inquiry/list?page=" + page);
    }
    
    @GetMapping("delete")
    public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 삭제
    	HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        String page = req.getParameter("page");
        String query = "page=" + page;

        try {
            long inquiryId = Long.parseLong(req.getParameter("inquiryId"));

            Map<String, Object> map = new HashMap<>();
            map.put("inquiryId", inquiryId);
            map.put("memberId", info.getMemberId());
            map.put("getRole", info.getRole());

            service.deleteInquiry(map);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("redirect:/customer/inquiry/list?" + query);
    }
}
