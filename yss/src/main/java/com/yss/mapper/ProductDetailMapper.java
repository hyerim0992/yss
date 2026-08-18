package com.yss.mapper;

import java.util.List;
import java.util.Map;

import com.yss.dto.ProductDTO;
import com.yss.dto.wishListDTO;

public interface ProductDetailMapper {
	public ProductDTO selectProductDetail(long num);
	public List<ProductDTO> selectProductOption(long num);
	public List<ProductDTO> selectProductImage(long num);
	public List<ProductDTO> productRecommend(long num);
	public int selectWishlist (long num);
	public void updateWishList (Map<String, Object> map);
	public void deleteWishlist (Map<String, Object> map);
}
