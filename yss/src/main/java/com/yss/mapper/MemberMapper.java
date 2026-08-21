package com.yss.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.yss.dto.MemberDTO;

public interface MemberMapper {
	public MemberDTO loginMember(Map<String, Object> map);
	public Long memberSeq();
	public void insertMember(MemberDTO dto) throws SQLException;
	public void insertMemberDetail(MemberDTO dto) throws SQLException;
	public void insertAddress(MemberDTO dto) throws SQLException;
	public int checkUserId(Map<String, Object> map);
	public MemberDTO findUserId(Map<String, Object> map);
	public int checkMemberForPassword(Map<String, Object> map);
	public void updatePassword(Map<String, Object> map) throws SQLException;

	// 관리자 회원관리
	public List<MemberDTO> listMember(Map<String, Object> map);
	public int dataCountMember(Map<String, Object> map);
	public int checkUserIdExceptMember(Map<String, Object> map);
	public void updateMember(MemberDTO dto) throws SQLException;
	public void updateMemberDetail(MemberDTO dto) throws SQLException;
	public void saveDefaultAddress(MemberDTO dto) throws SQLException;
	public void deleteMember(Long memberId) throws SQLException;
	public void restoreMember(Long memberId) throws SQLException;
	
	// 회원 제재
	public String findMemberStatus(Long memberId);
	public MemberDTO findMemberForSanction(Long memberId);

	public void insertSanction(MemberDTO dto) throws SQLException;
	public void releaseSanction(Long memberId) throws SQLException;

	public void updateMemberStatusBlocked(Long memberId)
			throws SQLException;

	public void updateMemberStatusNormal(Long memberId)
			throws SQLException;

	public List<MemberDTO> listSanction(Map<String, Object> map);
	public int dataCountSanction(Map<String, Object> map);

	public void restoreMemberStatusForDeletedSanctions(
			List<Long> sanctionIds) throws SQLException;

	public void deleteSanctions(
			List<Long> sanctionIds) throws SQLException;

	// 포인트 관리
	public List<Map<String, Object>> listPointSummary(Map<String, Object> map);
	public int dataCountPointSummary(Map<String, Object> map);
	public List<Map<String, Object>> listPointHistory(Long memberId);
	public int currentPointBalance(Long memberId);
	public Long nextPointId();
	public void insertPointAdjustment(Map<String, Object> map) throws SQLException;

	// 쿠폰 관리
	public List<Map<String, Object>> listCoupon(Map<String, Object> map);
	public int dataCountCoupon(Map<String, Object> map);
	public Long nextCouponId();
	public void insertCoupon(Map<String, Object> map) throws SQLException;
	public void updateCoupon(Map<String, Object> map) throws SQLException;
	public int deleteCoupon(Long couponId) throws SQLException;
	public Long nextMemberCouponId();
	public int issueCoupon(Map<String, Object> map) throws SQLException;
}
