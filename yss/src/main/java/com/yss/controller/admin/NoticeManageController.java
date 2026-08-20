package com.yss.controller.admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yss.dto.NoticeDTO;
import com.yss.dto.SessionInfo;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.NoticeService;
import com.yss.service.NoticeServiceImpl;
import com.yss.util.FileManager;
import com.yss.util.MyMultipartFile;
import com.yss.util.MyUtil;
import com.yss.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/support/notice/*")
public class NoticeManageController {
	private NoticeService service = new NoticeServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();
	private FileManager fileManager = new FileManager();
	
    @GetMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	ModelAndView mav = new ModelAndView("admin/support/notice/list");
    	
    	try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null && !page.isBlank()) {
				current_page = Integer.parseInt(page);
			}
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
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
			listUrl = cp + "/admin/support/notice/list?" + query;
			articleUrl = cp + "/admin/support/notice/article?page=" + current_page + "&" + query;
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			mav.addObject("list", list);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
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
    public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String page = req.getParameter("page");
    	String size = req.getParameter("size");
    	String query = "page=" + page + "&size=" + size;
    	
    	try {
			long noticeId = Long.parseLong(req.getParameter("noticeId"));
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			NoticeDTO dto = service.findById(noticeId);
			if(dto == null) {
				return new ModelAndView("redirect:/admin/support/notice/list?" + query);
			}
			
			// 파일
			List<NoticeDTO> listFile = service.listNoticeFile(noticeId);
						
			ModelAndView mav = new ModelAndView("admin/support/notice/article");
			
			mav.addObject("dto", dto);
			mav.addObject("query", query);
			mav.addObject("listFile", listFile);
			mav.addObject("page", page);
			mav.addObject("size", size);
			
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return new ModelAndView("redirect:/admin/support/notice/list" + query);
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
    	
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
    	try {
			NoticeDTO dto = new NoticeDTO();
			
			dto.setMemberId(info.getMemberId());
			
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			
			// 파일 업로드
			List<MyMultipartFile> listFile = fileManager.doFileUpload(req.getParts(), pathname);
			dto.setListFile(listFile);
			
			service.insertNotice(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return new ModelAndView("redirect:/admin/support/notice/list");
    }
    
    @GetMapping("update")
    public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	String page = req.getParameter("page");
    	try {
			long noticeId = Long.parseLong(req.getParameter("noticeId"));
			NoticeDTO dto = service.findById(noticeId);
			
			if(dto == null) {
				return new ModelAndView("redirect:/admin/support/notice/list?page=" + page);
			}
			
			List<NoticeDTO> listFile = service.listNoticeFile(noticeId);
			
			ModelAndView mav = new ModelAndView("admin/support/notice/write");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("listFile", listFile);
			mav.addObject("mode", "update");
			
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return new ModelAndView("redirect:/admin/support/notice/list?page=" + page);
    }
    
    @PostMapping("update")
    public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
    	String page = req.getParameter("page");
    	try {
    		NoticeDTO dto = new NoticeDTO();
    		
    		dto.setNoticeId(Long.parseLong(req.getParameter("noticeId")));
    		dto.setTitle(req.getParameter("title"));
    		dto.setContent(req.getParameter("content"));
    		
			List<MyMultipartFile> listFile = fileManager.doFileUpload(req.getParts(), pathname);
			dto.setListFile(listFile);
			
    		service.updateNotice(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return new ModelAndView("redirect:/admin/support/notice/list?page=" + page);
    }
    
	@GetMapping("deleteFile")
	public ModelAndView deleteFile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정에서 파일만 삭제
		// 넘어온 파라미터 : 글번호, 파일번호, 페이지번호, size
		HttpSession session = req.getSession();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";

		String page = req.getParameter("page");

		try {
			long noticeId = Long.parseLong(req.getParameter("noticeId"));
			long fileId = Long.parseLong(req.getParameter("fileId"));
			NoticeDTO dto = service.findByFileId(fileId);
			if (dto != null) {
				// 파일삭제
				fileManager.doFiledelete(pathname, dto.getServerFiles());
				
				// 테이블 파일 정보 삭제
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("field", "fileId");
				map.put("noticeId", fileId);
				
				service.deleteNoticeFile(map);
			}

			// 다시 수정 화면으로
			return new ModelAndView("redirect:/admin/support/notice/update?noticeId=" + noticeId + "&page=" + page);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/support/notice/list?page=" + page);
	}
	
    @GetMapping("delete")
    public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
    	String page = req.getParameter("page");
    	String size = req.getParameter("size");
    	String query = "page=" + page + "&size=" + size;
    	try {
    		long noticeId = Long.parseLong(req.getParameter("noticeId"));
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			// 실제 파일 삭제
			List<NoticeDTO> listFile = service.listNoticeFile(noticeId);
			for (NoticeDTO vo : listFile) {
				fileManager.doFiledelete(pathname, vo.getServerFiles());
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "noticeId");
			map.put("noticeId", noticeId);
			
			// 파일 정보 삭제
			service.deleteNoticeFile(map);
			
			// 기시글 삭제
			service.deleteNotice(noticeId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return new ModelAndView("redirect:/admin/support/notice/list?" + query);
    }
    
    @PostMapping("deleteList")
    public ModelAndView deleteList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	HttpSession session = req.getSession();
    	
    	String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "size=" + size + "&page=" + page;
		
		try {
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			if (! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			String[] nn = req.getParameterValues("nums");
			List<Long> nums = new ArrayList<Long>();
			for (int i = 0; i < nn.length; i++) {
				nums.add(Long.parseLong(nn[i]));
			}

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "noticeId");
			for (Long n : nums) {
				List<NoticeDTO> listFile = service.listNoticeFile(n);
				
				for (NoticeDTO vo : listFile) {
					fileManager.doFiledelete(pathname, vo.getServerFiles());
				}
				
				map.put("noticeId", n);
				
				service.deleteNoticeFile(map);
			}

			service.deleteListNotice(nums);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/support/notice/list?" + query);
    }
   
    
}
