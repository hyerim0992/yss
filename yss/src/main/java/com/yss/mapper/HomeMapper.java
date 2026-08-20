package com.yss.mapper;

import java.sql.SQLException;
import java.util.List;

import com.yss.dto.HomeDTO;

public interface HomeMapper {
	public List<HomeDTO> homeBestList() throws SQLException;
}
