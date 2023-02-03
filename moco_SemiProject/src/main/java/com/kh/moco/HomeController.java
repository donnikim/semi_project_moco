package com.kh.moco;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.board.exception.BoardException;
import com.kh.moco.board.model.service.BoardService;
import com.kh.moco.board.model.vo.Board;
import com.kh.moco.common.Pagination;
import com.kh.moco.common.model.vo.PageInfo;
import com.kh.moco.info.model.service.InfoService;
import com.kh.moco.info.model.vo.Infomation;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private BoardService bService;
	
	@Autowired
	private InfoService iService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(@RequestParam(value = "page", required = false) Integer page, Model model) {
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}
		String boardCategory = "QNA";
		String QNA = "QNA";
		String Free = "자유";
		String review = "후기";
		String Anonymity = "N";
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardCategory", boardCategory);
		map.put("Anonymity", Anonymity);
		map.put("Free", Free);
		map.put("QNA",QNA);
		map.put("review", review);

		int listCount = bService.getListCount(map);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);

		ArrayList<Board> Qlist = bService.selectBoardListQMain(pi, map);
		ArrayList<Board> Flist = bService.selectBoardListFMain(pi, map);
		ArrayList<Board> Rlist = bService.selectBoardListRMain(pi, map);

			
		ArrayList<Infomation> iList =iService.selectInfoList(2,pi);
//		System.out.println(iList);
		ArrayList<Attachment> aList=iService.selectAttmList(2);// 주희씨랑 안겹치게 하려면 2 넣어야 함!
//			System.out.println(aList);

		if (Qlist != null) {
			model.addAttribute("pi", pi);
			model.addAttribute("Qlist", Qlist);
			model.addAttribute("Flist", Flist);
			model.addAttribute("Rlist", Rlist);
			model.addAttribute("boardCategory", boardCategory);
			model.addAttribute("iList", iList);
			model.addAttribute("aList", aList);
			return "home";
		} else {
			throw new BoardException("게시글 조회 실패");
		}
	}
	
	
}
