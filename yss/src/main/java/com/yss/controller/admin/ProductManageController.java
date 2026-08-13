package com.yss.controller.admin;

import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.ProductManageService;
import com.yss.service.ProductManageServiceImpl;
import com.yss.util.FileManager;

@Controller
@RequestMapping("admin/product/*")
public class ProductManageController {
	private ProductManageService service = new ProductManageServiceImpl();
	private FileManager fileManager = new FileManager();
	

}
