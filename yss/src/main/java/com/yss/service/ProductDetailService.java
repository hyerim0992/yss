package com.yss.service;

import java.util.List;
import java.util.Map;

import com.yss.dto.OrderItemDTO;
import com.yss.dto.ProductDTO;
import com.yss.dto.ReviewDTO;
import com.yss.dto.ReviewImageDTO;
import com.yss.dto.wishListDTO;

public interface ProductDetailService {
	public ProductDTO productDetails(long prodNum) throws Exception;
	public List<ProductDTO> productOptions(long prodNum) throws Exception;
	public List<ProductDTO> productImages(long prodNum) throws Exception;
	public List<ProductDTO> productRecommend(long prodNum) throws Exception;
	public int selectWishlist(long num) throws Exception;
	public void updateWishlist(Map<String, Object> map) throws Exception;
	public void deleteWishlist(Map<String, Object> map) throws Exception;
	public List<ReviewDTO> reviewList(long num) throws Exception;
	public List<ReviewImageDTO> ReviewImageList(long num);
	public List<ProductDTO> OrderItemOptionList(long num);
	public String OrderMemberName (long num);
}
