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
	public MemberDTO findMemberForSanction(Long memberId);
	public void sanctionMember(Long memberId, String reason);
	public void releaseMemberSanction(Long memberId);
	public List<MemberDTO> listSanction(Map<String, Object> map);
	public int dataCountSanction(Map<String, Object> map);

	public void deleteSanctions(List<Long> sanctionIds);

	// 포인트 관리
	public List<Map<String, Object>> listPointSummary(Map<String, Object> map);
	public int dataCountPointSummary(Map<String, Object> map);
	public List<Map<String, Object>> listPointHistory(Long memberId);
	public void adjustPoint(Long memberId, int amount, String type, String reason);

	// 쿠폰 관리
	public List<Map<String, Object>> listCoupon(Map<String, Object> map);
	public int dataCountCoupon(Map<String, Object> map);
	public void insertCoupon(Map<String, Object> map);
	public void updateCoupon(Map<String, Object> map);
	public boolean deleteCoupon(Long couponId);
	public boolean issueCoupon(Long couponId, Long memberId);
}
