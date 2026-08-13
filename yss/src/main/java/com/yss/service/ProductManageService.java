package com.yss.service;

import com.yss.dto.ProductDTO;

public interface ProductManageService {
	public void insertProduct(ProductDTO dto) throws Exception;
	
	public void insertProductImage(ProductDTO dto) throws Exception;
	
	
}
