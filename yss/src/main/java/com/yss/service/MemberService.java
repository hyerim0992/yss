package com.yss.service;

import java.util.Map;

import com.yss.dto.MemberDTO;


public interface MemberService {
	public MemberDTO loginMember(Map<String, Object> map);
}
