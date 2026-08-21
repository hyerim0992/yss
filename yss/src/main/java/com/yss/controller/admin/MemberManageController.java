package com.yss.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

import com.yss.dto.FaqDTO;
import com.yss.dto.MemberDTO;
import com.yss.dto.SessionInfo;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.FaqService;
import com.yss.service.FaqServiceImpl;
import com.yss.service.MemberService;
import com.yss.service.MemberServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/member/*")
public class MemberManageController {

	private MemberService service = new MemberServiceImpl();
	private FaqService faqService = new FaqServiceImpl();

	@GetMapping("")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/member/main");

		try {
			int page = parseInt(req.getParameter("page"), 1);
			if (page < 1)
				page = 1;

			int size = 10;
			String schType = trimToDefault(req.getParameter("schType"), "all");
			String kwd = trimToDefault(req.getParameter("kwd"), "");
			String memberStatus = trimToDefault(req.getParameter("memberStatus"), "");

			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("memberStatus", memberStatus);

			int dataCount = service.dataCountMember(map);
			int totalPage = Math.max(1, (dataCount + size - 1) / size);
			if (page > totalPage)
				page = totalPage;

			map.put("offset", (page - 1) * size);
			map.put("size", size);

			List<MemberDTO> list = service.listMember(map);
			String sanctionStatus = trimToDefault(req.getParameter("sanctionStatus"), "");

			Map<String, Object> sanctionMap = new HashMap<>();

			sanctionMap.put("sanctionStatus", sanctionStatus);

			List<MemberDTO> sanctionList = service.listSanction(sanctionMap);

			int sanctionCount = service.dataCountSanction(sanctionMap);

			// 포인트 관리
			String pointSchType = trimToDefault(req.getParameter("pointSchType"), "all");
			String pointKwd = trimToDefault(req.getParameter("pointKwd"), "");
			Map<String, Object> pointMap = new HashMap<>();
			pointMap.put("pointSchType", pointSchType);
			pointMap.put("pointKwd", pointKwd);
			List<Map<String, Object>> pointList = service.listPointSummary(pointMap);
			int pointCount = service.dataCountPointSummary(pointMap);

			// 특정 회원의 포인트 적립/차감 히스토리
			Long pointHistoryMemberId = parseLong(req.getParameter("pointHistoryMemberId"));
			List<Map<String, Object>> pointHistoryList = new ArrayList<>();
			String pointHistoryMemberName = "";
			String pointHistoryUserId = "";

			if (pointHistoryMemberId != null) {
				pointHistoryList = service.listPointHistory(pointHistoryMemberId);

				for (Map<String, Object> point : pointList) {
					if (String.valueOf(pointHistoryMemberId).equals(String.valueOf(point.get("memberId")))) {
						Object memberName = point.get("name");
						Object userId = point.get("userId");
						pointHistoryMemberName = memberName == null ? "" : String.valueOf(memberName);
						pointHistoryUserId = userId == null ? "" : String.valueOf(userId);
						break;
					}
				}

				if (pointHistoryMemberName.isBlank() && !pointHistoryList.isEmpty()) {
					Map<String, Object> first = pointHistoryList.get(0);
					Object memberName = first.get("name");
					Object userId = first.get("userId");
					pointHistoryMemberName = memberName == null ? "" : String.valueOf(memberName);
					pointHistoryUserId = userId == null ? "" : String.valueOf(userId);
				}
			}

			// 쿠폰 관리
			String couponSchType = trimToDefault(req.getParameter("couponSchType"), "all");
			String couponKwd = trimToDefault(req.getParameter("couponKwd"), "");
			String couponStatus = trimToDefault(req.getParameter("couponStatus"), "");
			Map<String, Object> couponMap = new HashMap<>();
			couponMap.put("couponSchType", couponSchType);
			couponMap.put("couponKwd", couponKwd);
			couponMap.put("couponStatus", couponStatus);
			List<Map<String, Object>> couponList = service.listCoupon(couponMap);
			int couponCount = service.dataCountCoupon(couponMap);

			// FAQ 관리
			String faqSchType = trimToDefault(req.getParameter("faqSchType"), "all");
			String faqKwd = trimToDefault(req.getParameter("faqKwd"), "");
			Map<String, Object> faqMap = new HashMap<>();
			faqMap.put("faqSchType", faqSchType);
			faqMap.put("faqKwd", faqKwd);
			List<FaqDTO> faqList = faqService.listFaqAdmin(faqMap);
			int faqCount = faqService.dataCountFaqAdmin(faqMap);

			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("page", page);
			mav.addObject("totalPage", totalPage);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			mav.addObject("memberStatus", memberStatus);
			mav.addObject("message", resultMessage(req.getParameter("result")));
			mav.addObject("sanctionList", sanctionList);
			mav.addObject("sanctionCount", sanctionCount);
			mav.addObject("sanctionStatus", sanctionStatus);
			mav.addObject("pointList", pointList);
			mav.addObject("pointCount", pointCount);
			mav.addObject("pointSchType", pointSchType);
			mav.addObject("pointKwd", pointKwd);
			mav.addObject("pointHistoryMemberId", pointHistoryMemberId);
			mav.addObject("pointHistoryMemberName", pointHistoryMemberName);
			mav.addObject("pointHistoryUserId", pointHistoryUserId);
			mav.addObject("pointHistoryList", pointHistoryList);
			mav.addObject("pointHistoryCount", pointHistoryList.size());
			mav.addObject("couponList", couponList);
			mav.addObject("couponCount", couponCount);
			mav.addObject("couponSchType", couponSchType);
			mav.addObject("couponKwd", couponKwd);
			mav.addObject("couponStatus", couponStatus);
			mav.addObject("faqList", faqList);
			mav.addObject("faqCount", faqCount);
			mav.addObject("faqSchType", faqSchType);
			mav.addObject("faqKwd", faqKwd);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("message", "회원 목록을 불러오는 중 오류가 발생했습니다.");
		}
		return mav;
	}

	@PostMapping("write")
	public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			MemberDTO dto = readMember(req, false);

			if (!isValid(dto, true))
				return redirect("invalid");
			if (service.checkUserId(dto.getUserId()) > 0)
				return redirect("duplicate");

			service.insertMember(dto);
			return redirect("insert");
		} catch (Exception e) {
			e.printStackTrace();
			return redirect("error");
		}
	}

	@PostMapping("update")
	public ModelAndView update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			MemberDTO dto = readMember(req, true);

			if (dto.getMemberId() == null || !isValid(dto, false)) {
				return redirect("invalid");
			}

			if (service.checkUserIdExceptMember(dto.getUserId(), dto.getMemberId()) > 0) {

				return redirect("duplicate");
			}

			// 현재 DB에 저장된 회원 상태
			MemberDTO current = service.findMemberForSanction(dto.getMemberId());

			/*
			 * 일반 회원을 접속불가로 변경하려는 경우 여기서 바로 제재하지 않고 제재사유 입력 페이지로 이동
			 */
			if (current != null && !"접속불가".equals(current.getStatus()) && "접속불가".equals(dto.getStatus())) {

				return new ModelAndView("redirect:/admin/member/sanction?memberId=" + dto.getMemberId());
			}

			// 일반적인 회원정보 수정
			service.updateMember(dto);

			return redirect("update");

		} catch (Exception e) {
			e.printStackTrace();
			return redirect("error");
		}
	}

	@PostMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			Long memberId = parseLong(req.getParameter("memberId"));
			if (memberId == null)
				return redirect("invalid");

			HttpSession session = req.getSession(false);
			if (session != null) {
				SessionInfo info = (SessionInfo) session.getAttribute("member");
				if (info != null && memberId.equals(info.getMemberId())) {
					return redirect("selfDelete");
				}
			}

			service.deleteMember(memberId);
			return redirect("delete");
		} catch (Exception e) {
			e.printStackTrace();
			return redirect("error");
		}
	}

	@PostMapping("restore")
	public ModelAndView restore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			Long memberId = parseLong(req.getParameter("memberId"));
			if (memberId == null)
				return redirect("invalid");

			service.restoreMember(memberId);
			return redirect("restore");
		} catch (Exception e) {
			e.printStackTrace();
			return redirect("error");
		}
	}

	@GetMapping("sanction")
	public ModelAndView sanctionForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		Long memberId = parseLong(req.getParameter("memberId"));

		if (memberId == null) {
			return redirect("invalid");
		}

		MemberDTO dto = service.findMemberForSanction(memberId);

		if (dto == null) {
			return redirect("invalid");
		}

		ModelAndView mav = new ModelAndView("admin/member/sanction");

		mav.addObject("member", dto);

		return mav;
	}

	@PostMapping("sanction")
	public ModelAndView sanctionSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try {
			Long memberId = parseLong(req.getParameter("memberId"));

			String reason = trimToNull(req.getParameter("sanctionReason"));

			if (memberId == null || reason == null) {
				return new ModelAndView("redirect:/admin/member/sanction?memberId=" + memberId + "&error=reason");
			}
			service.sanctionMember(memberId, reason);

			return new ModelAndView("redirect:/admin/member" + "?result=sanctionInsert" + "&tab=2");

		} catch (Exception e) {
			e.printStackTrace();
			return redirect("error");
		}
	}

	@PostMapping("releaseSanction")
	public ModelAndView releaseSanction(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try {
			Long memberId = parseLong(req.getParameter("memberId"));

			if (memberId == null) {
				return redirect("invalid");
			}
			service.releaseMemberSanction(memberId);

			return new ModelAndView("redirect:/admin/member" + "?result=sanctionRelease" + "&tab=2");

		} catch (Exception e) {
			e.printStackTrace();
			return redirect("error");
		}
	}

	@PostMapping("deleteSanctions")
	public ModelAndView deleteSanctions(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try {
			String[] values = req.getParameterValues("sanctionIds");

			if (values == null || values.length == 0) {

				return new ModelAndView("redirect:/admin/member" + "?result=sanctionSelect" + "&tab=2");
			}
			List<Long> sanctionIds = new ArrayList<>();

			for (String value : values) {
				Long sanctionId = parseLong(value);
				if (sanctionId != null) {
					sanctionIds.add(sanctionId);
				}
			}
			if (sanctionIds.isEmpty()) {
				return new ModelAndView("redirect:/admin/member" + "?result=sanctionSelect" + "&tab=2");
			}
			service.deleteSanctions(sanctionIds);
			return new ModelAndView("redirect:/admin/member" + "?result=sanctionDelete" + "&tab=2");

		} catch (Exception e) {
			e.printStackTrace();

			return redirect("error");
		}
	}


	@PostMapping("pointAdjust")
	public ModelAndView pointAdjust(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			Long memberId = parseLong(req.getParameter("memberId"));
			int amount = parseInt(req.getParameter("amount"), 0);
			String type = trimToDefault(req.getParameter("type"), "");
			String reason = trimToDefault(req.getParameter("reason"), "관리자 포인트 조정");

			service.adjustPoint(memberId, amount, type, reason);
			return new ModelAndView("redirect:/admin/member?result=pointAdjust&tab=3");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/member?result=pointError&tab=3");
		}
	}

	@PostMapping("couponWrite")
	public ModelAndView couponWrite(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			Map<String, Object> map = readCoupon(req, false);
			if (!isValidCoupon(map)) {
				return new ModelAndView("redirect:/admin/member?result=couponInvalid&tab=4");
			}
			service.insertCoupon(map);
			return new ModelAndView("redirect:/admin/member?result=couponInsert&tab=4");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/member?result=couponError&tab=4");
		}
	}

	@PostMapping("couponUpdate")
	public ModelAndView couponUpdate(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			Map<String, Object> map = readCoupon(req, true);
			if (!isValidCoupon(map)) {
				return new ModelAndView("redirect:/admin/member?result=couponInvalid&tab=4");
			}
			service.updateCoupon(map);
			return new ModelAndView("redirect:/admin/member?result=couponUpdate&tab=4");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/member?result=couponError&tab=4");
		}
	}

	@PostMapping("couponDelete")
	public ModelAndView couponDelete(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			Long couponId = parseLong(req.getParameter("couponId"));
			if (couponId == null) {
				return new ModelAndView("redirect:/admin/member?result=couponInvalid&tab=4");
			}
			boolean deleted = service.deleteCoupon(couponId);
			String result = deleted ? "couponDelete" : "couponDeleteBlocked";
			return new ModelAndView("redirect:/admin/member?result=" + result + "&tab=4");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/member?result=couponError&tab=4");
		}
	}

	@PostMapping("couponIssue")
	public ModelAndView couponIssue(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			Long couponId = parseLong(req.getParameter("couponId"));
			Long memberId = parseLong(req.getParameter("memberId"));
			boolean issued = service.issueCoupon(couponId, memberId);
			String result = issued ? "couponIssue" : "couponIssueFail";
			return new ModelAndView("redirect:/admin/member?result=" + result + "&tab=4");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/member?result=couponError&tab=4");
		}
	}

	@PostMapping("faqWrite")
	public ModelAndView faqWrite(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			Long adminId = loginMemberId(req);
			String title = trimToNull(req.getParameter("title"));
			String content = trimToNull(req.getParameter("content"));
			String category = trimToNull(req.getParameter("category"));

			if (adminId == null || title == null || content == null || category == null) {
				return new ModelAndView("redirect:/admin/member?result=faqInvalid&tab=5");
			}

			FaqDTO dto = new FaqDTO();
			dto.setMemberId(adminId);
			dto.setTitle(title);
			dto.setContent(content);
			dto.setCategory(category);
			faqService.insertFaq(dto);
			return new ModelAndView("redirect:/admin/member?result=faqInsert&tab=5");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/member?result=faqError&tab=5");
		}
	}

	@PostMapping("faqUpdate")
	public ModelAndView faqUpdate(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			Long faqId = parseLong(req.getParameter("faqId"));
			String title = trimToNull(req.getParameter("title"));
			String content = trimToNull(req.getParameter("content"));
			String category = trimToNull(req.getParameter("category"));
			if (faqId == null || title == null || content == null || category == null) {
				return new ModelAndView("redirect:/admin/member?result=faqInvalid&tab=5");
			}

			FaqDTO dto = new FaqDTO();
			dto.setFaqId(faqId);
			dto.setTitle(title);
			dto.setContent(content);
			dto.setCategory(category);
			faqService.updateFaq(dto);
			return new ModelAndView("redirect:/admin/member?result=faqUpdate&tab=5");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/member?result=faqError&tab=5");
		}
	}

	@PostMapping("faqDelete")
	public ModelAndView faqDelete(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			Long faqId = parseLong(req.getParameter("faqId"));
			if (faqId == null) {
				return new ModelAndView("redirect:/admin/member?result=faqInvalid&tab=5");
			}
			faqService.deleteFaq(faqId);
			return new ModelAndView("redirect:/admin/member?result=faqDelete&tab=5");
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/member?result=faqError&tab=5");
		}
	}

	private MemberDTO readMember(HttpServletRequest req, boolean update) {
		MemberDTO dto = new MemberDTO();

		if (update)
			dto.setMemberId(parseLong(req.getParameter("memberId")));

		dto.setUserId(trimToDefault(req.getParameter("userId"), ""));
		dto.setPassword(trimToDefault(req.getParameter("password"), ""));
		dto.setName(trimToDefault(req.getParameter("name"), ""));
		dto.setEmail(trimToDefault(req.getParameter("email"), ""));
		dto.setPhone(trimToDefault(req.getParameter("phone"), ""));
		dto.setBirth(trimToDefault(req.getParameter("birth"), ""));
		dto.setZip(trimToDefault(req.getParameter("zip"), ""));
		dto.setAddr1(trimToDefault(req.getParameter("addr1"), ""));
		dto.setAddr2(trimToNull(req.getParameter("addr2")));
		dto.setRole(parseInt(req.getParameter("role"), 1));
		dto.setStatus(trimToDefault(req.getParameter("status"), "일반"));
		dto.setSanctionReason(trimToNull(req.getParameter("sanctionReason")));
		dto.setBankName(trimToNull(req.getParameter("bankName")));
		dto.setRefundAccount(trimToNull(req.getParameter("refundAccount")));
		dto.setAccountHolder(trimToNull(req.getParameter("accountHolder")));

		return dto;
	}


	private Map<String, Object> readCoupon(HttpServletRequest req, boolean update) {
		Map<String, Object> map = new HashMap<>();
		if (update) {
			map.put("couponId", parseLong(req.getParameter("couponId")));
		}
		map.put("name", trimToNull(req.getParameter("name")));
		map.put("validDays", trimToNull(req.getParameter("validDays")));
		map.put("discount", parseInt(req.getParameter("discount"), -1));
		map.put("discountType", trimToNull(req.getParameter("discountType")));
		map.put("minOrderAmount", parseNullableInt(req.getParameter("minOrderAmount")));
		map.put("maxDiscountAmount", parseNullableInt(req.getParameter("maxDiscountAmount")));
		map.put("availability", trimToNull(req.getParameter("availability")));
		return map;
	}

	private boolean isValidCoupon(Map<String, Object> map) {
		if (map.get("name") == null || map.get("validDays") == null
				|| map.get("discountType") == null || map.get("availability") == null) {
			return false;
		}
		Object couponId = map.get("couponId");
		if (map.containsKey("couponId") && couponId == null) {
			return false;
		}
		Integer discount = (Integer) map.get("discount");
		return discount != null && discount >= 0;
	}

	private Integer parseNullableInt(String value) {
		if (value == null || value.isBlank()) {
			return null;
		}
		try {
			return Integer.valueOf(value.trim());
		} catch (Exception e) {
			return null;
		}
	}

	private Long loginMemberId(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if (session == null) {
			return null;
		}
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		return info == null ? null : info.getMemberId();
	}

	private boolean isValid(MemberDTO dto, boolean passwordRequired) {
		if (isBlank(dto.getUserId()) || isBlank(dto.getName()) || isBlank(dto.getEmail()) || isBlank(dto.getPhone())
				|| isBlank(dto.getBirth()) || isBlank(dto.getZip()) || isBlank(dto.getAddr1())
				|| isBlank(dto.getStatus())) {
			return false;
		}

		if (passwordRequired && isBlank(dto.getPassword()))
			return false;
		if (!"일반".equals(dto.getStatus()) && !"접속불가".equals(dto.getStatus()))
			return false;

		String phoneNumber = dto.getPhone().replace("-", "");
		if (!phoneNumber.matches("\\d+"))
			return false;

		if (dto.getRefundAccount() != null) {
			String accountNumber = dto.getRefundAccount().replace("-", "");
			if (!accountNumber.matches("\\d+"))
				return false;
		}

		return dto.getRole() >= 1 && dto.getRole() <= 5;
	}

	private ModelAndView redirect(String result) {
		return new ModelAndView("redirect:/admin/member?result=" + result);
	}

	private String resultMessage(String result) {
		if (result == null || result.isBlank())
			return null;

		return switch (result) {
		case "insert" -> "회원이 등록되었습니다.";
		case "update" -> "회원 정보가 수정되었습니다.";
		case "delete" -> "회원이 삭제 처리되었습니다.";
		case "restore" -> "회원이 복구되었습니다.";
		case "sanctionInsert" -> "회원 제재가 등록되었습니다.";
		case "sanctionRelease" -> "회원 제재가 해제되었습니다.";
		case "sanctionDelete" -> "선택한 제재 이력이 삭제되었습니다.";
		case "sanctionSelect" -> "삭제할 제재를 선택해 주세요.";
		case "pointAdjust" -> "포인트가 정상적으로 조정되었습니다.";
		case "pointError" -> "포인트 처리 중 오류가 발생했습니다. 보유 포인트와 입력값을 확인해 주세요.";
		case "couponInsert" -> "쿠폰이 등록되었습니다.";
		case "couponUpdate" -> "쿠폰이 수정되었습니다.";
		case "couponDelete" -> "쿠폰이 삭제되었습니다.";
		case "couponDeleteBlocked" -> "이미 발급된 쿠폰은 삭제할 수 없습니다.";
		case "couponIssue" -> "회원에게 쿠폰이 발급되었습니다.";
		case "couponIssueFail" -> "쿠폰 발급에 실패했습니다. 회원번호 또는 중복 발급 여부를 확인해 주세요.";
		case "couponInvalid" -> "쿠폰 입력값을 확인해 주세요.";
		case "couponError" -> "쿠폰 처리 중 오류가 발생했습니다.";
		case "faqInsert" -> "FAQ가 등록되었습니다.";
		case "faqUpdate" -> "FAQ가 수정되었습니다.";
		case "faqDelete" -> "FAQ가 삭제되었습니다.";
		case "faqInvalid" -> "FAQ 입력값을 확인해 주세요.";
		case "faqError" -> "FAQ 처리 중 오류가 발생했습니다.";
		case "duplicate" -> "이미 사용 중인 아이디입니다.";
		case "selfDelete" -> "현재 로그인한 관리자 계정은 삭제할 수 없습니다.";
		case "invalid" -> "필수 입력값을 확인해 주세요.";
		default -> "회원 처리 중 오류가 발생했습니다.";
		};
	}

	private int parseInt(String value, int defaultValue) {
		try {
			return Integer.parseInt(value);
		} catch (Exception e) {
			return defaultValue;
		}
	}

	private Long parseLong(String value) {
		try {
			return Long.valueOf(value);
		} catch (Exception e) {
			return null;
		}
	}

	private String trimToDefault(String value, String defaultValue) {
		if (value == null || value.isBlank())
			return defaultValue;
		return value.trim();
	}

	private String trimToNull(String value) {
		return value == null || value.isBlank() ? null : value.trim();
	}

	private boolean isBlank(String value) {
		return value == null || value.isBlank();
	}
}
