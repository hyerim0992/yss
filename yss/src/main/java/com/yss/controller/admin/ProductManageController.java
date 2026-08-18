package com.yss.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yss.dto.ProductDTO;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.ProductManageService;
import com.yss.service.ProductManageServiceImpl;
import com.yss.util.FileManager;
import com.yss.util.MyMultipartFile;
import com.yss.util.MyUtil;
import com.yss.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/admin/product/*")
public class ProductManageController {
	private ProductManageService service = new ProductManageServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();
	private FileManager fileManager = new FileManager();


	@GetMapping("")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 상품리스트
		ModelAndView mav = new ModelAndView("admin/product/main");

		try {
			Map<String, Object> map = new HashMap<String, Object>();
			
			int page = 1;
			int totalCount = 0;
			int totalPage = 0;
			
			String pageNo = req.getParameter("page");
			if(pageNo != null && ! pageNo.isBlank()) {
				page = Integer.parseInt(pageNo);
			}
			
			int size = 10;
			int offset = (page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("size", size);
			map.put("offset", offset);
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			String dateFrom = req.getParameter("dateFrom");
			String dateTo = req.getParameter("dateTo");
			String minGrade = req.getParameter("minGrade");
			String status = req.getParameter("status");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			
			kwd = util.decodeUrl(kwd);
			
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("dateFrom", dateFrom);
			map.put("dateTo", dateTo);
			map.put("minGrade", minGrade);
			map.put("status", status);

			
			totalCount = service.countProductManage(map);
			totalPage = paginateUtil.pageCount(totalCount, size);
			page = Math.min(page, totalPage);
			
			List<ProductDTO> list = service.listProductManage(map);
			
			// 페이징
			String query;
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/product";
			if(! kwd.isBlank()) {
				query = "schType=" + schType + "kwd=" + util.encodeUrl(kwd);
				listUrl += "?" + query; 
			}
			
			
			String paging = paginateUtil.paging(page, totalPage, listUrl);
			
			
					
			mav.addObject("list", list);
			mav.addObject("page", page);
			mav.addObject("totalPage", totalPage);
			mav.addObject("totalCount", totalCount);
			mav.addObject("size", size);
			mav.addObject("paging", paging);
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav; 
	}
	
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("/write");
	}
	
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 상품 저장
		
		
		
		try {
			ProductDTO dto = new ProductDTO();
			
			dto.setProdName(req.getParameter("prodName"));
			dto.setBrand(req.getParameter("brand"));
			dto.setCategoryId(Long.parseLong(req.getParameter("categoryId")));
			dto.setInboundPrice(Integer.parseInt(req.getParameter("inboundPrice")));
			dto.setPrice(Integer.parseInt(req.getParameter("price")));
			dto.setMinGrade(Integer.parseInt(req.getParameter("minGrade")));
			dto.setStatus(req.getParameter("status"));
			dto.setRegDate(req.getParameter("regDate"));
			dto.setHeelHeight(req.getParameter("heelHeight") == null ||req.getParameter("heelHeight").isBlank() 
					? 0 : Integer.parseInt(req.getParameter("heelHeight")));
			dto.setDiscRate(req.getParameter("discRate") == null ||req.getParameter("discRate").isBlank() 
					? 0 : Integer.parseInt(req.getParameter("discRate")));
			dto.setThumbnail(req.getParameter("thumbnail"));
			
			HttpSession session = req.getSession();
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator +"product";
			
			dto.setImageId(Long.parseLong(req.getParameter("imageId")));
			dto.setFiles(req.getParameter("files"));
			dto.setSortOrder(Integer.parseInt(req.getParameter("sortOrder")));
			
			List<MyMultipartFile> listFiles = fileManager.doFileUpload(req.getParts(), pathname);
			dto.setListFile(listFiles);
		

			service.insertProduct(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/admin/product");
	}
	

}
