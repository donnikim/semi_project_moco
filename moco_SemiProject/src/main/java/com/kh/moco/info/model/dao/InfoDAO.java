package com.kh.moco.info.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.common.model.vo.PageInfo;
import com.kh.moco.info.model.vo.Infomation;


@Repository("iDAO")
public class InfoDAO {

	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("infoMapper.listCount");
	}
	
	public int insertInfo(Infomation info, SqlSessionTemplate sqlSession) {

		System.out.println(info);
		return sqlSession.insert("infoMapper.insertInfo",info);
	}

	public int insertAttm(SqlSessionTemplate sqlSession, ArrayList<Attachment> list) {

		System.out.println(list);
		return sqlSession.insert("infoMapper.insertAttm",list);
	}
	
	public ArrayList<Infomation> selectInfoList(SqlSessionTemplate sqlSession, PageInfo pi,int i) {
		
		int offset=(pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		
		ArrayList<Infomation> list =(ArrayList)sqlSession.selectList("infoMapper.selectInfoList",null,rowBounds);
		
		
		return list;
	}


	public ArrayList<Attachment> selectAttmList(SqlSessionTemplate sqlSession, int i) {
		ArrayList<Attachment> list = (ArrayList)sqlSession.selectList("infoMapper.selectAttm",i);
		return list;
	}

	public Infomation selectInfo(SqlSessionTemplate sqlSession, int infoId) {
		System.out.println(infoId);
		Infomation info = sqlSession.selectOne("infoMapper.selectInfo",infoId);
		System.out.println(info);
		
		return info;
	}

	public ArrayList<Attachment> selectAttmListDetail(SqlSessionTemplate sqlSession, int infoId) {
		ArrayList<Attachment> list = (ArrayList)sqlSession.selectList("infoMapper.selectAttmListDetail",infoId);
		return list;
	}

	public Infomation selectInfoDetail(SqlSessionTemplate sqlSession, int infoId, boolean yn) {
		return sqlSession.selectOne("infoMapper.selectInfoDetail",infoId);
	}

	public int addCount(SqlSessionTemplate sqlSession, int infoId) {
		return sqlSession.update("infoMapper.addCount",infoId);
	}

	public ArrayList<Infomation> selectCount(SqlSessionTemplate sqlSession, int i, PageInfo pi) {
		
		int offset=(pi.getCurrentPage()-1)*pi.getBoardLimit();	
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		
		ArrayList<Infomation> list =(ArrayList)sqlSession.selectList("infoMapper.selectCount",null,rowBounds);
		
		return list;
	}
  
	public ArrayList<Attachment> selectCountAttm(SqlSessionTemplate sqlSession, int i) {
		ArrayList<Attachment> list = (ArrayList)sqlSession.selectList("infoMapper.selectCountAttm",i);
		return list;
	}

	public int deleteInfo(SqlSessionTemplate sqlSession, int infoNum) {
		return sqlSession.update("infoMapper.deleteInfo",infoNum);
	}

	public int deleteAttmBefore(SqlSessionTemplate sqlSession, int infoId) {
		
		System.out.println(infoId);
		return sqlSession.delete("infoMapper.deleteAttmBefore",infoId);
	}

	public int updateInfo(SqlSessionTemplate sqlSession, Infomation info) {
		System.out.println(info);
		return sqlSession.update("infoMapper.updateInfo",info);
	}

	public int updateAttmAfter(SqlSessionTemplate sqlSession, ArrayList<Attachment> list) {
		return sqlSession.insert("infoMapper.updateAttmAfter", list);
	}

}
