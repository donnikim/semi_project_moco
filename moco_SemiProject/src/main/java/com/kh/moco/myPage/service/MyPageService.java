package com.kh.moco.myPage.service;

import java.util.ArrayList;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.board.model.vo.Board;
import com.kh.moco.board.model.vo.Reply;
import com.kh.moco.common.model.vo.PageInfo;
import com.kh.moco.info.model.vo.Infomation;
import com.kh.moco.member.model.vo.Member;

public interface MyPageService {

	// 마이페이지-----------------------------------------------
	// 내가 작성한 게시글
	int getBoardListCount(String id);

	ArrayList<Board> selectBoardList(PageInfo pi, String id);

	ArrayList<Board> selectBoardPreview(String id);

	
	// 내가 스크랩한 게시글
	int getScrapListCount(String id);

	ArrayList<Board> selectScrapList(PageInfo pi, String id);

	ArrayList<Board> selectScrapPreview(String id);

	
	// 내가 작성한 댓글
	int getReplyListCount(String id);

	ArrayList<Reply> selectReplyList(PageInfo pi, String id);

	ArrayList<Reply> selectReplyPreview(String id);

	
	// 게시글 요청
	int getMyInfoRequestListCount(int num);

	ArrayList<Infomation> selectMyInfoRequestList(PageInfo pi, int num);

	ArrayList<Infomation> selectMyInfoRequestPreview(int num);
	
	Infomation selectMyInfoDetail(int InfoNum);

	
	
	// 관리자페이지-----------------------------------------------
	// 게시글 요청
	int getInfoRequestListCount();

	ArrayList<Infomation> selectInfoRequestList(PageInfo pi);

	ArrayList<Infomation> selectInfoRequestPreview();

	
	// 게시글 요청 상세보기
	Infomation selectInfoDetail(int InfoNum);

	ArrayList<Attachment> selectAttmListDetail(int InfoNum);
	
	int confirmInfo(int infoNum);

	int rejectInfo(int infoNum);
	
	
	// 회원 정보 요청
	int getMemberListCount();

	ArrayList<Infomation> selectMemberList(PageInfo pi);

	ArrayList<Member> selectMember(int memberNum);

	int updateMember(Member m);


	// 신고 관리
	int getMyInfoReportListView();

	ArrayList<Board> infoRequestPreReport();

	ArrayList<Infomation> myInfoReportListView(PageInfo pi);


}
