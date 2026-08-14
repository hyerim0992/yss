package com.yss.service;

import java.util.List;

import com.yss.dto.ProductDTO;

public interface ProductDetailService {
	public List<ProductDTO> productDetails(long prodNum) throws Exception;
}
