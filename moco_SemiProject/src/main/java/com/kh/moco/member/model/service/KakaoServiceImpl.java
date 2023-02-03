package com.kh.moco.member.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class KakaoServiceImpl implements KakaoService{
	
	@Override
	public String getAcessToken(String code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
//			URL연결(웹페이지 URL연결)
			
			conn.setRequestMethod("POST");
//			 요청방식 선택
			conn.setDoOutput(true);
//			POST 요청을 위해 기본값이 false인 setDoOutput을 true로 변경해줌
//			OutputStream으로 POST 데이터를 넘겨주겠다는 옵션.
			
			
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			System.out.println("bw" +bw);
//			System.out.println();과 유사
//			BufferedWriter는 System.out.println()보다 속도 측면에서 훨씬 빠르기 때문에 
//			(입력된 데이터가 바로 전달되지 않고 버퍼를 거쳐 전달되므로 데이터 처리 효율성을 높임)
//			많은 양의 데이터를 처리할 때 유리하다. 
//			bw.write(str); 버퍼에 있는 값(str) 전부 출력. 자동개행이 안되기 때문에 줄바꿈하려면 \n이 있어야함
//			bw.flush();   남아있는 데이터를 모두 출력시킴
//			bw.close();   스트림을 닫음
			
			StringBuilder sb = new StringBuilder();
//			String 객체끼리 더하는 방법은 메모리 할당과 해제를 발생시키는데, 덧셈 연산이 많아진다면 성능적으로 좋지 않다
//			String 객체는 한번 생성되면 변경 불가능함 (IO수업 참조). 문자열을 더할때마다 새로운 객체가 생성된다
//			StringBuilder는 변경 가능한 문자열을 만들어주는데 StringBuilder의 객체를 생성한 후, 
//			append()의 인자로 연결하고자 하는 문자열을 넣어서 StringBuilder의 객체를 통해 호출한다. 
//			그리고 출력 시에는 toString()을 붙여야 하고, String 변수에 넣을 때도 마찬가지다.
					
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=a365b845ebec15b5cb6e1ef87af8a4d0"); // '='이후 REST_KEY값 넣기
			sb.append("&redirect_uri=http://localhost:8081/moco/kakaoLogin.me"); //	카카오 developer에서 설정해준 redirect주소값 넣어주기
			sb.append("&code=" + code);
            
            bw.write(sb.toString());
            bw.flush();
//			결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			
//			요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//			Scanner와 유사함. BufferdReader은 Enter만 경계로 인식하고 받은 데이터가 String으로 고정되기 때문에 
//			입력받은 데이터를 가공하는 작업이 필요한 경우가 많음
//			입력은 readLine();이라는 메서드를 활용하는데, 여기서 반드시 주의해야할 점 2가지가 있다. 
//			첫번째는 readLine()시 리턴값을 String으로 고정되기에 String이 아닌 다른타입으로 입력을 받을려면 형변환을 꼭 해주어야한다는 점이다. 
//			두번째는 예외처리를 꼭 해주어야한다는 점이다. readLine을 할때마다 try & catch를 활용하여 예외처리를 해주어도 되지만 대개 throws IOException을 통하여 작업한다. 
			
			String line = "";
			String result = "";
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("resoponse body : " + result); // Token값 출력
			
			
//			Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonElement element = JsonParser.parseString(result);
			
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			
			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);
			
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return access_Token;
	}

	
	
	@Override
	public HashMap<String, Object> getUserInfo(String access_Token) {
		
		HashMap<String,Object> userInfo = new HashMap<String,Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("GET");
			
			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			
			System.out.println("response body : " + result);
//			response body : {"id":2553526835,"connected_at":"2022-11-28T07:43:38Z","properties":{"nickname":"강혜진"},
//			"kakao_account":{"profile_nickname_needs_agreement":false,"profile":{"nickname":"강혜진"},"has_email":true,"email_needs_agreement":false,"is_email_valid":true,"is_email_verified":true,"email":"gpwls1178@naver.com"}}
			
			
			JsonElement element = JsonParser.parseString(result);
			
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			String kakao_id = element.getAsJsonObject().get("id").getAsString();
			
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
			userInfo.put("kakao_id", kakao_id);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return userInfo;
	}
	
	@Override
	public void kakaoLogout(String access_Token) {
        String reqURL = "https://kapi.kakao.com/v1/user/logout";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String result = "";
            String line = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println(result);
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
}
	


