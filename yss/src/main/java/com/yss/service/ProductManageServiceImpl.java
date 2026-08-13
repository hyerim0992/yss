package com.yss.service;

import com.yss.dto.ProductDTO;
import com.yss.mapper.ProductManageMapper;
import com.yss.mybatis.support.MapperContainer;

public class ProductManageServiceImpl implements ProductManageService {
	private ProductManageMapper mapper = MapperContainer.get(ProductManageMapper.class);
	

	@Override
	public void insertProduct(ProductDTO dto) throws Exception {
		try {
			mapper.insertProduct(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void insertProductImage(ProductDTO dto) throws Exception {
		try {
			mapper.insertProductImage(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

}
