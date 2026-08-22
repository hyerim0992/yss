package com.yss.service;

import java.util.List;

import com.yss.dto.HomeDTO;

public interface HomeService {
	public List<HomeDTO> homeBestList() throws Exception;
	
	public List<HomeDTO> homeNewList() throws Exception;

}
