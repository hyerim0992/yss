package com.yss.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yss.dto.NoticeDTO;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.NoticeService;
import com.yss.service.NoticeServiceImpl;
import com.yss.util.MyUtil;
import com.yss.util.PaginateUtil;
import com.yss.util.FileManager;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/customer/notice/*")
public class NoticeController {
		private NoticeService service = new NoticeServiceImpl();
		private MyUtil util = new MyUtil();
		private PaginateUtil paginateUtil = new PaginateUtil();
		private FileManager fileManager = new FileManager();
	
    @GetMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	ModelAndView mav = new ModelAndView("customer/notice/list");
    	
    	try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			String pageSize = req.getParameter("size");
			int size = pageSize == null ? 7 : Integer.parseInt(pageSize);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			int dataCount = service.dataCount(map);
			int total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<NoticeDTO> list = service.listNotice(map);
			
			String cp = req.getContextPath();
			String query = "size=" + size;
			String listUrl;
			String articleUrl;
			
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			listUrl = cp + "/customer/notice/list?" + query;
			articleUrl = cp + "/customer/notice/article?page=" + current_page + "&" + query;
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			mav.addObject("list", list);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("current_page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
        return mav;
    }
    
    @GetMapping("article")
    public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws SecurityException, IOException {
    	String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "page=" + page + "&size=" + size; 
		
		try {
			long noticeId = Long.parseLong(req.getParameter("noticeId"));
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if ( schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}

			NoticeDTO dto = service.findById(noticeId);
			if (dto == null) {
				return new ModelAndView("redirect:/customer/notice/list?" + query);
			}
			
			List<NoticeDTO> listFile = service.listNoticeFile(noticeId);
			
			ModelAndView mav = new ModelAndView("customer/notice/article");
			
			mav.addObject("dto", dto);
			mav.addObject("listFile", listFile);
			mav.addObject("query", query);
			mav.addObject("page", page);
			mav.addObject("size", size);
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
    	return new ModelAndView("redirect:/customer/notice/list?" + query);
    }
    
    @GetMapping("download")
    public void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	
    	String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
		boolean b = false;
		
		try {
			long fileId = Long.parseLong(req.getParameter("fileId"));
			
			NoticeDTO dto = service.findByFileId(fileId);
			if(dto != null) {
				b = fileManager.doFiledownload(dto.getServerFiles(), dto.getFiles(), pathname, resp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(!b) {
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('파일다운로드가 실패 했습니다.'); history.back();</script>");
		}
    }
    

    
}
