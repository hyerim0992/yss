package com.yss.service;

import java.util.List;
import java.util.Map;

import com.yss.dto.InquiryDTO;
import com.yss.mapper.InquiryMapper;
import com.yss.mybatis.support.MapperContainer;

public class InquiryServiceImpl implements InquiryService {
	private InquiryMapper mapper = MapperContainer.get(InquiryMapper.class);

	
	@Override
	public void insertInquiry(InquiryDTO dto) throws Exception {
		try {
			mapper.insertInquiry(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public void updateInquiry(InquiryDTO dto) throws Exception {
		
	}

	@Override
	public void deleteInquiry(Map<String, Object> map) {
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
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
		 list = mapper.listInquiry(map);
		 } catch (Exception e) {
		 e.printStackTrace();
		 }
		 
		 return list;
	}

	
}
