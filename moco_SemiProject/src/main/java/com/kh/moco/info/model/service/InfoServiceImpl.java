package com.kh.moco.info.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.common.model.vo.PageInfo;
import com.kh.moco.info.model.dao.InfoDAO;
import com.kh.moco.info.model.vo.Infomation;


@Service("iService")

public class InfoServiceImpl implements InfoService {
	@Autowired
	private InfoDAO iDAO;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int getListCount() {
		return iDAO.getListCount(sqlSession);
	}
	
	@Override
	public int insertInfo(Infomation info) {

		return iDAO.insertInfo(info, sqlSession);
	}

	@Override
	public int insertAttm(ArrayList<Attachment> list) {
		return iDAO.insertAttm(sqlSession,list);
	}

	@Override
	public ArrayList<Infomation> selectInfoList(int i,PageInfo pi) {
		return iDAO.selectInfoList(sqlSession,pi,i);
	}




	@Override
	public Infomation selectInfo(int infoId, boolean yn) {
		int result =0;
		
		if(yn) {
			result=iDAO.addCount(sqlSession,infoId);
		}
		System.out.println(result);
		Infomation info = iDAO.selectInfo(sqlSession,infoId);
		return info;
	
	}

	@Override
	public ArrayList<Attachment> selectAttmListDetail(int infoId) {
		return iDAO.selectAttmListDetail(sqlSession,infoId) ;
	}

	@Override
	public Infomation selectInfoDetail(int infoId, boolean yn) {
		int result =0;
		
		if(yn) {
			result=iDAO.addCount(sqlSession,infoId);
		}
		System.out.println(result);
		
		return iDAO.selectInfoDetail(sqlSession,infoId,yn);
	}

	@Override
	public ArrayList<Attachment> selectAttmList(int i) {
		return iDAO.selectAttmList(sqlSession,i);
	}

	@Override
	public ArrayList<Infomation> selectCount(int i, PageInfo pi) {
		return iDAO.selectCount(sqlSession,i,pi);
	}

	@Override
	public ArrayList<Attachment> selectCountAttm(int i) {
		return iDAO.selectCountAttm(sqlSession,i);
	}

	@Override
	public int deleteInfo(int infoNum) {
		return iDAO.deleteInfo(sqlSession,infoNum);
	}

	@Override
	public int deleteAttmBefore(int infoId) {
		return iDAO.deleteAttmBefore(sqlSession,infoId);
	}


	@Override
	public int updateAttm(ArrayList<Attachment> list) {
		return iDAO.updateAttmAfter(sqlSession,list);
	}

	@Override
	public int updateInfo(Infomation info) {
		return iDAO.updateInfo(sqlSession,info);
	}

	
	

	

	
}
