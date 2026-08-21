package com.yss.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yss.dto.MemberDTO;
import com.yss.mapper.MemberMapper;
import com.yss.mybatis.support.MapperContainer;
import com.yss.mybatis.support.SqlSessionManager;

public class MemberServiceImpl implements MemberService {

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

	@Override
	public void insertMember(MemberDTO dto) {
		try {
			if (dto.getRole() == 0)
				dto.setRole(1);

			if (dto.getStatus() == null || dto.getStatus().isBlank())
				dto.setStatus("일반");

			Long memberId = mapper.memberSeq();
			dto.setMemberId(memberId);

			mapper.insertMember(dto);
			mapper.insertMemberDetail(dto);
			mapper.insertAddress(dto);

		} catch (Exception e) {
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
	public boolean checkMemberForPassword(String userId, String name, String email) {

		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("name", name);
			map.put("email", email);

			return mapper.checkMemberForPassword(map) > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	@Override
	public void updatePassword(String userId, String password) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("password", password);

			mapper.updatePassword(map);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<MemberDTO> listMember(Map<String, Object> map) {
		return mapper.listMember(map);
	}

	@Override
	public int dataCountMember(Map<String, Object> map) {
		return mapper.dataCountMember(map);
	}

	@Override
	public int checkUserIdExceptMember(String userId, Long memberId) {

		Map<String, Object> map = new HashMap<>();

		map.put("userId", userId);
		map.put("memberId", memberId);

		return mapper.checkUserIdExceptMember(map);
	}

	@Override
	public void updateMember(MemberDTO dto) {
		try {
			String oldStatus = mapper.findMemberStatus(dto.getMemberId());

			mapper.updateMember(dto);
			mapper.updateMemberDetail(dto);
			mapper.saveDefaultAddress(dto);

			/*
			 * 접속불가 -> 일반 회원 수정화면에서 일반 상태로 되돌리면 진행중 제재도 해제
			 */
			if ("접속불가".equals(oldStatus) && "일반".equals(dto.getStatus())) {

				mapper.releaseSanction(dto.getMemberId());
			}

		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public void deleteMember(Long memberId) {
		try {
			mapper.deleteMember(memberId);

		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public void restoreMember(Long memberId) {
		try {
			mapper.restoreMember(memberId);

		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public void releaseMemberSanction(Long memberId) {
		try {
			// 제재 상태 -> 해제
			// 종료일 -> 현재 날짜
			mapper.releaseSanction(memberId);

			// 회원 상태 -> 일반
			mapper.updateMemberStatusNormal(memberId);

		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public MemberDTO findMemberForSanction(Long memberId) {
		try {
			return mapper.findMemberForSanction(memberId);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	@Override
	public void sanctionMember(Long memberId, String reason) {
		try {
			if (memberId == null) {
				throw new IllegalArgumentException("회원번호가 없습니다.");
			}

			if (reason == null || reason.isBlank()) {
				throw new IllegalArgumentException("제재 사유를 입력해 주세요.");
			}

			MemberDTO dto = mapper.findMemberForSanction(memberId);

			if (dto == null) {
				throw new IllegalArgumentException("회원을 찾을 수 없습니다.");
			}

			if ("접속불가".equals(dto.getStatus())) {
				throw new IllegalArgumentException("이미 제재 중인 회원입니다.");
			}

			dto.setSanctionReason(reason.trim());

			// 회원 상태 -> 접속불가
			mapper.updateMemberStatusBlocked(memberId);

			// 새로운 제재 이력 INSERT
			mapper.insertSanction(dto);

		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<MemberDTO> listSanction(Map<String, Object> map) {

		try {
			return mapper.listSanction(map);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	@Override
	public int dataCountSanction(Map<String, Object> map) {

		try {
			return mapper.dataCountSanction(map);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	@Override
	public void deleteSanctions(List<Long> sanctionIds) {

		try {
			if (sanctionIds == null || sanctionIds.isEmpty()) {

				throw new IllegalArgumentException("삭제할 제재를 선택해 주세요.");
			}

			/*
			 * 진행중 제재가 삭제되는 경우 회원 상태를 일반으로 복구
			 */
			mapper.restoreMemberStatusForDeletedSanctions(sanctionIds);

			// 제재 이력 삭제
			mapper.deleteSanctions(sanctionIds);

		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}


	@Override
	public List<Map<String, Object>> listPointSummary(Map<String, Object> map) {
		return mapper.listPointSummary(map);
	}

	@Override
	public int dataCountPointSummary(Map<String, Object> map) {
		return mapper.dataCountPointSummary(map);
	}

	@Override
	public List<Map<String, Object>> listPointHistory(Long memberId) {
		if (memberId == null) {
			return List.of();
		}
		return mapper.listPointHistory(memberId);
	}

	@Override
	public void adjustPoint(Long memberId, int amount, String type, String reason) {
		try {
			if (memberId == null) {
				throw new IllegalArgumentException("회원번호가 없습니다.");
			}
			if (amount <= 0) {
				throw new IllegalArgumentException("포인트는 1 이상 입력해 주세요.");
			}
			if (!"적립".equals(type) && !"차감".equals(type)) {
				throw new IllegalArgumentException("포인트 처리 유형을 확인해 주세요.");
			}
			if (reason == null || reason.isBlank()) {
				reason = "관리자 포인트 조정";
			}

			MemberDTO member = mapper.findMemberForSanction(memberId);
			if (member == null) {
				throw new IllegalArgumentException("회원을 찾을 수 없습니다.");
			}

			int currentBalance = mapper.currentPointBalance(memberId);
			int signedAmount = "차감".equals(type) ? -amount : amount;
			int newBalance = currentBalance + signedAmount;

			if (newBalance < 0) {
				throw new IllegalArgumentException("보유 포인트보다 많이 차감할 수 없습니다.");
			}

			Long pointId = mapper.nextPointId();
			Map<String, Object> pointMap = new HashMap<>();
			pointMap.put("pointId", pointId);
			pointMap.put("orderId", "ADMIN-" + pointId);
			pointMap.put("memberId", memberId);
			pointMap.put("amount", signedAmount);
			pointMap.put("type", type);
			pointMap.put("reason", reason.trim());
			pointMap.put("balance", newBalance);
			mapper.insertPointAdjustment(pointMap);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<Map<String, Object>> listCoupon(Map<String, Object> map) {
		return mapper.listCoupon(map);
	}

	@Override
	public int dataCountCoupon(Map<String, Object> map) {
		return mapper.dataCountCoupon(map);
	}

	@Override
	public void insertCoupon(Map<String, Object> map) {
		try {
			map.put("couponId", mapper.nextCouponId());
			mapper.insertCoupon(map);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public void updateCoupon(Map<String, Object> map) {
		try {
			mapper.updateCoupon(map);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public boolean deleteCoupon(Long couponId) {
		try {
			return mapper.deleteCoupon(couponId) > 0;
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}

	@Override
	public boolean issueCoupon(Long couponId, Long memberId) {
		try {
			if (couponId == null || memberId == null) {
				return false;
			}
			if (mapper.findMemberForSanction(memberId) == null) {
				return false;
			}

			Map<String, Object> map = new HashMap<>();
			map.put("memberCouponId", mapper.nextMemberCouponId());
			map.put("couponId", couponId);
			map.put("memberId", memberId);
			return mapper.issueCoupon(map) > 0;
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			throw new RuntimeException(e);
		}
	}
}
