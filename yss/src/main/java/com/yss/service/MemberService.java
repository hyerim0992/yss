package com.yss.service;

import java.util.List;
import java.util.Map;

import com.yss.dto.MemberDTO;

public interface MemberService {
	public MemberDTO loginMember(Map<String, Object> map);
	public void insertMember(MemberDTO dto);
	public int checkUserId(String userId);
	public MemberDTO findUserId(String name, String email);
	public boolean checkMemberForPassword(String userId, String name, String email);
	public void updatePassword(String userId, String password);

	// 관리자 회원관리
	public List<MemberDTO> listMember(Map<String, Object> map);
	public int dataCountMember(Map<String, Object> map);
	public int checkUserIdExceptMember(String userId, Long memberId);
	public void updateMember(MemberDTO dto);
	public void deleteMember(Long memberId);
	public void restoreMember(Long memberId);
}
