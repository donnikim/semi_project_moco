package com.kh.moco.myPage.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.board.exception.BoardException;
import com.kh.moco.board.model.vo.Board;
import com.kh.moco.board.model.vo.Reply;
import com.kh.moco.common.Pagination;
import com.kh.moco.common.model.vo.PageInfo;
import com.kh.moco.info.model.exception.InfoException;
import com.kh.moco.info.model.vo.Infomation;
import com.kh.moco.member.exception.MemberException;
import com.kh.moco.member.model.vo.Member;
import com.kh.moco.myPage.exception.MyPageException;
import com.kh.moco.myPage.service.MyPageService;

@SessionAttributes("loginUser")
@Controller
public class MyPageController {
	
	@Autowired
	private MyPageService myService;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	
	// 마이페이지 --------------------------------------------------------------------
	// 마이페이지 이동 -> 하면서 5개씩 띄우기
	@RequestMapping(value="myPageView.my")
	public String myPageView(Model model, HttpSession session) {
		String id = ((Member)session.getAttribute("loginUser")).getMemberId();
		int num = ((Member)session.getAttribute("loginUser")).getMemberNum();
		
		ArrayList<Board> boardPreview = myService.selectBoardPreview(id);
		ArrayList<Board> scrapPreview = myService.selectScrapPreview(id);
		ArrayList<Reply> replyPreview = myService.selectReplyPreview(id);
		ArrayList<Infomation> infoRequestPreview = myService.selectMyInfoRequestPreview(num);
		System.out.println(boardPreview);
		System.out.println(scrapPreview);
		
		if(boardPreview != null && scrapPreview != null) {
			model.addAttribute("boardPreview", boardPreview);
			model.addAttribute("scrapPreview", scrapPreview);
			model.addAttribute("replyPreview", replyPreview);
			model.addAttribute("infoRequestPreview", infoRequestPreview);
			return "myPage";
		} else {
			throw new BoardException("게시글 조회 실패");
		}
	}
	
	
	
	// 마이페이지 - 최근게시글 리스트 가져오기
	@RequestMapping("myBoardListView.my")
	public String selectBoardList(@RequestParam(value="page", required=false) Integer page, Model model, HttpSession session) {
		String id = ((Member)session.getAttribute("loginUser")).getMemberId();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getBoardListCount(id);
		
		System.out.println(id);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);
		
		ArrayList<Board> boardList = myService.selectBoardList(pi, id);
		System.out.println(pi);
		System.out.println(id);
		
		if(boardList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("boardList", boardList);
			return "myBoardList";
		} else {
			throw new BoardException("게시글 조회 실패");
		}
	}
	
	
	
	// 마이페이지 - 찜한 게시글 가져오기
	@RequestMapping("myScrapListView.my")
	public String selectScrapList(@RequestParam(value="page", required=false) Integer page, Model model, HttpSession session) {
		String id = ((Member)session.getAttribute("loginUser")).getMemberId();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getScrapListCount(id);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);
		
		ArrayList<Board> scrapList = myService.selectScrapList(pi, id);
		System.out.println(pi);
		System.out.println(id);
		
		if(scrapList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("scrapList", scrapList);
			return "myScrapList";
		} else {
			throw new MyPageException("찜한글 조회 실패");
		}
	}
	
	
	
	// 마이페이지 - 게시글 요청 가져오기
	@RequestMapping("myInfoRequestListView.my")
	public String selectMyInfoRequestList(@RequestParam(value="page", required=false) Integer page, Model model, HttpSession session) {
		int num = ((Member)session.getAttribute("loginUser")).getMemberNum();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getMyInfoRequestListCount(num);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);
		
		ArrayList<Infomation> infoRequestList = myService.selectMyInfoRequestList(pi, num);
		
		if(infoRequestList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("infoRequestList", infoRequestList);
			return "myInfoRequestList";
		} else {
			throw new MyPageException("게시글 요청 조회 실패");
		}
	}
	
	
//	 마이페이지 - 게시글 요청 상세보기
	@RequestMapping("InfoRequestDetail.my")
	public ModelAndView MySelectAttm(@RequestParam("InfoNum") int InfoNum, ModelAndView mv, HttpSession session) {
		int num = ((Member)session.getAttribute("loginUser")).getMemberNum();

		Infomation info = myService.selectMyInfoDetail(InfoNum);
		
//		ArrayList<Attachment> list = myService.selectAttmListDetail(InfoNum);
		System.out.println(InfoNum);
		System.out.println(info);
		
		if(info != null) {
			mv.addObject("info", info).setViewName("myInfoRequestDetail");
		} else {
			throw new InfoException("첨부파일 게시글 상세보기 실패");
		}
		return  mv;
	}
	
	
	
	// 마이페이지 - 작성한 댓글 가져오기
	@RequestMapping("myReplyListView.my")
	public String selectReplyList(@RequestParam(value="page", required=false) Integer page, Model model, HttpSession session) {
		String id = ((Member)session.getAttribute("loginUser")).getMemberId();
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getReplyListCount(id);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);
		
		ArrayList<Reply> replyList = myService.selectReplyList(pi, id);
		
		if(replyList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("replyList", replyList);
			return "myReplyList";
		} else {
			throw new MyPageException("댓글 조회 실패");
		}
	}



	// 관리자페이지 --------------------------------------------------------------------
	// 관리자페이지 이동 -> 하면서 5개씩 띄우기
	@RequestMapping(value="managerPageView.my")
	public String managerPageView(Model model) {
		
		ArrayList<Infomation> infoRequestPreview = myService.selectInfoRequestPreview();
		ArrayList<Board> infoRequestPreReport = myService.infoRequestPreReport();

		if(infoRequestPreview != null) {
			model.addAttribute("infoRequestPreview", infoRequestPreview);
			model.addAttribute("infoRequestPreReport", infoRequestPreReport);
			return "managerPage";
		} else {
			throw new BoardException("게시글 요청 실패");
		}
	}
	
	
	// 관리자페이지 - 게시글 요청 리스트
	@RequestMapping("InfoRequestListView.my")
	public String selectInfoRequestList(@RequestParam(value="page", required=false) Integer page, Model model, HttpSession session) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getInfoRequestListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);
		
		ArrayList<Infomation> infoRequestList = myService.selectInfoRequestList(pi);
		
		if(infoRequestList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("infoRequestList", infoRequestList);
			return "infoRequestList";
		} else {
			throw new BoardException("게시글 요청 조회 실패");
		}
	}
	
	
	// 관리자페이지 - 게시글 요청 상세보기
	@RequestMapping("selectAttm.my")
	public ModelAndView selectAttm(@RequestParam("InfoNum") int InfoNum, ModelAndView mv) {

		Infomation info = myService.selectInfoDetail(InfoNum);
		
		ArrayList<Attachment> list = myService.selectAttmListDetail(InfoNum);
		System.out.println(InfoNum);
		System.out.println(info);
		System.out.println(list);
		
		if(info != null) {
			mv.addObject("info", info).addObject("list", list).setViewName("infoRequestDetail");
		} else {
			throw new InfoException("첨부파일 게시글 상세보기 실패");
		}
		return  mv;
	}

	
	// 관리자페이지 - 게시글 요청 승인하기
	@RequestMapping("confirmInfo.my")
	public String confirmInfo(@RequestParam("infoNum") int infoNum, Model model) {
		
		int result = 0;
		result = myService.confirmInfo(infoNum);
		
		int listCount = myService.getInfoRequestListCount();
		PageInfo pi = Pagination.getPageInfo(1, listCount, 10);
		ArrayList<Infomation> infoRequestList = myService.selectInfoRequestList(pi);
		
		if(result > 0) {
			model.addAttribute("pi", pi);
			model.addAttribute("infoRequestList", infoRequestList);
			return "infoRequestList";
		} else { 
			throw new MyPageException("게시글 승인을 실패하였습니다.");
		}
	}

	
	// 관리자페이지 - 게시글 요청 거절하기
	@RequestMapping("rejectInfo.my")
	public String rejectInfo(@RequestParam("infoNum") int infoNum, Model model) {
		
		int result = 0;
		result = myService.rejectInfo(infoNum);
				
		int listCount = myService.getInfoRequestListCount();
		PageInfo pi = Pagination.getPageInfo(1, listCount, 10);
		ArrayList<Infomation> infoRequestList = myService.selectInfoRequestList(pi);

		if(result > 0) {
			model.addAttribute("pi", pi);
			model.addAttribute("infoRequestList", infoRequestList);
			return "infoRequestList";
		} else { 
			throw new MyPageException("게시글 거절을 실패하였습니다.");
		}
	}
	
	
	// 관리자페이지 - 회원관리 리스트
	@RequestMapping("memberManagement.my")
	public String memberManagement(@RequestParam(value="page", required=false) Integer page, Model model, HttpSession session) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getMemberListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);
		
		ArrayList<Infomation> memberList = myService.selectMemberList(pi);
		
		if(memberList != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("memberList", memberList);
			return "memberList";
		} else {
			throw new MyPageException("회원 정보 요청 조회 실패");
		}
	}	
	
	
	// 관리자페이지 - 회원관리 수정페이지
	@RequestMapping("memberDetail.my")
	public String memberDatail(@RequestParam("memberNum") int memberNum, Model model) {
		
		System.out.println(memberNum);
		ArrayList<Member> memberList = myService.selectMember(memberNum);

		if(memberList != null) {
			model.addAttribute("memberList", memberList);
			return "memberEdit";
		} else {
			throw new MyPageException("회원 정보 조회 실패");
		}
	}
	
	
	// 관리자페이지 - 회원관리 수정하기
	@RequestMapping("memberEdit.my")
	public String updateMember(@ModelAttribute Member m, HttpSession session, Model model) {
							
		int result = 0;
		Member mem = m;

		result = myService.updateMember(m);
		ArrayList<Member> memberList = new ArrayList<Member>();
		memberList.add(m);
		
		if(result > 0) {
			return "memberEdit";
		} else{ 
			throw new MemberException("회원 수정을 실패하였습니다.");
		}
		
	}
	
		
	// 관리자페이지 - 신고 관리
	@RequestMapping("myInfoReportListView.my")
	public String myInfoReportListView(@RequestParam(value="page", required=false) Integer page, Model model, HttpSession session) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int listCount = myService.getMyInfoReportListView();
		
		System.out.println(listCount);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);
		
		ArrayList<Infomation> myInfoReportListView = myService.myInfoReportListView(pi);
		
		
		if(myInfoReportListView != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("myInfoReportListView", myInfoReportListView);
			return "reportList";
		} else {
			throw new BoardException("신고 관리 조회 실패");
		}
	}
	
	
}
