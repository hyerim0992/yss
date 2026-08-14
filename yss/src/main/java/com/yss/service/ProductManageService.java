package com.yss.service;

import java.util.List;

import com.yss.dto.ProductDTO;

public interface ProductManageService {
	public void insertProduct(ProductDTO dto, List<String> imageList) throws Exception;
	
	
	
}
