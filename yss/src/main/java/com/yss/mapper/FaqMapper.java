package com.yss.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.yss.dto.FaqDTO;

public interface FaqMapper {
	
	// FAQ 등록
	public void insertFaq(FaqDTO dto) throws SQLException;
	
	// FAQ 목록
	public List<FaqDTO> listFaq();
	
	// FAQ 한 개 조회
	public FaqDTO findById(Long faqId);
	
	// FAQ 수정
	public void updateFaq(FaqDTO dto) throws SQLException;
	
	// FAQ 삭제
	public void deleteFaq(Long faqId) throws SQLException;

	// 관리자 FAQ 검색
	public List<FaqDTO> listFaqAdmin(Map<String, Object> map);
	public int dataCountFaqAdmin(Map<String, Object> map);
}
