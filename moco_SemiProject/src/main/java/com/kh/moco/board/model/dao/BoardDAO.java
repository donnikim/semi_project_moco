package com.kh.moco.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.board.model.vo.Board;
import com.kh.moco.board.model.vo.Reply;
import com.kh.moco.board.model.vo.Scrap;
import com.kh.moco.common.model.vo.PageInfo;

@Repository("bDAO")
public class BoardDAO {
	
	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}

	public int addCount(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.update("boardMapper.updateCount", bId);
	}
	
	public Board selectBoard(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.selectOne("boardMapper.selectBoard", bId);
	}
	
	
	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateBoard", b);
	}

	// 댓글 관련
	public ArrayList<Reply> selectReply(SqlSessionTemplate sqlSession, int bId) {
//		ArrayList<Reply> list = (ArrayList)sqlSession.selectList("boardMapper.selectReply", bId);
		return (ArrayList)sqlSession.selectList("boardMapper.selectReply", bId);
	}
	
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.update("boardMapper.insertReply", r);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.update("boardMapper.deleteBoard", bId);
	}

	// attachment 파일 insert
    public int insertAttm(SqlSessionTemplate sqlSession, ArrayList<Attachment> list) {
    	System.out.println("dao "+list);
        return sqlSession.insert("boardMapper.insertAttm", list);
    }

    public ArrayList<Attachment> selectAttmList(SqlSessionTemplate sqlSession, Integer bId) {
    	ArrayList<Attachment> result = (ArrayList)sqlSession.selectList("boardMapper.selectAttm", bId);
    	System.out.println("DAO : " + result);
		return (ArrayList)sqlSession.selectList("boardMapper.selectAttm", bId);
    }
	
	public int deleteAttm(SqlSessionTemplate sqlSession, ArrayList<String> delRename) {
		return sqlSession.delete("boardMapper.deleteAttm", delRename);
	}

	public void updateAttmLevel(SqlSessionTemplate sqlSession, int boardId) {
		sqlSession.update("boardMapper.updateAttmLevel", boardId);
	}
	
	
	
	
	// 리스트메인 카운트/화면창
	public int getListCountMain(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("boardMapper.getListCountMain",map);
	}
	public ArrayList<Board> selectBoardMain(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
  		
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardListMain", map, rowBounds);
	}
	
	
	// 카테고리 카운트/화면창
	public int getListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return sqlSession.selectOne("boardMapper.getListCount",map);
	}
	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
  		
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", map, rowBounds);
	}
	
	// 검색 카운트/화면창
	public int getListCountSearch(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("boardMapper.getListCountSearch",map);
	}
	public ArrayList<Board> selectBoardListSearch(SqlSessionTemplate sqlSession, PageInfo pi,
			HashMap<String, String> map) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardListSearch", map, rowBounds);
	}

	public ArrayList<Board> selectBoardListQMain(SqlSessionTemplate sqlSession, PageInfo pi,
			HashMap<String, String> map) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardListQMain", map, rowBounds);
	}

	public ArrayList<Board> selectBoardListFMain(SqlSessionTemplate sqlSession, PageInfo pi,
			HashMap<String, String> map) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardListFMain", map, rowBounds);
	}

	public ArrayList<Board> selectBoardListRMain(SqlSessionTemplate sqlSession, PageInfo pi,
			HashMap<String, String> map) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardListRMain", map, rowBounds);
	}

	public int reportBoard(SqlSessionTemplate sqlSession, int bId) {
		
		return sqlSession.update("boardMapper.reportBoard", bId);
	}

	public int reportBoardAdmin(SqlSessionTemplate sqlSession, int bId) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.reportBoardAdmin", bId);
	}

	public int reportBoardAdmin2(SqlSessionTemplate sqlSession, int bId) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.reportBoardAdmin2", bId);
	}
	// scrap insert
		public int insertScrap(SqlSessionTemplate sqlSession, Scrap s) {
			return sqlSession.insert("boardMapper.insertScrap", s);
		}
		
		// scrap select
		public ArrayList<Scrap> selectScrap(SqlSessionTemplate sqlSession, int bId, int memberNum) {
			return (ArrayList)sqlSession.selectList("boardMapper.selectScrap", memberNum);
		}

	
}
