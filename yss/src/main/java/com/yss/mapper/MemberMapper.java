package com.yss.mapper;

import java.sql.SQLException;
import java.util.Map;

import com.yss.dto.MemberDTO;

public interface MemberMapper {

	// 로그인
	public MemberDTO loginMember(Map<String, Object> map);

	// 회원번호 생성
	public Long memberSeq();

	// MEMBER 등록
	public void insertMember(MemberDTO dto) throws SQLException;

	// MEMBERDETAIL 등록
	public void insertMemberDetail(MemberDTO dto) throws SQLException;

	// ADDRESS 등록
	public void insertAddress(MemberDTO dto) throws SQLException;

	// 아이디 중복확인
	public int checkUserId(Map<String, Object> map);
	
	// 아이디 찾기
	public MemberDTO findUserId(Map<String, Object> map);

	// 비밀번호 찾기 전 회원 확인
	public int checkMemberForPassword(Map<String, Object> map);

	// 비밀번호 변경
	public void updatePassword(Map<String, Object> map) throws SQLException;
}