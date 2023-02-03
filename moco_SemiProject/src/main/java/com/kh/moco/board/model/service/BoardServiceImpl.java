package com.kh.moco.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.board.model.dao.BoardDAO;
import com.kh.moco.board.model.vo.Board;
import com.kh.moco.board.model.vo.Reply;
import com.kh.moco.board.model.vo.Scrap;
import com.kh.moco.common.model.vo.PageInfo;



@Service("bService")
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private BoardDAO bDAO;
	
	@Override
	public ArrayList<Attachment> selectAttmList(int bId) {
		System.out.println("impl" + bId);
		return bDAO.selectAttmList(sqlSession, bId);
	}

	@Override
	public int deleteAttm(ArrayList<String> delRename) {
		return bDAO.deleteAttm(sqlSession, delRename);
	}
	
	@Override
	public void updateAttmLevel(int boardId) {
		bDAO.updateAttmLevel(sqlSession, boardId);
	}
	
	
	
	@Override
	public int insertBoard(Board b) {
		return bDAO.insertBoard(sqlSession, b);
	}
	
	@Override
	public Board selectBoard(int bId, boolean yn) {
		int result = 0;
		
		if(yn) {
			result = bDAO.addCount(sqlSession, bId);
		}
		Board b = bDAO.selectBoard(sqlSession, bId);
		
		return b;
	}
	
	@Override
	public int updateBoard(Board b) {
		return bDAO.updateBoard(sqlSession, b);
	}
	
	// 댓글 관련
	@Override
	public int insertReply(Reply r) {
		return bDAO.insertReply(sqlSession, r);
	}

	@Override
	public ArrayList<Reply> selectReply(int bId) {
		return bDAO.selectReply(sqlSession, bId);
	}

	@Override
	public int deleteBoard(int bId) {
		return bDAO.deleteBoard(sqlSession, bId);
	}

	// 파일 추가 보드
		@Override
		public int insertAttm(ArrayList<Attachment> list) {
			return bDAO.insertAttm(sqlSession, list);
		}
	
		// 스크랩 insert
		@Override
		public int insertScrap(Scrap s) {
			return bDAO.insertScrap(sqlSession,s);
		}
		
		// 스크랩 select
		@Override
		public ArrayList<Scrap> selectScrap(int bId, int memberNum) {
			return bDAO.selectScrap(sqlSession, bId, memberNum);
		}
	
	// 리스트메인카운트/화면
	@Override
	public int getListCountMain(HashMap<String, String> map) {
		return bDAO.getListCountMain(sqlSession, map);
	}
	@Override
	public ArrayList<Board> selectBoardListMain(PageInfo pi, HashMap<String, String> map) {
		return bDAO.selectBoardMain(sqlSession, pi, map);
	}
	
	// 카테고리 카운트/화면
	@Override
	public int getListCount(HashMap<String, String> map) {
		return bDAO.getListCount(sqlSession, map);
	}

	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi, HashMap<String, String> map) {
		return bDAO.selectBoardList(sqlSession, pi, map);
	}
	
	// 검색카운트/화면
	@Override
	public int getListCountSearch(HashMap<String, String> map) {
		return bDAO.getListCountSearch(sqlSession, map);
	}

	@Override
	public ArrayList<Board> selectBoardListSearch(PageInfo pi, HashMap<String, String> map ) {
		return bDAO.selectBoardListSearch(sqlSession, pi, map);
	}
	
	// 메인 5페이지
	@Override
	public ArrayList<Board> selectBoardListQMain(PageInfo pi, HashMap<String, String> map ) {
		return bDAO.selectBoardListQMain(sqlSession, pi, map);
	}
	
	@Override
	public ArrayList<Board> selectBoardListFMain(PageInfo pi, HashMap<String, String> map ) {
		return bDAO.selectBoardListFMain(sqlSession, pi, map);
	}
	
	@Override
	public ArrayList<Board> selectBoardListRMain(PageInfo pi, HashMap<String, String> map ) {
		return bDAO.selectBoardListRMain(sqlSession, pi, map);
	}
	
	//신고
	@Override
	public int reportBoard(int bId) {
		return bDAO.reportBoard(sqlSession, bId);
	}
	
	@Override
	public int reportBoardAdmin(int bId) {
		return bDAO.reportBoardAdmin(sqlSession, bId);
	}
	
	@Override
	public int reportBoardAdmin2(int bId) {
		return bDAO.reportBoardAdmin2(sqlSession, bId);
	}
	
}
