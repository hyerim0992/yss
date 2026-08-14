package com.yss.mapper;

import java.util.List;
import java.util.Map;

import com.yss.dto.ProductDTO;

public interface ProductDetailMapper {
	List<ProductDTO> selectProductDetail(long num);
}
