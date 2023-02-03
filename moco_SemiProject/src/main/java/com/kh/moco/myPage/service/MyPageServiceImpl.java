package com.kh.moco.myPage.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.board.model.vo.Board;
import com.kh.moco.board.model.vo.Reply;
import com.kh.moco.common.model.vo.PageInfo;
import com.kh.moco.info.model.vo.Infomation;
import com.kh.moco.member.model.vo.Member;
import com.kh.moco.myPage.model.dao.MyPageDAO;

@Service("myService")
public class MyPageServiceImpl implements MyPageService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MyPageDAO myDAO;
	
	
	// 마이페이지-----------------------------------------------
	// 내가 작성한 게시글
	@Override
	public int getBoardListCount(String id) {
		return myDAO.getBoardListCount(sqlSession, id);
	}

	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi, String id) {
		return myDAO.selectBoardList(sqlSession, pi, id);
	}

	@Override
	public ArrayList<Board> selectBoardPreview(String id) {
		return myDAO.selectBoardPreview(sqlSession, id);
	}
	
	

	// 내가 스크랩한 게시글
	@Override
	public int getScrapListCount(String id) {
		return myDAO.getScrapListCount(sqlSession, id);
	}

	@Override
	public ArrayList<Board> selectScrapList(PageInfo pi, String id) {
		return myDAO.selectScrapList(sqlSession, pi, id);
	}

	@Override
	public ArrayList<Board> selectScrapPreview(String id) {
		return myDAO.selectScrapPreview(sqlSession, id);
	}

	
	
	// 내가 작성한 댓글
	@Override
	public int getReplyListCount(String id) {
		return myDAO.getReplyListCount(sqlSession, id);
	}

	@Override
	public ArrayList<Reply> selectReplyList(PageInfo pi, String id) {
		return myDAO.selectReplyList(sqlSession, pi, id);
	}

	@Override
	public ArrayList<Reply> selectReplyPreview(String id) {
		return myDAO.selectReplyPreview(sqlSession, id);
	}

	
	
	// 게시글 요청 
	@Override
	public int getMyInfoRequestListCount(int num) {
		return myDAO.getMyInfoRequestListCount(sqlSession, num);
	}

	@Override
	public ArrayList<Infomation> selectMyInfoRequestList(PageInfo pi, int num) {
		return myDAO.selectMyInfoRequestList(sqlSession, pi, num);
	}

	@Override
	public ArrayList<Infomation> selectMyInfoRequestPreview(int num) {
		return myDAO.selectMyInfoRequestPreview(sqlSession, num);
	}
	
	// 게시글 요청 상세보기
	@Override
	public Infomation selectMyInfoDetail(int InfoNum) {
		return myDAO.selectMyInfoDetail(sqlSession, InfoNum);
	}
	
	
	
	// 관리자페이지-----------------------------------------------
	// 게시글 요청
	@Override
	public int getInfoRequestListCount() {
		return myDAO.getInfoRequestListCount(sqlSession);
	}

	@Override
	public ArrayList<Infomation> selectInfoRequestList(PageInfo pi) {
		return myDAO.selectInfoRequestList(sqlSession, pi);
	}

	@Override
	public ArrayList<Infomation> selectInfoRequestPreview() {
		return myDAO.selectInfoRequestPreview(sqlSession);
	}

	
	
	// 게시글 요청 상세보기
	@Override
	public Infomation selectInfoDetail(int InfoNum) {
		return myDAO.selectInfoDetail(sqlSession, InfoNum);
	}

	@Override
	public ArrayList<Attachment> selectAttmListDetail(int InfoNum) {
		return myDAO.selectAttmListDetail(sqlSession, InfoNum) ;
	}
	
	@Override
	public int confirmInfo(int infoNum) {
		return myDAO.confirmInfo(sqlSession, infoNum);
	}
	
	@Override
	public int rejectInfo(int infoNum) {
		return myDAO.rejectInfo(sqlSession, infoNum);
	}

	
	// 회원 정보 요청
	@Override
	public int getMemberListCount() {
		return myDAO.getMemberListCount(sqlSession);
	}

	@Override
	public ArrayList<Infomation> selectMemberList(PageInfo pi) {
		return myDAO.selectMemberList(sqlSession, pi);
	}

	@Override
	public ArrayList<Member> selectMember(int memberNum) {
		return myDAO.selectMember(sqlSession, memberNum);
	}

	@Override
	public int updateMember(Member m) {
		return myDAO.updateMember(sqlSession, m);
	}

	
	// 신고 관리
	@Override
	public ArrayList<Board> infoRequestPreReport() {
		return myDAO.infoRequestPreReport(sqlSession);
	}
	
	@Override
	public int getMyInfoReportListView() {
		return myDAO.getMyInfoReportListView(sqlSession);
	}

	@Override
	public ArrayList<Infomation> myInfoReportListView(PageInfo pi) {
		return myDAO.myInfoReportListView(sqlSession, pi);
	}

	

}
