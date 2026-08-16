package com.yss.service;


import java.util.List;
import java.util.Map;

import com.yss.dto.ProductDTO;

public interface ProductManageService {
	
	public List<ProductDTO> listProductManage(Map<String, Object> map) throws Exception;
	public void insertProduct(ProductDTO dto) throws Exception;
	
	
	
	
}
