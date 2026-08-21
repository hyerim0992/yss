package com.yss.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yss.dto.SessionInfo;
import com.yss.dto.wishListDTO;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.annotation.ResponseBody;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.WishlistService;
import com.yss.service.WishlistServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage/*")
public class WishlistController {

    private WishlistService service = new WishlistServiceImpl();

    // 위시리스트 목록 화면 요청
    @GetMapping("main")
    public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView mav = new ModelAndView("mypage/mypage");
        
        return mav;
    }

    @GetMapping("wishlist")
    public ModelAndView wishlist(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView mav = new ModelAndView("mypage/wishlist");
        
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            return new ModelAndView("redirect:/member/login");
        }
        
        List<wishListDTO> list = service.listWishlist(info.getMemberId());
        
        System.out.println("============================================");
        System.out.println("로그인 회원 ID: " + info.getMemberId());
        System.out.println("조회된 위시리스트 개수: " + (list != null ? list.size() : "null"));
        System.out.println("============================================");
        
        int totalCount = service.getWishlistCount(info.getMemberId());
        
        mav.addObject("list", list);
        mav.addObject("totalCount", totalCount);
        
        return mav;
    }
    
    @GetMapping("cart")
    public ModelAndView cart(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView mav = new ModelAndView("mypage/cart");
        
        return mav;
    }
    
    // 단일 항목 삭제
    @PostMapping("wishlist/delete")
    public ModelAndView deleteWishlist(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            return new ModelAndView("redirect:/member/login");
        }
        
        Long wishListId = Long.parseLong(req.getParameter("wishListId"));
        service.removeWishlist(wishListId, info.getMemberId());
        
        return new ModelAndView("redirect:/mypage/wishlist");
    }

    // 선택 항목 다중 삭제
    @PostMapping("wishlist/deleteList")
    public ModelAndView deleteWishlistList(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            return new ModelAndView("redirect:/member/login");
        }
        
        String[] wishListIdsArr = req.getParameterValues("wishListIds");
        if (wishListIdsArr != null && wishListIdsArr.length > 0) {
            List<Long> wishListIds = new ArrayList<>();
            for (String idStr : wishListIdsArr) {
                wishListIds.add(Long.parseLong(idStr));
            }
            service.removeWishlistList(wishListIds, info.getMemberId());
        }
        
        return new ModelAndView("redirect:/mypage/wishlist");
    }

    // 위시리스트 전체 삭제
    @PostMapping("wishlist/clear")
    public ModelAndView clearWishlist(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            return new ModelAndView("redirect:/member/login");
        }
        
        service.clearWishlist(info.getMemberId());
        
        return new ModelAndView("redirect:/mypage/wishlist");
    }

    // 상품 찜하기 추가
    @ResponseBody
    @PostMapping("wishlist/add")
    public Map<String, Object> addWishlist(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Map<String, Object> model = new HashMap<>();
        
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            model.put("state", "loginRequired");
            return model;
        }
        
        Long productId = Long.parseLong(req.getParameter("productId"));
        
        // 중복 찜 확인 후 추가
        String isWished = service.isWished(info.getMemberId(), productId);
        if ("Y".equals(isWished)) {
            model.put("state", "alreadyExists");
        } else {
            service.addWishlist(info.getMemberId(), productId);
            model.put("state", "success");
        }
        
        return model;
    }
}