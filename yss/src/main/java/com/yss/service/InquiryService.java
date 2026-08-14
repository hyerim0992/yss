package com.yss.service;

import java.util.List;
import java.util.Map;

import com.yss.dto.InquiryDTO;

public interface InquiryService {
	public void insertInquiry(InquiryDTO dto) throws Exception;
	public void updateInquiry(InquiryDTO dto) throws Exception;
	public void deleteInquiry(Map<String, Object> map);
	
	public int dataCount(Map<String, Object> map);	
	public List<InquiryDTO> listInquiry(Map<String, Object> map);
		
}
