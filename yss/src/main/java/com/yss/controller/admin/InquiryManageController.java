package com.yss.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yss.dto.InquiryAnswerDTO;
import com.yss.dto.InquiryDTO;
import com.yss.dto.SessionInfo;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.InquiryAnswerService;
import com.yss.service.InquiryAnswerServiceImpl;
import com.yss.service.InquiryService;
import com.yss.service.InquiryServiceImpl;
import com.yss.util.MyUtil;
import com.yss.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/support/inquiry/*")
public class InquiryManageController {
	private InquiryService service = new InquiryServiceImpl();
	private InquiryAnswerService answerService = new InquiryAnswerServiceImpl();
    private MyUtil util = new MyUtil();
    private PaginateUtil paginateUtil = new PaginateUtil();

    // 1:1 문의 목록
    @GetMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("admin/support/inquiry/list");

        try {
            String page = req.getParameter("page");
            int current_page = 1;
            if (page != null) {
                current_page = Integer.parseInt(page);
            }

            // 검색 및 상태 필터
            String schType = req.getParameter("schType");
            String kwd = req.getParameter("kwd");
            String status = req.getParameter("status");

            if (schType == null) {
                schType = "all";
                kwd = "";
            }
            if (status == null) {
                status = "all";
            }

            kwd = util.decodeUrl(kwd);

            int size = 10;
            int total_page = 0;
            int dataCount = 0;

            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            map.put("status", status);

            // 전체 데이터 개수
            dataCount = answerService.dataCount(map);

            total_page = paginateUtil.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);

            // 게시물 가져오기
            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;

            map.put("offset", offset);
            map.put("size", size);

            List<InquiryDTO> list = answerService.listInquiry(map);

            // 페이징 처리 및 URL 생성
            String query = "";
            String cp = req.getContextPath();
            String listUrl = cp + "/admin/support/inquiry/list";
            String writeUrl = cp + "/admin/support/inquiry/write?page=" + current_page;

            // 검색 조건 파라미터 구성
            if (!kwd.isBlank()) {
                query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
            }

            if (!status.equals("all")) {
                if (!query.isBlank()) {
                    query += "&status=" + status;
                } else {
                    query = "status=" + status;
                }
            }

            if (!query.isBlank()) {
                listUrl += "?" + query;
                writeUrl += "&" + query;
            }

            String paging = paginateUtil.paging(current_page, total_page, listUrl);

            // 포워딩할 JSP에 전달할 속성
            mav.addObject("list", list);
            mav.addObject("dataCount", dataCount);
            mav.addObject("size", size);
            mav.addObject("page", current_page);
            mav.addObject("total_page", total_page);
            mav.addObject("writeUrl", writeUrl);
            mav.addObject("paging", paging);
            mav.addObject("schType", schType);
            mav.addObject("kwd", kwd);
            mav.addObject("status", status);

        } catch (Exception e) {
            e.printStackTrace();
        }

        // JSP로 포워딩
        return mav;
    }
    
	 // 답변 작성/수정
    @GetMapping("write")
    public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("admin/support/inquiry/write");

        try {
            long inquiryId = Long.parseLong(req.getParameter("inquiryId"));
            String page = req.getParameter("page");

            // 고객 문의 원글 조회
            InquiryDTO inquiryDto = service.findById(inquiryId);
            if (inquiryDto != null && inquiryDto.getContent() != null) {
                inquiryDto.setContent(util.htmlSymbols(inquiryDto.getContent()));
            }

            // 기존 답변 조회
            InquiryAnswerDTO answerDto = answerService.findByAnswerId(inquiryId);
            String mode = (answerDto != null && answerDto.getContent() != null) ? "update" : "write";

            mav.addObject("inquiryDto", inquiryDto);
            mav.addObject("answerDto", answerDto);
            mav.addObject("inquiryId", inquiryId);
            mav.addObject("mode", mode);
            mav.addObject("page", page);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return mav;
    }
	
	    // 답변 저장/수정
	    @PostMapping("write")
	    public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	        HttpSession session = req.getSession();
	        SessionInfo info = (SessionInfo) session.getAttribute("member");
	
	        String page = req.getParameter("page");
	
	        try {
	            long inquiryId = Long.parseLong(req.getParameter("inquiryId"));
	            String content = req.getParameter("content");
	            String mode = req.getParameter("mode");
	
	            InquiryAnswerDTO dto = new InquiryAnswerDTO();
	            dto.setInquiryId(inquiryId);
	            dto.setContent(content);
	            dto.setAnswerer(info.getName());
	
	            if ("update".equals(mode)) {
	            	answerService.updateAnswer(dto);
	            } else {
	            	answerService.insertAnswer(dto);
	            }
	
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	
	        return new ModelAndView("redirect:/admin/support/inquiry/list?page=" + page);
	    }
	    
	    // 1:1 문의
	    @GetMapping("article")
	    public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	        String page = req.getParameter("page");
	        if (page == null || page.isBlank()) {
	            page = "1";
	        }
	        String query = "page=" + page;

	        try {
	            long inquiryId = Long.parseLong(req.getParameter("inquiryId"));
	            String schType = req.getParameter("schType");
	            String kwd = req.getParameter("kwd");
	            String status = req.getParameter("status");

	            if (schType == null) schType = "all";
	            if (status == null) status = "all";
	            
	            if (kwd == null) {
	                kwd = "";
	            }
	            
	            kwd = util.decodeUrl(kwd);

	            if (!kwd.isBlank()) {
	                query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
	            }
	            if (!status.equals("all")) {
	                query += "&status=" + status;
	            }

	            // 고객 문의 조회
	            InquiryDTO dto = service.findById(inquiryId);
	            if (dto == null) {
	                return new ModelAndView("redirect:/admin/support/inquiry/list?" + query);
	            }
	            if (dto.getContent() != null) {
	                dto.setContent(util.htmlSymbols(dto.getContent()));
	            }
	            
	            // 관리자 답변 조회
	            InquiryAnswerDTO answerDto = answerService.findByAnswerId(inquiryId);
	            if (answerDto != null && answerDto.getContent() != null) {
	                answerDto.setContent(util.htmlSymbols(answerDto.getContent()));
	            }

	            ModelAndView mav = new ModelAndView("admin/support/inquiry/article");
	            mav.addObject("dto", dto);
	            mav.addObject("answerDto", answerDto);
	            mav.addObject("page", page);
	            mav.addObject("query", query);
	            mav.addObject("inquiryId", inquiryId);

	            return mav;

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return new ModelAndView("redirect:/admin/support/inquiry/list?" + query);
	    }

}