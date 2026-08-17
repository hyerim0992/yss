package com.yss.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.yss.dto.NoticeDTO;

public interface NoticeMapper {
	public void insertNotice(NoticeDTO dto) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<NoticeDTO> listNotice(Map<String, Object> map);
	
	public NoticeDTO findById(long noticeId) throws SQLException;
	
	public void updateNotice(NoticeDTO dto) throws SQLException;
	
	public void deleteNotice(long noticeId) throws SQLException;
}
