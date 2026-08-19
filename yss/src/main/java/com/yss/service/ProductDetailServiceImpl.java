package com.yss.service;

import java.util.List;
import java.util.Map;

import com.yss.dto.OrderItemDTO;
import com.yss.dto.ProductDTO;
import com.yss.dto.ReviewDTO;
import com.yss.dto.ReviewImageDTO;
import com.yss.dto.wishListDTO;
import com.yss.mapper.ProductDetailMapper;
import com.yss.mybatis.support.MapperContainer;

public class ProductDetailServiceImpl implements ProductDetailService{
	private ProductDetailMapper mapper = MapperContainer.get(ProductDetailMapper.class);
	@Override
	public ProductDTO productDetails(long prodNum) throws Exception {
		ProductDTO dto = null;
		
		try {
			dto = mapper.selectProductDetail(prodNum);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
		return dto;
	}
	@Override
	public List<ProductDTO> productOptions(long prodNum) throws Exception {
		List<ProductDTO> list = null;
		
		try {
			list = mapper.selectProductOption(prodNum);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		return list;
	}
	@Override
	public List<ProductDTO> productImages(long prodNum) throws Exception {
		List<ProductDTO> list = null;
		
		try {
			list = mapper.selectProductImage(prodNum);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		return list;
	}
	@Override
	public List<ProductDTO> productRecommend(long prodNum) throws Exception {
		List<ProductDTO> list = null;
		
		try {
			list = mapper.productRecommend(prodNum);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		return list;
	}
	@Override
	public int selectWishlist(long num) throws Exception {
		int count = 0;
		
		try {
			 count = mapper.selectWishlist(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	@Override
	public void updateWishlist(Map<String, Object> map) throws Exception {
		try {
			mapper.updateWishList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@Override
	public void deleteWishlist(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteWishlist(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@Override
	public List<ReviewDTO> reviewList(long num) throws Exception {
		List<ReviewDTO> list = null;
		
		try {
			list = mapper.selectReview(num);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	@Override
	public List<ReviewImageDTO> ReviewImageList(long num) {
		List<ReviewImageDTO> list = null;
		try {
			list = mapper.selectReviewImage(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List<ProductDTO> OrderItemOptionList(long num) {
		List<ProductDTO> list = null;
		try {
			list = mapper.selectOrderItemOption(num);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	@Override
	public String OrderMemberName(long num) {
		String name = "";
		try {
			name = mapper.selectOrderMemberName(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return name;
	}
	
}
