package com.yss.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.yss.dto.MemberDTO;
import com.yss.dto.SessionInfo;
import com.yss.mvc.annotation.GetMapping;
import com.yss.mvc.annotation.PostMapping;
import com.yss.mvc.annotation.Controller;
import com.yss.mvc.annotation.RequestMapping;
import com.yss.mvc.view.ModelAndView;
import com.yss.service.MemberService;
import com.yss.service.MemberServiceImpl;
import com.yss.mvc.annotation.ResponseBody;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	private MemberService service = new MemberServiceImpl();

	@GetMapping("login")
	public ModelAndView loginForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// 로그인 폼
		return new ModelAndView("member/login");
	}

	@PostMapping("login")
	public ModelAndView loginSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("===== loginSubmit 호출됨 =====");

		// 로그인 처리
		// 세션객체. 세션 정보는 서버에 저장(로그인 정보, 권한등을 저장)
		HttpSession session = req.getSession();

		try {
			String userId = req.getParameter("userId");
			String password = req.getParameter("password");

			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("password", password);

			MemberDTO dto = service.loginMember(map);

			if (dto == null) {
				// 로그인 실패인 경우
				ModelAndView mav = new ModelAndView("member/login");

				String msg = "아이디 또는 패스워드가 일치하지 않습니다.";
				mav.addObject("message", msg);

				return mav;
			}
			// 로그인 성공 : 로그인정보를 서버에 저장
			// 세션의 유지시간을 20분설정(기본 30분)
			session.setMaxInactiveInterval(20 * 60);

			// 세션에 저장할 내용
			SessionInfo info = new SessionInfo();
			info.setMemberId(dto.getMemberId());
			info.setUserId(dto.getUserId());
			info.setName(dto.getName());
			info.setRole(dto.getRole());

			// 세션에 member이라는 이름으로 저장
			session.setAttribute("member", info);

			String preLoginURI = (String) session.getAttribute("preLoginURI");
			session.removeAttribute("preLoginURI");
			if (preLoginURI != null) {
				// 로그인 전페이지로 리다이렉트
				return new ModelAndView(preLoginURI);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 메인 화면으로 리다이렉트
		return new ModelAndView("redirect:/");
	}

	@GetMapping("logout")
	public ModelAndView logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그아웃
		HttpSession session = req.getSession();

		// 세션에 저장된 정보를 지운다.
		session.removeAttribute("member");

		// 세션에 저장된 모든 정보를 지우고 세션을 초기화 한다.
		session.invalidate();

		return new ModelAndView("redirect:/");
	}

	@ResponseBody
	@GetMapping("checkId")
	public Map<String, Object> checkId(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Map<String, Object> model = new HashMap<>();

		try {
			// 현재 join.jsp의 name이 memberId라서 이렇게 받음
			String userId = req.getParameter("memberId");

			int count = service.checkUserId(userId);

			if (count == 0) {
				model.put("available", true);
				model.put("message", "사용 가능한 아이디입니다.");

			} else {
				model.put("available", false);
				model.put("message", "이미 사용 중인 아이디입니다.");
			}

		} catch (Exception e) {
			model.put("available", false);
			model.put("message", "아이디 확인 중 오류가 발생했습니다.");

			e.printStackTrace();
		}
		return model;
	}

	@PostMapping("join")
	public ModelAndView joinSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try {
			String userId = req.getParameter("memberId");
			String password = req.getParameter("password");
			String passwordConfirm = req.getParameter("passwordConfirm");
			String name = req.getParameter("memberName");
			String email = req.getParameter("email");
			String phone = req.getParameter("phone");
			String zip = req.getParameter("postalCode");
			String addr1 = req.getParameter("address");
			String addr2 = req.getParameter("addressDetail");
			String birth = req.getParameter("birthDate");

			// 필수값 검사
			if (userId == null || userId.isBlank() || password == null || password.isBlank() || name == null
					|| name.isBlank() || email == null || email.isBlank() || phone == null || phone.isBlank()
					|| zip == null || zip.isBlank() || addr1 == null || addr1.isBlank() || addr2 == null
					|| addr2.isBlank() || birth == null || birth.isBlank()) {

				ModelAndView mav = new ModelAndView("member/join");
				mav.addObject("joinError", "필수 항목을 모두 입력해 주세요.");

				return mav;
			}

			// 비밀번호 확인
			if (!password.equals(passwordConfirm)) {
				ModelAndView mav = new ModelAndView("member/join");
				mav.addObject("joinError", "비밀번호가 일치하지 않습니다.");

				return mav;
			}

			// 서버에서도 아이디 중복확인
			if (service.checkUserId(userId) > 0) {
				ModelAndView mav = new ModelAndView("member/join");
				mav.addObject("joinError", "이미 사용 중인 아이디입니다.");

				return mav;
			}
			MemberDTO dto = new MemberDTO();

			dto.setUserId(userId);
			dto.setPassword(password);
			dto.setName(name);
			dto.setEmail(email);
			dto.setPhone(phone);
			dto.setBirth(birth);

			dto.setZip(zip);
			dto.setAddr1(addr1);
			dto.setAddr2(addr2);

			service.insertMember(dto);

		} catch (Exception e) {
			e.printStackTrace();
			ModelAndView mav = new ModelAndView("member/join");
			mav.addObject("joinError", "회원가입 처리 중 오류가 발생했습니다.");

			return mav;
		}
		// 회원가입 성공 → 로그인 화면
		return new ModelAndView("redirect:/member/login");
	}

	@GetMapping("findId")
	public ModelAndView findIdForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		return new ModelAndView("member/findId");
	}

	@PostMapping("findId")
	public ModelAndView findIdSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("member/findId");

		try {
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			MemberDTO dto = service.findUserId(name, email);

			if (dto == null) {
				mav.addObject("message", "입력하신 정보와 일치하는 회원이 없습니다.");
			} else {
				mav.addObject("foundUserId", dto.getUserId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("message", "아이디 찾기 중 오류가 발생했습니다.");
		}
		return mav;
	}

	@GetMapping("findPassword")
	public ModelAndView findPasswordForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		return new ModelAndView("member/findPassword");
	}

	@PostMapping("findPassword")
	public ModelAndView findPasswordSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		ModelAndView mav = new ModelAndView("member/findPassword");

		try {
			String userId = req.getParameter("userId");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			String passwordConfirm = req.getParameter("passwordConfirm");

			// 비밀번호 일치 확인
			if (password == null || !password.equals(passwordConfirm)) {
				mav.addObject("message", "새 비밀번호가 일치하지 않습니다.");

				return mav;
			}
			// 가입회원 확인
			boolean result = service.checkMemberForPassword(userId, name, email);

			if (!result) {
				mav.addObject("message", "입력하신 정보와 일치하는 회원이 없습니다.");

				return mav;
			}
			// 비밀번호 변경
			service.updatePassword(userId, password);

			mav.addObject("success", true);

		} catch (Exception e) {

			e.printStackTrace();
			mav.addObject("message", "비밀번호 변경 중 오류가 발생했습니다.");
		}
		return mav;
	}
}
