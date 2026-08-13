package com.yss.mapper;

import java.sql.SQLException;

import com.yss.dto.NoticeDTO;

public interface NoticeMapper {
	public void insertNotice(NoticeDTO dto) throws SQLException;
}
