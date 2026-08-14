package com.yss.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.yss.dto.ProductDTO;

public interface ProductManageMapper {
	public void insertProduct(ProductDTO dto) throws SQLException;
	public void updateProduct(ProductDTO dto) throws SQLException;
	public void deleteProduct(ProductDTO dto) throws SQLException;
	public List<ProductDTO> listProduct(Map<String, Object> map);
	public List<ProductDTO> selectGradeProduct(Map<String, Object> map);
	public List<ProductDTO> listCategory(Map<String, Object> map);
	
	public void insertProductOption(ProductDTO dto) throws SQLException;
	public void updateProductOption(ProductDTO dto) throws SQLException;
	public void deleteProductOption(ProductDTO dto) throws SQLException;
	public List<ProductDTO> listProductOption(Map<String, Object> map);
	
	public void insertProductImage(ProductDTO dto) throws SQLException;
	
	
		
	
}
