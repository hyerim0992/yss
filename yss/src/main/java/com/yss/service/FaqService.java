package com.yss.service;

import java.util.List;
import java.util.Map;

import com.yss.dto.FaqDTO;

public interface FaqService {
	
	public void insertFaq(FaqDTO dto);
	
	public List<FaqDTO> listFaq();
	
	public FaqDTO findById(Long faqId);
	
	public void updateFaq(FaqDTO dto);
	
	public void deleteFaq(Long faqId);

	// 관리자 FAQ 검색
	public List<FaqDTO> listFaqAdmin(Map<String, Object> map);
	public int dataCountFaqAdmin(Map<String, Object> map);
}
