package com.yss.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.yss.dto.InquiryAnswerDTO;
import com.yss.dto.InquiryDTO;
import com.yss.mapper.InquiryAnswerMapper;
import com.yss.mybatis.support.MapperContainer;

public class InquiryAnswerServiceImpl implements InquiryAnswerService {

	@Override
	public void insertAnswer(InquiryAnswerDTO dto) throws Exception {
		try {
			InquiryAnswerMapper mapper = MapperContainer.get(InquiryAnswerMapper.class);
			mapper.insertAnswer(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateAnswer(InquiryAnswerDTO dto) throws Exception {
		try {
			InquiryAnswerMapper mapper = MapperContainer.get(InquiryAnswerMapper.class);
			mapper.updateAnswer(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteAnswer(long inquiryId) throws Exception {
		try {
			InquiryAnswerMapper mapper = MapperContainer.get(InquiryAnswerMapper.class);
			mapper.deleteAnswer(inquiryId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			InquiryAnswerMapper mapper = MapperContainer.get(InquiryAnswerMapper.class);
			result = mapper.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<InquiryDTO> listInquiry(Map<String, Object> map) {
		List<InquiryDTO> list = null;
		try {
			InquiryAnswerMapper mapper = MapperContainer.get(InquiryAnswerMapper.class);
			list = mapper.listInquiry(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public InquiryAnswerDTO findById(long inquiryId) throws SQLException {
		InquiryAnswerDTO dto = null;
		
		try {
			InquiryAnswerMapper mapper = MapperContainer.get(InquiryAnswerMapper.class);
			dto = mapper.findById(inquiryId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return dto;
	}


}