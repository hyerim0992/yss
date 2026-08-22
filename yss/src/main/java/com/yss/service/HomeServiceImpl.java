package com.yss.service;

import java.util.List;

import com.yss.dto.HomeDTO;
import com.yss.mapper.HomeMapper;
import com.yss.mybatis.support.MapperContainer;

public class HomeServiceImpl implements HomeService {
	private HomeMapper mapper = MapperContainer.get(HomeMapper.class);
	
	@Override
	public List<HomeDTO> homeBestList() throws Exception {
		return mapper.homeBestList();
	}
	
	@Override
	public List<HomeDTO> homeNewList() throws Exception {
		return mapper.homeNewList();
	}

}
