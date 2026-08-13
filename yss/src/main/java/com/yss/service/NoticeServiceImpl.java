package com.yss.service;

import com.yss.dto.NoticeDTO;
import com.yss.mapper.NoticeMapper;
import com.yss.mybatis.support.MapperContainer;

public class NoticeServiceImpl implements NoticeService {
	private NoticeMapper mapper = MapperContainer.get(NoticeMapper.class);
	
	@Override
	public void insertNotice(NoticeDTO dto) throws Exception {
		
		try {
			mapper.insertNotice(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

}
