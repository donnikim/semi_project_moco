package com.kh.moco.info.controller;


import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.common.Pagination;
import com.kh.moco.common.model.vo.PageInfo;
import com.kh.moco.info.model.exception.InfoException;
import com.kh.moco.info.model.service.InfoService;
import com.kh.moco.info.model.vo.Infomation;

import com.kh.moco.member.model.vo.Member;
@Controller
public class InfoController {
	
	@Autowired
	private InfoService iService;
	
	
	@RequestMapping("/infoList.in")
	public String infoList(@RequestParam(value="page",required=false) Integer page,Model model) {
		
		int currentPage=1;
		if(page!=null) {
			currentPage=page;
		}
		//수정
		int listcount=iService.getListCount();
		PageInfo pi=Pagination.getPageInfo(currentPage, listcount,9);
		
		ArrayList<Infomation> iList =iService.selectInfoList(2,pi);
//		System.out.println(iList);
		ArrayList<Attachment> aList=iService.selectAttmList(2);// 
//		System.out.println(aList);
		if(iList!=null) {
			model.addAttribute("pi",pi);
			model.addAttribute("aList", aList);
			model.addAttribute("iList",iList);
			return "infoList";
		}
		
		return "infoList";
	}
	@RequestMapping("/insertInfo.in")
	public String insertInfo() {
	
		return "insertInfo";
	}
	@RequestMapping("/selectCount.in")
	public String selectNewest(@RequestParam(value="page",required=false) Integer page,Model model) {
		
		int currentPage=1;
		if(page!=null) {
			currentPage=page;
		}
		//수정
		int listcount=iService.getListCount();
		PageInfo pi=Pagination.getPageInfo(currentPage, listcount, 9);
		
		ArrayList<Infomation> iList =iService.selectCount(2,pi);
//		System.out.println(iList);
		ArrayList<Attachment> aList=iService.selectCountAttm(2);// 
//		System.out.println(aList);
		if(iList!=null) {
			model.addAttribute("pi",pi);
			model.addAttribute("aList", aList);
			model.addAttribute("iList",iList);
			return "infoList";
		}
		
		return "infoList";
	
	}
	
	@RequestMapping("/writeInfo.in")
	public String writeInfo(HttpSession session,@ModelAttribute Infomation info,@RequestParam("file") ArrayList<MultipartFile> files,HttpServletRequest request ) {
		
		String roadFullAddr= info.getInfoAddress(); 
		Float[] lat_lan=getKakaoApiFromAddress(roadFullAddr);
//		System.out.println(lat_lan[0]);//위도 
//		System.out.println(lat_lan[1]);//경도

		int memberNum =((Member)session.getAttribute("loginUser")).getMemberNum();
		info.setMemberNum(memberNum);
		info.setInfoAddressLat(lat_lan[1]);
		info.setInfoAddressLong(lat_lan[0]);
		
		
		ArrayList<Attachment> list = new ArrayList<Attachment>();
		//ArrayList<MultipartFile> file 안에 있는 객체들을 list안에 담으려고 한다.
		
		for(int i=0; i<files.size();i++) {
			
			MultipartFile upload =files.get(i);
			
			
			if(!upload.getOriginalFilename().equals("")) { //upload에 오리지날 이름이 빈칸이 아니라면!
//			if(upload!=null&&!upload.isEmpty()) { //upload가 null이 아니고 upload가 비어있지 않다면! 
				
				
				
				String[] returnArr = saveFile(upload, request);
				
				
				if(returnArr[1]!=null) {

					Attachment a = new Attachment();
					
					a.setAttmOriginName(upload.getOriginalFilename());
					a.setAttmRename(returnArr[1]);
					a.setAttmPath(returnArr[0]);
					list.add(a);
				}
			}
		}
				
		   
		for(int i=0; i<list.size();i++) {
			Attachment a =list.get(i);
			if(i==0) {
				a.setAttmLevel(0);
			}else {
				a.setAttmLevel(1);
			}
		}
		int result1 = iService.insertInfo(info);
		int result2 = iService.insertAttm(list);
		
		if(result1>0 && result2>0 ) {
			return"infoApprove";
		}else {
			throw new InfoException("첨부파일 게시글 삽입 실패");
		}
	
	}
	
	public Float[] getKakaoApiFromAddress(String roadFullAddr) {
		Float[] coordinate = new Float[2];
		
		String apiKey = "e62bbeb2f260743a5c5006f776e400b9";
	    String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json";
	    String jsonString = null;

	    try {
	        roadFullAddr = URLEncoder.encode(roadFullAddr, "UTF-8");

	        String addr = apiUrl + "?query=" + roadFullAddr;

	        URL url = new URL(addr);
	        URLConnection conn = url.openConnection();
	        conn.setRequestProperty("Authorization", "KakaoAK " + apiKey);

	        BufferedReader rd = null;
	        rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        StringBuffer docJson = new StringBuffer();

	        String line;

	        while ((line=rd.readLine()) != null) {
	            docJson.append(line);
	        }

	        jsonString = docJson.toString();
	        rd.close();
	        JSONObject jsonObject = new JSONObject(jsonString);
            JSONArray documentsArray = jsonObject.getJSONArray("documents");
            JSONObject documentsObject = documentsArray.getJSONObject(0);

            String longtitude = documentsObject.getString("x");
            String latitude = documentsObject.getString("y");

            coordinate[0] = Float.parseFloat(longtitude);
            coordinate[1] = Float.parseFloat(latitude);
            
           
            
            
            
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	    } catch (MalformedURLException e) {
	        e.printStackTrace();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    return coordinate;
	}
	public String[] saveFile(MultipartFile file, HttpServletRequest request) {
		
		String root=request.getSession().getServletContext().getRealPath("resources");
		
		
		String savePath=root+"\\uploadFiles";
		
		File folder = new File(savePath);
		
		
		if(!folder.exists()) {
			folder.mkdirs();
			}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		
		int ranNum=(int)(Math.random()*100000);
		String originFileName=file.getOriginalFilename();
		String renameFileName=sdf.format(new Date(System.currentTimeMillis()))+ranNum+originFileName.substring(originFileName.lastIndexOf("."));
		
		
		String renamePath=folder+"\\"+renameFileName;
		
		try {
			file.transferTo(new File(renamePath));
			
			
		} catch (Exception e) {
			System.out.println("파일 전송 에러: "+e.getMessage());
		}
		String[] returnArr= new String[2];
		returnArr[0]=savePath;
		returnArr[1]=renameFileName;
		
		return returnArr;
		
	}

	public void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath=root+"\\uploadFiles";
		
		File f = new File(savePath+"\\"+fileName);
		if(f.exists()) {
			f.delete();
		}
	}
	@RequestMapping("selectAttm.in")
	public ModelAndView selectAttm(@RequestParam("infoNum") int infoNum,@RequestParam("infoMem") int infoMem,@RequestParam("page") int page,ModelAndView mv,HttpSession session) {
		Member m =(Member)session.getAttribute("loginUser");
		System.out.println(m);
		int login = 0;
		
		if(m!=null) {
			login=m.getMemberNum();
		}
		boolean yn = false;
		
		if(infoMem!=login) {
			yn=true;
		}
		Infomation info =iService.selectInfoDetail(infoNum,yn);
		
		ArrayList<Attachment> list=iService.selectAttmListDetail((Integer) infoNum);
		
		if( info!=null) {
		
		mv.addObject("info",info).addObject("list",list).addObject("page",page).setViewName("infoDetailView");
		
		}else {
			throw new InfoException("첨부파일 게시글 상세보기 실패");
		}
		return mv;
	}
	@RequestMapping("delete.in")
	public String deleteInfo(@RequestParam (value="infoNum", required=false) int infoNum) {
		System.out.println(infoNum);
		int result=iService.deleteInfo(infoNum);
		System.out.println(result);
		if(result>0) {
			return "redirect:infoList.in";
			
		}else {
			
			throw new InfoException("게시물 삭제 실패");
		}
	}
	
	@RequestMapping("updateForm.in")
	public String updateForm(@RequestParam("infoNum") int infoNum,@RequestParam("page") int page,Model model) {
		
		Infomation info = iService.selectInfoDetail(infoNum, false);
		ArrayList<Attachment> list =iService.selectAttmListDetail(infoNum);
		model.addAttribute("info",info);
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		
		return "updateInfo";
	}
	
	@RequestMapping("edit.in")
	public String editInfo(HttpSession session,@RequestParam("infoNum") int infoNum,@RequestParam("page") int page,@ModelAttribute Infomation info,@RequestParam("file") ArrayList<MultipartFile> files,HttpServletRequest request  ) {
		
	
	
	String roadFullAddr= info.getInfoAddress(); 
	Float[] lat_lan=getKakaoApiFromAddress(roadFullAddr);
//	System.out.println(lat_lan[0]);//위도 
//	System.out.println(lat_lan[1]);//경도

	int memberNum =((Member)session.getAttribute("loginUser")).getMemberNum();
	info.setMemberNum(memberNum);
	info.setInfoAddressLat(lat_lan[1]);
	info.setInfoAddressLong(lat_lan[0]);
	
	int result=iService.deleteAttmBefore(infoNum);
	
	ArrayList<Attachment> list = new ArrayList<Attachment>();
	//ArrayList<MultipartFile> file 안에 있는 객체들을 list안에 담으려고 한다.
	
	for(int i=0; i<files.size();i++) {
		
		MultipartFile upload =files.get(i);
		
		
		if(!upload.getOriginalFilename().equals("")) { //upload에 오리지날 이름이 빈칸이 아니라면!
//		if(upload!=null&&!upload.isEmpty()) { //upload가 null이 아니고 upload가 비어있지 않다면! 
			
			
			
			String[] returnArr = saveFile(upload, request);
			
			
			if(returnArr[1]!=null) {

				Attachment a = new Attachment();
				
				a.setAttmOriginName(upload.getOriginalFilename());
				a.setAttmRename(returnArr[1]);
				a.setAttmPath(returnArr[0]);
				list.add(a);
			}
		}
	}
			
	   
	for(int i=0; i<list.size();i++) {
		Attachment a =list.get(i);
		if(i==0) {
			a.setAttmLevel(0);
			a.setAttmRefboard(infoNum);
		}else {
			a.setAttmLevel(1);
			a.setAttmRefboard(infoNum);
		}
	}
	int result1 = iService.updateInfo(info);
	int result2 = iService.updateAttm(list);
	
	if(result1>0 && result2>0 ) {
		return"updateImpl";
	}else {
		throw new InfoException("첨부파일 게시글 수정 실패");
	}

}
}
