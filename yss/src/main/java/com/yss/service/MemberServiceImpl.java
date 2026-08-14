package com.yss.service;

import java.util.HashMap;
import java.util.Map;

import com.yss.dto.MemberDTO;
import com.yss.mapper.MemberMapper;
import com.yss.mybatis.support.MapperContainer;
import com.yss.mybatis.support.SqlSessionManager;

public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper =
			MapperContainer.get(MemberMapper.class);

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

			// 회원번호 생성
			Long memberId = mapper.memberSeq();

			dto.setMemberId(memberId);

			// 1. MEMBER
			mapper.insertMember(dto);

			// 2. MEMBERDETAIL
			mapper.insertMemberDetail(dto);

			// 3. ADDRESS
			mapper.insertAddress(dto);

		} catch (Exception e) {

			// 세 개 중 하나라도 실패하면 전체 롤백
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
	public boolean checkMemberForPassword(
			String userId,
			String name,
			String email) {

		try {
			Map<String, Object> map = new HashMap<>();

			map.put("userId", userId);
			map.put("name", name);
			map.put("email", email);

			int count =
					mapper.checkMemberForPassword(map);

			return count > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
	
	@Override
	public void updatePassword(
			String userId,
			String password) {

		try {
			Map<String, Object> map = new HashMap<>();

			map.put("userId", userId);
			map.put("password", password);

			mapper.updatePassword(map);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}