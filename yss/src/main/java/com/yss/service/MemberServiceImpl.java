package com.yss.service;

import java.util.Map;

import com.yss.dto.MemberDTO;
import com.yss.mapper.MemberMapper;
import com.yss.mybatis.support.MapperContainer;

public class MemberServiceImpl implements MemberService{
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

}
