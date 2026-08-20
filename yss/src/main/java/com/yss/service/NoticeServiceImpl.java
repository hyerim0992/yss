package com.yss.service;

import java.util.List;
import java.util.Map;

import com.yss.dto.NoticeDTO;
import com.yss.mapper.NoticeMapper;
import com.yss.mybatis.support.MapperContainer;
import com.yss.util.MyMultipartFile;

public class NoticeServiceImpl implements NoticeService {
	private NoticeMapper mapper = MapperContainer.get(NoticeMapper.class);
	
	@Override
	public void insertNotice(NoticeDTO dto) throws Exception {
		
		try {
			// 게시물번호(시퀀스)
			dto.setNoticeId(mapper.noticeSeq());
			
			// 게시글 등록
			mapper.insertNotice(dto);
			
			// 퍼일 저장
			if (dto.getListFile().size() != 0) {
				for (MyMultipartFile mf: dto.getListFile()) {
					dto.setServerFiles(mf.getSaveFilename());
					dto.setFiles(mf.getOriginalFilename());
					
					mapper.insertNoticeFile(dto);
				}
			}			
			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
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
	public List<NoticeDTO> listNotice(Map<String, Object> map) {
		List<NoticeDTO> list = null;
		
		try {
			list = mapper.listNotice(map);
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public NoticeDTO findById(long noticeId) {
		NoticeDTO dto = null;
		
		try {
			dto = mapper.findById(noticeId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateNotice(NoticeDTO dto) throws Exception {
		try {
			mapper.updateNotice(dto);
			
			// 퍼일 저장
			if (dto.getListFile().size() != 0) {
				for (MyMultipartFile mf: dto.getListFile()) {
					dto.setServerFiles(mf.getSaveFilename());
					dto.setFiles(mf.getOriginalFilename());
					
					mapper.insertNoticeFile(dto);
				}
			}			
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void deleteNotice(long noticeId) throws Exception {
		try {
			mapper.deleteNotice(noticeId);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public List<NoticeDTO> listNoticeFile(long noticeId) {
		List<NoticeDTO> list = null;
		
		try {
			list = mapper.listNoticeFile(noticeId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public NoticeDTO findByFileId(long fileId) {
		NoticeDTO dto = null;
		
		try {
			dto = mapper.findByFileId(fileId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteNoticeFile(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteNoticeFile(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public void deleteListNotice(List<Long> list) throws Exception {
		try {
			mapper.deleteListNotice(list);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}


}
