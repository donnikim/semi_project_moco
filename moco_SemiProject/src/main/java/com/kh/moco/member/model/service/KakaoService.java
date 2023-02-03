package com.kh.moco.member.model.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

@Service("kService")
public interface KakaoService {

	String getAcessToken(String code);

	HashMap<String, Object> getUserInfo(String access_Token);

	void kakaoLogout(String access_Token);

}
