package com.yss.service;

import java.util.Map;

import com.yss.dto.MemberDTO;

public interface MemberService {

	public MemberDTO loginMember(Map<String, Object> map);

	public void insertMember(MemberDTO dto);

	public int checkUserId(String userId);
	
	public MemberDTO findUserId(String name, String email);

	public boolean checkMemberForPassword(
			String userId,
			String name,
			String email);

	public void updatePassword(
			String userId,
			String password);
}
