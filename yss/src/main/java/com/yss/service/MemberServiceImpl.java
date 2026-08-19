package com.yss.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yss.dto.MemberDTO;
import com.yss.mapper.MemberMapper;
import com.yss.mybatis.support.MapperContainer;
import com.yss.mybatis.support.SqlSessionManager;

public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper = MapperContainer.get(MemberMapper.class);

	@Override
	public MemberDTO loginMember(Map<String, Object> map) {
		MemberDTO dto = null;
		try {
			dto = mapper.loginMember(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void insertMember(MemberDTO dto) {
		try {
			if (dto.getRole() == 0)
				dto.setRole(1);
			if (dto.getStatus() == null || dto.getStatus().isBlank())
				dto.setStatus("일반");

			Long memberId = mapper.memberSeq();
			dto.setMemberId(memberId);

			mapper.insertMember(dto);
			mapper.insertMemberDetail(dto);
			mapper.insertAddress(dto);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public int checkUserId(String userId) {
		int result = 0;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			result = mapper.checkUserId(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public MemberDTO findUserId(String name, String email) {
		MemberDTO dto = null;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("name", name);
			map.put("email", email);
			dto = mapper.findUserId(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public boolean checkMemberForPassword(String userId, String name, String email) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("name", name);
			map.put("email", email);
			return mapper.checkMemberForPassword(map) > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public void updatePassword(String userId, String password) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("password", password);
			mapper.updatePassword(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<MemberDTO> listMember(Map<String, Object> map) {
		return mapper.listMember(map);
	}

	@Override
	public int dataCountMember(Map<String, Object> map) {
		return mapper.dataCountMember(map);
	}

	@Override
	public int checkUserIdExceptMember(String userId, Long memberId) {
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("memberId", memberId);
		return mapper.checkUserIdExceptMember(map);
	}

	@Override
	public void updateMember(MemberDTO dto) {
		try {
			mapper.updateMember(dto);
			mapper.updateMemberDetail(dto);
			mapper.saveDefaultAddress(dto);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public void deleteMember(Long memberId) {
		try {
			mapper.deleteMember(memberId);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public void restoreMember(Long memberId) {
		try {
			mapper.restoreMember(memberId);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}
}
