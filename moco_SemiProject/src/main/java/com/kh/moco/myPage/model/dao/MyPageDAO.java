package com.kh.moco.myPage.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.board.model.vo.Board;
import com.kh.moco.board.model.vo.Reply;
import com.kh.moco.common.model.vo.PageInfo;
import com.kh.moco.info.model.vo.Infomation;
import com.kh.moco.member.model.vo.Member;

@Repository ("myDAO")
public class MyPageDAO {

	
	// 마이페이지-----------------------------------------------
	// 내가 작성한 게시글
	public int getBoardListCount(SqlSessionTemplate sqlSession, String id) {
	
		
		int result=sqlSession.selectOne("myPageMapper.getBoardListCount", id);
		
		System.out.println(result);
		
		return result; 
	}

	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi, String id) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("myPageMapper.selectBoardList", id, rowBounds);
	}

	public ArrayList<Board> selectBoardPreview(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectBoardList", id);
	}

	
	// 내가 스크랩한 게시글
	public int getScrapListCount(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.selectOne("myPageMapper.getScrapListCount", id);
	}

	public ArrayList<Board> selectScrapList(SqlSessionTemplate sqlSession, PageInfo pi, String id) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("myPageMapper.selectScrapList", id, rowBounds);
	}

	public ArrayList<Board> selectScrapPreview(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectScrapList", id);
	}

	
	// 내가 작성한 댓글
	public int getReplyListCount(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.selectOne("myPageMapper.getReplyListCount", id);
	}

	public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlSession, PageInfo pi, String id) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("myPageMapper.selectReplyList", id, rowBounds);
	}

	public ArrayList<Reply> selectReplyPreview(SqlSessionTemplate sqlSession, String id) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectReplyList", id);
	}
	
	
	// 게시글 요청
	public int getMyInfoRequestListCount(SqlSessionTemplate sqlSession, int num) {
		return sqlSession.selectOne("myPageMapper.getMyInfoRequestListCount", num);
	}

	public ArrayList<Infomation> selectMyInfoRequestList(SqlSessionTemplate sqlSession, PageInfo pi, int num) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMyInfoRequestList", num, rowBounds);
	}
	
	public ArrayList<Infomation> selectMyInfoRequestPreview(SqlSessionTemplate sqlSession, int num) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMyInfoRequestList", num);
	}
	
	// 게시글 요청 상세보기
	public Infomation selectMyInfoDetail(SqlSessionTemplate sqlSession, int InfoNum) {
		return sqlSession.selectOne("myPageMapper.selectMyInfoDetail", InfoNum);
	}
	
	
	// 관리자페이지-----------------------------------------------
	// 게시글 요청
	public int getInfoRequestListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("myPageMapper.getInfoRequestListCount");
	}

	public ArrayList<Infomation> selectInfoRequestList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("myPageMapper.selectInfoRequestList", rowBounds);
	}
	
	public ArrayList<Infomation> selectInfoRequestPreview(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectInfoRequestList");
	}

	
	// 게시글 요청 상세보기
	public ArrayList<Attachment> selectAttmListDetail(SqlSessionTemplate sqlSession, int InfoNum) {
		ArrayList<Attachment> list = (ArrayList)sqlSession.selectList("myPageMapper.selectAttmListDetail", InfoNum);
		return list;
	}

	public Infomation selectInfoDetail(SqlSessionTemplate sqlSession, int InfoNum) {
		return sqlSession.selectOne("myPageMapper.selectInfoDetail", InfoNum);
	}
	
	
	// 회원 정보 관리
	public int getMemberListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("myPageMapper.getMemberListCount");
	}

	public ArrayList<Infomation> selectMemberList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMemberList",null ,rowBounds);
	}

	public ArrayList<Member> selectMember(SqlSessionTemplate sqlSession, int memberNum) {
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMember", memberNum);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("myPageMapper.updateMember", m);
	}

	public int confirmInfo(SqlSessionTemplate sqlSession, int infoNum) {
		return sqlSession.update("myPageMapper.confirmInfo", infoNum);
	}

	public int rejectInfo(SqlSessionTemplate sqlSession, int infoNum) {
		return sqlSession.update("myPageMapper.rejectInfo", infoNum);
	}
	
	
	// 신고 관리
	public ArrayList<Board> infoRequestPreReport(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("myPageMapper.infoRequestPreReport");
	}

	public int getMyInfoReportListView(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getMyInfoReportListView");
	}

	public ArrayList<Infomation> myInfoReportListView(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("myPageMapper.myInfoReportListView", null, rowBounds);
	}


	
}
