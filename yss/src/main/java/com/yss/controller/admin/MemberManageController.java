package com.yss.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yss.dto.MemberDTO;
import com.yss.dto.SessionInfo;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
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

			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("page", page);
			mav.addObject("totalPage", totalPage);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			mav.addObject("memberStatus", memberStatus);
			mav.addObject("message", resultMessage(req.getParameter("result")));
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

			if (dto.getMemberId() == null || !isValid(dto, false))
				return redirect("invalid");
			if (service.checkUserIdExceptMember(dto.getUserId(), dto.getMemberId()) > 0) {
				return redirect("duplicate");
			}

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
		dto.setBankName(trimToNull(req.getParameter("bankName")));
		dto.setRefundAccount(trimToNull(req.getParameter("refundAccount")));
		dto.setAccountHolder(trimToNull(req.getParameter("accountHolder")));

		return dto;
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
