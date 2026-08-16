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
			
			String pageNo = req.getParameter("page");
			if(pageNo != null && ! pageNo.isBlank()) {
				page = Integer.parseInt(pageNo);
			}
			
			int size = 10;
			int offset = (page - 1) * size;
			
			map.put("size", size);
			map.put("offset", offset);
			
			List<ProductDTO> list = service.listProductManage(map);
			
			System.out.println("list = " + list);
			System.out.println("list size = " + list.size());
			
			
			mav.addObject("list", list);
			mav.addObject("page", page);
			

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
		
		return new ModelAndView("redirect:/admin/product/list");
	}
	

}
