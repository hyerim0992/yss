package com.yss.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.annotation.ResponseBody;
import com.yss.dto.ProductDTO;
import com.yss.dto.SessionInfo;
import com.yss.dto.wishListDTO;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.ProductDetailService;
import com.yss.service.ProductDetailServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/product/detail/*")
public class ProductDetailController {
	private ProductDetailService service = new ProductDetailServiceImpl();
	
    @GetMapping("")
    public ModelAndView productDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	ModelAndView mav = new ModelAndView("product/detail");
    	//상세 페이지
    	// 파라미터 : category, prodNum
    	HttpSession session = req.getSession();
    	SessionInfo info = (SessionInfo)session.getAttribute("member"); //null이면 비로그인 상태로 보는거
    	String page = req.getParameter("page");
    	String query = "page=" + page;
    	
    	try {
    		//long num = Long.parseLong(req.getParameter("num"));
    		
    		//쿼리 어떻게 넘어올지 모르겠어서 일단 생략... 상품넘버는 보내주겠지
    		
    		ProductDTO dto = service.productDetails(2L); // 나중에 쿼리로 들어오는 num 넣기
    		List<ProductDTO> imgList = service.productImages(2L);
    		List<ProductDTO> optionList = service.productOptions(2L);
    		int wishlistCount = service.selectWishlist(2L);
    		
    		if(dto==null||imgList.isEmpty()||optionList.isEmpty()) {
    			return new ModelAndView("redirect:/product/"); //상품 리스트 페이지로 돌아가기
    		}
    		
    		List<String> uniqueColors = optionList.stream()
    			    .map(ProductDTO::getColor)
    			    .distinct()
    			    .collect(Collectors.toList());
    		
    		List<Integer> uniqueSizes = optionList.stream()
    				.map(ProductDTO::getProdSize)
    				.distinct()
    				.collect(Collectors.toList());
    		
    		mav.addObject("dto", dto);
    		mav.addObject("imgList", imgList);
    		mav.addObject("optionList", optionList);
    		mav.addObject("uniqueColors", uniqueColors);
    		mav.addObject("uniqueSizes", uniqueSizes);
    		mav.addObject("wishlistCount", wishlistCount);
    		
    		return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return new ModelAndView("redirect:/product/"); //상품 리스트 페이지로 돌아가기
    }
    
    @GetMapping("information")
    public ModelAndView informationForm(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/information");
    }
    
    @GetMapping("review")
    public ModelAndView reviewForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	return new ModelAndView("product/detail/review");
    }
    
    //AJAX //리뷰 작성
    @ResponseBody
    @PostMapping("review")
    public ModelAndView reviewSubmit(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/review");
    }
    
    
    @GetMapping("qna")
    public ModelAndView qnaForm(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/qna");
    }

    //AJAX //qna 작성
    @ResponseBody
    @PostMapping("qna")
    public ModelAndView qnaSubmit(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/qna");
    }

    //AJAX
    @ResponseBody
    @PostMapping("wishlist")
    public ModelAndView bookmarkSubmit(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/wishlist");
    }
    
    //AJAX
    @ResponseBody
    @PostMapping("share")
    public ModelAndView shareSubmit(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	return new ModelAndView("product/detail/share");
    }
    
    //AJAX
    @ResponseBody
    @GetMapping("size")
	public Map<String, Object> SizeList(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		String color = req.getParameter("color");
		long prodId = Long.parseLong(req.getParameter("prodId"));
		List<ProductDTO> list = null;
		
		try {
			list = service.productOptions(prodId);
			
			List<Integer> Sizes = list.stream()
					.filter(item -> color.equalsIgnoreCase(item.getColor()))
    				.map(ProductDTO::getProdSize)
    				.distinct()
    				.collect(Collectors.toList());
			
			model.put("sizes", Sizes);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(model);
		return model;
    }
    
    
}
