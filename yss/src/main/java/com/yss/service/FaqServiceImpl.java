package com.yss.service;

import java.util.List;

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
			e.printStackTrace();
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
			e.printStackTrace();
		}
	}

	@Override
	public void deleteFaq(Long faqId) {
		try {
			mapper.deleteFaq(faqId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}