package com.yss.service;

import java.util.List;

import com.yss.dto.FaqDTO;

public interface FaqService {
	
	public void insertFaq(FaqDTO dto);
	
	public List<FaqDTO> listFaq();
	
	public FaqDTO findById(Long faqId);
	
	public void updateFaq(FaqDTO dto);
	
	public void deleteFaq(Long faqId);
}