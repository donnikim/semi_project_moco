package com.kh.moco.member.controller;

import java.util.HashMap;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.kh.moco.member.exception.MemberException;
import com.kh.moco.member.model.service.KakaoService;
import com.kh.moco.member.model.service.MemberService;
import com.kh.moco.member.model.vo.Member;

@SessionAttributes({"loginUser", "access_Token"})
@Controller
public class MemberController {
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@Autowired
	private KakaoService kService;
	
	
	// 로그인 페이지 이동
	@RequestMapping(value="loginView.me")
	public String loginView() {
		return "login";
	}
	
	// 회원가입 페이지 이동
	@RequestMapping("enrollView.me")
	public String enroll() {
		return "enroll";
	}
	
	// 회원가입
	@RequestMapping("insertMember.me")
	public String insertMember(@ModelAttribute Member m) {
		System.out.println(m);
				
		if(m.getMemberPwd()== null) {
			m.setMemberPwd("1111");
			m.setMemberName(m.getMemberNickName());
		}
		System.out.println(m);
		
		String encPwd = bcrypt.encode(m.getMemberPwd());
		m.setMemberPwd(encPwd);
		
		int result = mService.insertMember(m);
		
		if(result > 0) {
			return "redirect:home.do";
		}else {
			throw new MemberException("회원가입에 실패하였습니다.");
		}
	}
	
	// 로그인
	@RequestMapping(value="login.me", method=RequestMethod.POST)
	public String login(@ModelAttribute Member m, Model model) {
		System.out.println(m);
		Member loginUser = mService.login(m);
		System.out.println(loginUser);
		
		if(loginUser != null) {
			if(bcrypt.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {
				model.addAttribute("loginUser", loginUser);
				return "redirect:home.do";
			} else {
				throw new MemberException("로그인에 실패하였습니다.");
			}
		} else {
			throw new MemberException("일치하는 회원정보가 없습니다.");
		}
	}
	// 아이디 중복검사
	@RequestMapping("checkId.me")
	@ResponseBody
	public String checkId(@RequestParam("id") String id) {
		
		int count = mService.checkId(id);
		
		String result = count == 0? "yes" : "no";
		
		return result;
	}
	
	// 닉네임 중복검사
	@RequestMapping("checkNickName.me")
	@ResponseBody
	public String checkNickName(@RequestParam("nickName") String nickName) {
		int count = mService.checkNickName(nickName);
		
		String result = count == 0 ? "yes" : "no";
		
		return result;
	}	

	// 마이페이지 가기
	@RequestMapping("myPage.me")
	public String myPage() {
		return "../myPage/myPage";
	}
	
	// 내 정보 수정 페이지 가기
	@RequestMapping("editInfo.me")
	public String myInfo() {
		
		return "../myPage/editInfo";
	}
	
	// 내 정보 수정
	@RequestMapping("updateMember.me")
	public String updateMember(@ModelAttribute Member m, HttpSession session, Model model) {
//			@RequestParam("currPwd") String currPwd,
							
		int result = 0;
		Member mem = (Member)session.getAttribute("loginUser");
		
		m.setMemberId(mem.getMemberId());
		
		if(m.getMemberPwd().trim() == "") {
			m.setMemberPwd(mem.getMemberPwd());
		}else {
			m.setMemberPwd(bcrypt.encode(m.getMemberPwd()));
		}

		result = mService.updateMember(m);
		
		if(result > 0) {
			model.addAttribute("loginUser", mService.login(m));
			return "../myPage/myPage";
		} else{ 
			throw new MemberException("회원 수정을 실패하였습니다.");
		}
		
	}
	
	// 아이디 찾기 페이지 가기
	@RequestMapping("searchIdView.me")
	public String searchIdView() {
		return "searchIdView";
	}
	
	// 아이디 찾기
	@RequestMapping(value="searchId.me", method=RequestMethod.POST)
	public ModelAndView searchId(@ModelAttribute Member m, ModelAndView mv) {
		
		Member mem = mService.searchId(m);
		
		mv.addObject("mem", mem);
		mv.setViewName("searchId");
		
		return mv;
	}
	
	// 비밀번호 찾기 페이지 가기
	@RequestMapping("searchPwdView.me")
	public String searchPwdView() {
		return "searchPwdView";
	}
	
	// 비밀번호 찾기. 이름&이메일로 회원유무 조회 
	@RequestMapping("searchPwd.me")
	public ModelAndView searchPwd(@ModelAttribute Member m, ModelAndView mv) {
		
		System.out.println(m);
		
		Member mem = mService.searchPwd(m);
		
		if(mem == null) {
			mv.addObject("yn", "N");
			mv.addObject("msg", "일치하는 회원정보가 존재하지 않습니다.");
			mv.setViewName("searchPwdEnd");
		} else {
			mv.addObject("pwdMember", mem);
			mv.setViewName("searchPwd");
		}
		return mv;
	}
	
	// 비밀번호 찾기 -> 비밀번호 변경
	@RequestMapping(value="updatePwd.me", method = RequestMethod.POST)
	public ModelAndView updatePwd(@RequestParam("memberPwd") String newPwd, @ModelAttribute Member mem,
							ModelAndView mv) {
		
		System.out.println(mem);
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("memberId", mem.getMemberId());
		map.put("encPwd", bcrypt.encode(newPwd));
		int result = mService.updatePwd(map);
		
		if(result > 0) {
			mv.addObject("yn", "Y");
			mv.addObject("msg", "비밀번호 변경이 완료되었습니다. ");
			mv.setViewName("searchPwdEnd");
		} else {
			throw new MemberException("비밀번호 변경을 실패하였습니다.");
		}
		
		return mv;
	}
	
	// 회원가입 시 이메일 중복 확인
	@RequestMapping("searchEmail.me")
	@ResponseBody
	public String searchEmail(@RequestParam("memberEmail") String memberEmail){
		
		int count = mService.searchEmail(memberEmail);
		
		String result = count == 0 ? "yes" : "no";
		
		return result;
	}

	@RequestMapping("deleteMember.me")
	public String deleteMember(Model model) {
		String memberId = ((Member)model.getAttribute("loginUser")).getMemberId();
		
		int result = mService.deleteMember(memberId);
		System.out.println("8888888·."+result);
		
		if(result > 0) {
			return "redirect:logout.me";
		} else {
			throw new MemberException("회원탈퇴에 실패하였습니다.");
		}
		
	}
	
//  --------------------------------- 이메일 인증 --------------------------------------	
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNumber;

	@RequestMapping("checkEmail.me")
	@ResponseBody
	public String checkEmail(@RequestParam("memberEmail") String email) {
		System.out.println("이메일인증 : " + email);
		
		return joinEmail(email);
//		return "바보";
	}
	
	public void makeRandomNumber() {
		Random r = new Random();
		// 난수 범위 111111 ~999999
		int checkNum = r.nextInt(888888)+111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
	}
	
	public String joinEmail(String email) {
		System.out.println("joinEmail들어옴");
		makeRandomNumber();
		String setFrom = "mococo8080@gmail.com";
		String toMail = email;
		String title = "MOCO 비밀번호 찾기 인증 이메일입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다.<br><br> 인증번호는 " + authNumber + " 입니다.<br> 해당 인증번호를 인증번호 확인란에 기입하여주세요";
		
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}
	
	public void mailSend(String setFrom, String toMail, String title, String content) {
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"UTF-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
//	--------------------------------- 이메일 인증 ---------------------------------------
	
	
	   // 카카오 로그인
    @RequestMapping(value = "kakaoLogin.me", method = RequestMethod.GET)
//  카카오 developer에서 보내준 code를 받아올 수 있는 redirect 주소를 받아줌.  
    public String kakaoLogin(@RequestParam("code") String code, /*HttpSession session,*/ Model model){
//     코드를 잘 받아왔는지 확인
     String access_Token = kService.getAcessToken(code); // 코드보내고 토큰값 얻어오기
     HashMap<String,Object> userInfo = kService.getUserInfo(access_Token);

    Member mem = new Member();
      mem.setMemberId((String)userInfo.get("kakao_id"));
      mem.setMemberNickName((String)userInfo.get("nickname"));
      mem.setMemberEmail((String)userInfo.get("email"));
      mem.setMemberName((String)userInfo.get("kakao_id"));
    
      if(mService.checkId((String)userInfo.get("kakao_id"))>0){
         mem.setMemberPwd((String)userInfo.get("kakao_id"));
      }else {
         mem.setMemberPwd(bcrypt.encode((String)userInfo.get("kakao_id")));
         mService.insertMember(mem);
         mem.setMemberPwd((String)userInfo.get("kakao_id"));
      }
      
   Member loginUser = mService.login(mem);
   
   System.out.println("로그인카카오 : "+loginUser);
   if(loginUser != null) {
      if(bcrypt.matches(mem.getMemberPwd(), loginUser.getMemberPwd())) {
         model.addAttribute("loginUser", loginUser);
         return "redirect:home.do";
      } else {
         throw new MemberException("로그인에 실패하였습니다.");
      }
   } else {
      throw new MemberException("일치하는 회원정보가 없습니다.");
   }  
      
  }

    @RequestMapping("logout.me")
    public String logout(HttpSession session, SessionStatus status,Model model) {
    	System.out.println(123);
        String access_Token = (String)session.getAttribute("access_Token");

        if(access_Token != null && !"".equals(access_Token)){
            kService.kakaoLogout(access_Token);
            session.removeAttribute("access_Token");
//            session.removeAttribute("loginUser");
            session.invalidate();
            status.setComplete();
            return "redirect:home.do";
            
        }else{
            System.out.println("access_Token is null");
            status.setComplete();
            return "redirect:home.do";
            //return "redirect:/";
        }
        //return "index";
//        return "../home";
    }    
    
    
//    @GetMapping("/movehome.me")
//    public String moveHome() {
//    	return "../home";
//    }

    
}
