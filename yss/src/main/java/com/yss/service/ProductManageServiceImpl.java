package com.yss.service;

import java.util.List;

import com.yss.dto.ProductDTO;
import com.yss.mapper.ProductManageMapper;
import com.yss.mybatis.support.MapperContainer;

public class ProductManageServiceImpl implements ProductManageService {
	private ProductManageMapper mapper = MapperContainer.get(ProductManageMapper.class);
	

	@Override
	public void insertProduct(ProductDTO dto, List<String> imageList) throws Exception {
		try {
			mapper.insertProduct(dto);
			
			if(imageList != null) {
				for(int i = 0; i < imageList.size(); i++) {
					ProductDTO imgDto = new ProductDTO();
					
					imgDto.setProductId(dto.getProductId());
					imgDto.setFiles(imageList.get(i));
					imgDto.setSortOrder(i);
					
					mapper.insertProductImage(imgDto);	
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}


}
