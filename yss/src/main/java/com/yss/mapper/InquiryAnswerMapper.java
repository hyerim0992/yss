package com.yss.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.yss.dto.InquiryAnswerDTO;
import com.yss.dto.InquiryDTO;

public interface InquiryAnswerMapper {
	public void insertAnswer(InquiryAnswerDTO dto) throws SQLException;
	public void updateAnswer(InquiryAnswerDTO dto) throws SQLException;
	public void deleteAnswer(long answerId) throws SQLException;
	
	public int dataCount(Map<String, Object> map) throws SQLException;
	public List<InquiryDTO> listInquiry(Map<String, Object> map) throws SQLException;
	public InquiryAnswerDTO findById(long inquiryId) throws SQLException;

}
