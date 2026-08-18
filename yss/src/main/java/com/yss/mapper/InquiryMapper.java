package com.yss.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.yss.dto.InquiryDTO;

public interface InquiryMapper {
	public void insertInquiry(InquiryDTO dto) throws SQLException;
	public void updateInquiry(InquiryDTO dto) throws SQLException;
	public void deleteInquiry(Map<String, Object> map) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<InquiryDTO> listInquiry(Map<String, Object> map);
	public InquiryDTO findById(long inquiryId);
	public InquiryDTO findByPrev(Map<String, Object> map);
	public InquiryDTO findByNext(Map<String, Object> map);

}