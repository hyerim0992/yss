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
}
