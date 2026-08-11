package com.yss.mapper;

import java.util.Map;

import com.yss.dto.MemberDTO;

public interface MemberMapper {

	public MemberDTO loginMember(Map<String, Object> map);

}
