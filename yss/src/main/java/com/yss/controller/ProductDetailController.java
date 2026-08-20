package com.yss.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.annotation.ResponseBody;
import com.yss.dto.OrderItemDTO;
import com.yss.dto.ProductDTO;
import com.yss.dto.ReviewDTO;
import com.yss.dto.ReviewImageDTO;
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
    		
    		ProductDTO dto = service.productDetails(1L); // 나중에 쿼리로 들어오는 num 넣기
    		List<ProductDTO> imgList = service.productImages(1L);
    		List<ProductDTO> optionList = service.productOptions(1L);
    		int wishlistCount = service.selectWishlist(1L);
    		
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
    @ResponseBody
    public Map<String, Object> reviewList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	//넘어오는 파라미터 : prodId
    	Map<String, Object> model = new HashMap<String, Object>();
    	
		long prodId = Long.parseLong(req.getParameter("prodId"));
		
		try {
			List<ReviewDTO> reviewList = service.reviewWithDetailsList(1L); //prodId 넣기
			
			model.put("reviews", reviewList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(model);
		return model;
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
    public Map<String, String> wishlistToggle(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
    	long prodId = Long.parseLong(req.getParameter("prodId"));
    	boolean interestActive = Boolean.parseBoolean(req.getParameter("interestActive"));
    	HttpSession session = req.getSession();
    	SessionInfo info = (SessionInfo)session.getAttribute("member"); //null이면 비로그인 상태로 보는거
    	
    	Map<String, String> model = new HashMap<String, String>();
    	
    	System.out.println(info);
    	
    	if (info == null) {
    		model.put("return", "null");
    		return model;
    	}
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("productId", prodId);
    	map.put("memberId", info.getMemberId());
    	
    	
    	if (interestActive) {
    		try {
    			service.insertWishlist(map);
    			int wishlistCount = service.selectWishlist(prodId);
    			model.put("return", "true");
        		return model;
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}else {
    		try {
				service.deleteWishlist(map);
				model.put("return", "false");
				return model;
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}
    	
    	
    	model.put("return", "false");
		return model;
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
			
			List<ProductDTO> OptionList = list.stream()
					.filter(item -> color.equalsIgnoreCase(item.getColor()))
    				.collect(Collectors.toList());
			
			model.put("OptionList", OptionList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(model);
		return model;
    }
    
    
}
