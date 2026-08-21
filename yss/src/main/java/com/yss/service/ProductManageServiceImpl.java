package com.yss.service;


import java.util.List;
import java.util.Map;

import com.yss.dto.ProductDTO;
import com.yss.mapper.ProductManageMapper;
import com.yss.mybatis.support.MapperContainer;
import com.yss.util.MyMultipartFile;

public class ProductManageServiceImpl implements ProductManageService {
	private ProductManageMapper mapper = MapperContainer.get(ProductManageMapper.class);
	

	@Override
	public void insertProduct(ProductDTO dto) throws Exception {
		try {
			mapper.insertProduct(dto);
			
			if(dto.getListFile().size() != 0) {
				for(MyMultipartFile mf : dto.getListFile()) {
					dto.setFiles(mf.getSaveFilename());	
					mapper.insertProductImage(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public List<ProductDTO> listProductManage(Map<String, Object> map) throws Exception {
		
		return mapper.listProductManage(map);
	}


	@Override
	public int countProductManage(Map<String, Object> map) {
		int result = mapper.countProductManage(map);
		return result;
	}

	@Override
	public List<ProductDTO> listParentCategory() throws Exception {
		
		return mapper.listParentCategory();
	}

	@Override
	public List<ProductDTO> listChildCategory() throws Exception {
		
		return mapper.listChildCategory();
	}


	@Override
	public ProductDTO findById(long num) {
		ProductDTO dto = mapper.findById(num);
		return dto;
	}



}
