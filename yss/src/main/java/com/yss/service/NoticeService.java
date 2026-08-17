package com.yss.service;

import java.util.List;
import java.util.Map;

import com.yss.dto.NoticeDTO;

public interface NoticeService {
	public void insertNotice(NoticeDTO dto) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<NoticeDTO> listNotice(Map<String, Object> map);	
	
	public NoticeDTO findById(long noticeId) throws Exception;
	
	public void updateNotice(NoticeDTO dto) throws Exception;
	
	public void deleteNotice(long noticeId) throws Exception;

}
