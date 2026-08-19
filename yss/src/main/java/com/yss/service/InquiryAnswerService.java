package com.yss.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.yss.dto.InquiryAnswerDTO;
import com.yss.dto.InquiryDTO;

public interface InquiryAnswerService {
    public void insertAnswer(InquiryAnswerDTO dto) throws Exception;
    public void updateAnswer(InquiryAnswerDTO dto) throws Exception;
    public void deleteAnswer(long inquiryId) throws Exception;
    
    public int dataCount(Map<String, Object> map);
    public List<InquiryDTO> listInquiry(Map<String, Object> map);    
	public InquiryAnswerDTO findByAnswerId(long inquiryId) throws SQLException;
}