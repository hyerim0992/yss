package com.yss.service;

import java.util.List;
import java.util.Map;

import com.yss.dto.FaqDTO;
import com.yss.mapper.FaqMapper;
import com.yss.mybatis.support.MapperContainer;

public class FaqServiceImpl implements FaqService {
	
	private FaqMapper mapper = MapperContainer.get(FaqMapper.class);

	@Override
	public void insertFaq(FaqDTO dto) {
		try {
			mapper.insertFaq(dto);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<FaqDTO> listFaq() {
		List<FaqDTO> list = null;
		
		try {
			list = mapper.listFaq();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public FaqDTO findById(Long faqId) {
		FaqDTO dto = null;
		
		try {
			dto = mapper.findById(faqId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateFaq(FaqDTO dto) {
		try {
			mapper.updateFaq(dto);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public void deleteFaq(Long faqId) {
		try {
			mapper.deleteFaq(faqId);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}


	@Override
	public List<FaqDTO> listFaqAdmin(Map<String, Object> map) {
		try {
			return mapper.listFaqAdmin(map);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int dataCountFaqAdmin(Map<String, Object> map) {
		try {
			return mapper.dataCountFaqAdmin(map);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
