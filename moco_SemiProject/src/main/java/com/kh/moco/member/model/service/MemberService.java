package com.kh.moco.member.model.service;

import java.util.HashMap;

import com.kh.moco.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member m);

	Member login(Member m);

	int checkId(String id);

	int checkNickName(String nickName);

	int updateMember(Member m);

//	int updateMemberPwd(HashMap<String, String> map);

	Member searchId(Member m);

	int updatePwd(HashMap<String, String> map);

	Member searchPwd(Member m);

	int searchEmail(String memberEmail);

	int deleteMember(String memberId);
	
}
