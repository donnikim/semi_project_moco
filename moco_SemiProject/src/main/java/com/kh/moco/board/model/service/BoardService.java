package com.kh.moco.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.board.model.vo.Board;
import com.kh.moco.board.model.vo.Reply;
import com.kh.moco.board.model.vo.Scrap;
import com.kh.moco.common.model.vo.PageInfo;

public interface BoardService {
	
	
	
	int insertBoard(Board b);
	
	Board selectBoard(int bId, boolean yn);

	ArrayList<Reply> selectReply(int bId);

	int insertReply(Reply r);

	int updateBoard(Board b);

	int deleteBoard(int bId);
	
	
	// 리스트 첫화면 카운트/리스트
	int getListCountMain(HashMap<String, String> map);

	ArrayList<Board> selectBoardListMain(PageInfo pi, HashMap<String, String> map);
	
	// 카테고리별 카운트/리스트
	int getListCount(HashMap<String, String> map);

	ArrayList<Board> selectBoardList(PageInfo pi, HashMap<String, String> map);
	
	// 검색 카운트/리스트
	int getListCountSearch(HashMap<String, String> map);
	
	ArrayList<Board> selectBoardListSearch(PageInfo pi, HashMap<String, String> map);

	
	
	
	//메인 리스트
	ArrayList<Board> selectBoardListQMain(PageInfo pi, HashMap<String, String> map);

	ArrayList<Board> selectBoardListFMain(PageInfo pi, HashMap<String, String> map);

	ArrayList<Board> selectBoardListRMain(PageInfo pi, HashMap<String, String> map);
	
	// 신고상태여부

	int reportBoard(int bId);
	
	// 신고확정
	int reportBoardAdmin(int bId);
	
	// 신고취소
	int reportBoardAdmin2(int bId);

	int insertAttm(ArrayList<Attachment> list);

	ArrayList<Attachment> selectAttmList(int bId);

	int deleteAttm(ArrayList<String> delRename);

	void updateAttmLevel(int boardNum);

	int insertScrap(Scrap s);

	ArrayList<Scrap> selectScrap(int bId, int i);






}
