package com.kh.moco.member.model.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSessionManager;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.moco.member.model.dao.MemberDAO;
import com.kh.moco.member.model.vo.Member;

@Service("mService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO mDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertMember(Member m) {
		return mDAO.insertMember(sqlSession, m);
	}

	@Override
	public Member login(Member m) {
		return mDAO.login(sqlSession, m);
	}
	
	@Override
	public int checkId(String id) {
		return mDAO.checkId(sqlSession, id);
	}
	
	@Override
	public int checkNickName(String nickName) {
		return mDAO.checkNickName(sqlSession, nickName);
	}
	
	@Override
	public int updateMember(Member m) {
		return mDAO.updateMember(sqlSession, m);
	}
	
//	@Override
//	public int updateMemberPwd(HashMap<String, String> map) {
//		return mDAO.updateMemberPwd(sqlSession, map);
//	}
	
	@Override
	public Member searchId(Member m) {
		return mDAO.searchId(sqlSession, m);
	}
	
	@Override
	public int updatePwd(HashMap<String, String> map) {
		return mDAO.updatePwd(sqlSession, map);
	}
	
	@Override
	public Member searchPwd(Member m) {
		return mDAO.searchPwd(sqlSession, m);
	}
	
	@Override
	public int searchEmail(String memberEmail) {
		return mDAO.searchEmail(sqlSession, memberEmail);
	}
	
	@Override
	public int deleteMember(String memberId) {
		return mDAO.deleteMember(sqlSession, memberId);
	}
	
}
