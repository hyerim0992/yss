package com.yss.service;

import java.util.List;
import java.util.Map;

import com.yss.dto.ProductDTO;
import com.yss.mapper.ProductDetailMapper;
import com.yss.mybatis.support.MapperContainer;

public class ProductDetailServiceImpl implements ProductDetailService{
	private ProductDetailMapper mapper = MapperContainer.get(ProductDetailMapper.class);
	@Override
	public List<ProductDTO> productDetails(long prodNum) throws Exception {
		List<ProductDTO> list = null;
		
		try {
			list = mapper.selectProductDetail(prodNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
}
