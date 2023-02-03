package com.kh.moco.board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.board.exception.BoardException;
import com.kh.moco.board.model.service.BoardService;
import com.kh.moco.board.model.vo.Board;
import com.kh.moco.board.model.vo.Reply;
import com.kh.moco.board.model.vo.Scrap;
import com.kh.moco.common.Pagination;
import com.kh.moco.common.model.vo.PageInfo;
import com.kh.moco.member.model.vo.Member;

@Controller
public class BoardController {

   @Autowired
   private BoardService bService;

   // 자유게시판 글쓰기 폼으로 넘어가기
   @RequestMapping("boardWrite.bo")
   public String boardWrite() {
      return "boardWrite";
   }

   // 자유게시판 글 작성
   @RequestMapping("insertBoard.bo")
   public String insertBoard(@ModelAttribute Board b, HttpSession session) {

      String nickName = ((Member) session.getAttribute("loginUser")).getMemberNickName();
      int id = ((Member) session.getAttribute("loginUser")).getMemberNum();
      b.setMemberNum(id);
      b.setNickName(nickName);

      if (b.getBoardAnonymity() == null) {
         b.setBoardAnonymity("N");
      } else if (b.getBoardAnonymity().equals("on")) {
         b.setBoardAnonymity("Y");
      }

      int result = bService.insertBoard(b);

      if (result > 0) {
         return "redirect:list.bo";
      } else {
         throw new BoardException("게시글 작성 실패");
      }
   }

	// 게시글 상세보기
	@RequestMapping("selectBoard.bo")
	public ModelAndView selectBoard(@RequestParam("boardNum") int bId, @RequestParam("nickName") String writer,
									@RequestParam("page") int page, HttpSession session, ModelAndView mv) {
		System.out.println("selectBoard 시작");
		Member m = (Member) session.getAttribute("loginUser");
		String login = null;
		
		if (m != null) {
			login = m.getMemberNickName();
		}
		
		boolean yn = false;
		if (!writer.equals(login)) {
			yn = true; // 글을 조회하는 사람이 글쓴이가 아니다 -> 조회수 오름
		}
		
		Board b = bService.selectBoard(bId, yn);
//		System.out.println(b);
		ArrayList<Attachment> alist = bService.selectAttmList((Integer)bId);
		ArrayList<Reply> replylist = bService.selectReply(bId);
		
//		System.out.println("리뷰 controller " + replylist);
		int rCount = replylist.size();
		ArrayList<Scrap> scrapResult = new ArrayList<Scrap>();
		
		if(m != null) {
			scrapResult = bService.selectScrap(bId, m.getMemberNum());
		}
		ArrayList<Scrap> scrapRList = new ArrayList<Scrap>();
		
		for(Scrap i : scrapResult) {
			int SboardNum = i.getBoardNum();
			if(SboardNum == bId) {
				scrapRList.add(i);
			}
		}
		
		if (b != null) {
			mv.addObject("b", b);
			mv.addObject("rCount", rCount).addObject("list", replylist).addObject("page", page).addObject("alist", alist);
			mv.addObject("scrapRList", scrapRList).setViewName("boardDetail");
			return mv;
		} else {
			throw new BoardException("게시글 상세보기 실패");
		}
	}

   // 게시판 수정
   @RequestMapping("updateForm.bo")
   public String updateForm(@RequestParam("boardNum") int bId, @RequestParam("page") int page, Model model) {
      Board b = bService.selectBoard(bId, false);
      ArrayList<Attachment> alist = bService.selectAttmList(bId);

      model.addAttribute("b", b);
      model.addAttribute("page", page);
      model.addAttribute("alist", alist);

      return "boardUpdate";
   }

	// 자유게시판 게시글 수정
	@RequestMapping("updateBoard.bo")
	public String updateBoard(@ModelAttribute Board b, @RequestParam("page") int page,
			@RequestParam(value = "boardNum", required = false) Integer boardNum,  @RequestParam(value="deleteAttm", required = false) String[] deleteAttm,
			@RequestParam(value="file", required = false) ArrayList<MultipartFile> files, Model model, HttpServletRequest request) {
		// 자유 게시판 보드 수정
		b.setBoardType(1);
		
		System.out.println("files 받아왔는 지 확인"+files);

		System.out.println("deleteAttm 확인"+deleteAttm);
		
		// 새파일 저장하겠다
		ArrayList<Attachment> list = new ArrayList<>();
		for (int i = 0; i < files.size(); i++) {
			MultipartFile upload = files.get(i);

			if (!upload.getOriginalFilename().equals("")) {
				String[] returnArr = saveFile(upload, request);

				if (returnArr[1] != null) {
					Attachment a = new Attachment();
					a.setAttmOriginName(upload.getOriginalFilename());
					a.setAttmRename(returnArr[1]);
					a.setAttmPath(returnArr[0]);

					list.add(a);
				}
			}
		}
		
		// 파일 삭제 로직
		ArrayList<String> delRename = new ArrayList<>();
		ArrayList<Integer> delLevel = new ArrayList<>();
		
		if(deleteAttm != null) {
			for (String rename : deleteAttm) {
				if (!rename.equals("")) {
					String[] split = rename.split("/");
					delRename.add(split[0]);
					delLevel.add(Integer.parseInt(split[1]));
				}
			}
			
			int deleteAttmResult = 0;
			boolean existBeforeAttm = true;
			if(!delRename.isEmpty()) {
				// 저장했던 첨부파일 중에서 하나라도 삭제하겠다고 한 경우
				deleteAttmResult = bService.deleteAttm(delRename);
				
				if(deleteAttmResult > 0) {
					for(String rename : delRename) {
						deleteFile(rename, request);
					}
				}
				
				if(delRename.size() == deleteAttm.length) {
					// 기존 파일을 전부 삭제하겠다고 한 경우
					existBeforeAttm = false; // 이전에 집어넣은 attm이 존재하지 않는다는 뜻이니까 false
					if(list.isEmpty()){
						// 새 파일 X
						b.setBoardType(1);
					}
				}else {
					// 삭제는 했는데 전부 삭제는 아니야
					for(int level : delLevel) {
						if(level == 0) {
							bService.updateAttmLevel(b.getBoardNum());
							break;
						}
					}
				}
			}
			for(int i = 0; i < list.size(); i++) {
				Attachment a = list.get(i);
				
				a.setAttmRefboard(b.getBoardNum());
				
				if(existBeforeAttm) {
					// 이전에 attm에 파일이 존재한다
					a.setAttmLevel(1);
				}else {
					// attm에 파일이 존재하지 않아
					if(i == 0) {
						a.setAttmLevel(0);
					}else {
						a.setAttmLevel(1);
					}
				}
			}
		}
		
		// 보드 업데이트
		int updateBoardResult = bService.updateBoard(b);
//		System.out.println("보드 업데이트" + updateBoardResult);
		
		int updateAttmResult = 0;
		if(!list.isEmpty()) {
			if (b.getBoardAnonymity() == null) {
				b.setBoardAnonymity("N");
			} else if (b.getBoardAnonymity().equals("on")) {
				b.setBoardAnonymity("Y");
			}
			
			updateAttmResult = bService.insertAttm(list);
		}
		
		if(updateBoardResult + updateAttmResult == list.size()+1) {
			if(deleteAttm != null) {
				if(delRename.size() == deleteAttm.length && updateAttmResult == 0) {
					return "redirect:list.bo";
				}else {
					model.addAttribute("boardNum", b.getBoardNum());
					model.addAttribute("nickName", ((Member)request.getSession().getAttribute("loginUser")).getMemberNickName());
					model.addAttribute("page", page);
					return "redirect:selectBoard.bo";
				}
			}else {
				model.addAttribute("boardNum", b.getBoardNum());
				model.addAttribute("nickName", ((Member)request.getSession().getAttribute("loginUser")).getMemberNickName());
				model.addAttribute("page", page);
				return "redirect:selectBoard.bo";
			}
		}else {
			throw new BoardException("첨부파일 게시글 수정 실패");
		}
	}

	// 자유게시판 글 삭제
	@RequestMapping("delete.bo")
	public String deleteBoard(@RequestParam("boardNum") int bId,@RequestParam(value="deleteAttm", required = false) String[] deleteAttm, HttpServletRequest request ) {
		System.out.println("delete controller 시작");
		
		// 파일 삭제 로직
		ArrayList<String> delRename = new ArrayList<>();
		ArrayList<Integer> delLevel = new ArrayList<>();
		
		int attmResult = 0;
		
		if(deleteAttm != null) {
			for (String rename : deleteAttm) {
				System.out.println("fileName 출력 : " + rename);
				if (!rename.equals("")) {
					String[] split = rename.split("/");
					delRename.add(split[0]);
					delLevel.add(Integer.parseInt(split[1]));
				}
			}
			attmResult = bService.deleteAttm(delRename);
		}
		
		int boardresult = bService.deleteBoard(bId);
		
		if (boardresult > 0 || attmResult > 0) {
			System.out.println("삭제 성공");
			return "redirect:list.bo";
		} else {
			throw new BoardException("게시글 삭제 실패");
		}
	}
      
      // 댓글 부분
      @RequestMapping("insertReply.bo")
      public void insertReply(@ModelAttribute Reply r, HttpServletResponse response) {
         System.out.println(r.getMemberNum());
         System.out.println("boardNum: " + r.getBoardNum());
         int result = bService.insertReply(r);
//         System.out.println(result);
         
         ArrayList<Reply> list = bService.selectReply(r.getBoardNum());
         System.out.println("받아온 댓글 리스트" + list);
         
         response.setContentType("application/json; charset=UTF-8");
         GsonBuilder gb = new GsonBuilder();
         // 시간 형식 지정해주기 
         GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd");
         Gson gson = gb2.create();
         try {
            gson.toJson(list, response.getWriter());
         } catch (JsonIOException | IOException e) {
            e.printStackTrace();
         }
      }
      
  	// 첨부파일 insert
  	@RequestMapping("insertAttm.bo")
  	public String insertAttm(@ModelAttribute Board b, @RequestParam("file") ArrayList<MultipartFile> files, HttpServletRequest request) {
  		int memberNum = ((Member)request.getSession().getAttribute("loginUser")).getMemberNum();
  		b.setMemberNum(memberNum);
  		System.out.println("insertAttm start");
  		System.out.println(b);
  		System.out.println(files);
  		
  		ArrayList<Attachment> list = new ArrayList<Attachment>();
  		for(int i=0; i < files.size(); i++) {
  			MultipartFile upload = files.get(i);
  			System.out.println(upload.getOriginalFilename());
  			if(!upload.getOriginalFilename().equals("")) {
  			// 위 코드는 사이즈가 0인 것(파일은 만들었으나 내용을 쓰지 않은 것들)들도 가져와서 비교함
//  			if(upload != null && !upload.isEmpty()) {
  			// 사이즈가 0인 것은 가지고 오지 않겠다
  				String[] returnArr = saveFile(upload, request);
  				
  				if(returnArr[1] != null) {
  					Attachment a = new Attachment();
  					a.setAttmOriginName(upload.getOriginalFilename());
  					a.setAttmRename(returnArr[1]);
  					a.setAttmPath(returnArr[0]);
  					
  					list.add(a);
  				}
  			}
  		}
  		
  		for(int i = 0; i< list.size(); i++) {
  			Attachment a = list.get(i);
  			if(i == 0) {
  				a.setAttmLevel(0);
  			}else {
  				a.setAttmLevel(1);
  			}
  		}
//  		System.out.println(list);
  		int result1 = 0;
  		int result2 = 0;
  		
  		if(list.isEmpty()) {
  			b.setBoardType(1);
  			System.out.println("비었을때 보드 " + b);
  			
  			if (b.getBoardAnonymity() == null) {
  				b.setBoardAnonymity("N");
  			} else if (b.getBoardAnonymity().equals("on")) {
  				b.setBoardAnonymity("Y");
  			}
  			
  			result1 = bService.insertBoard(b);
  		}else {
  			b.setBoardType(1);
  			System.out.println(b.getBoardAnonymity());
  			
  			if (b.getBoardAnonymity() == null) {
  				b.setBoardAnonymity("N");
  			} else if (b.getBoardAnonymity().equals("on")) {
  				b.setBoardAnonymity("Y");
  			}
  			
  			System.out.println(b.getBoardAnonymity());
  			System.out.println("차있을때 보드" + b);
  			result1 = bService.insertBoard(b);
  			System.out.println("차있을때 보드 result : " + result1);
  			result2 = bService.insertAttm(list);
  		}
  		
  		if(result1 + result2 == list.size() + 1) {
  			if(result2 == 0) {
  				return "redirect:list.bo";
  			}else {
  				return "redirect:list.bo";
  			}
  		}else {
  			for(Attachment a : list) {
  				deleteFile(a.getAttmRename(), request);
  			}
  			throw new BoardException("첨부 파일 게시글 삽입 실패");
  		}
  	}
      // attm Save
      // saveFile 메소드 만들기
      public String[] saveFile(MultipartFile file, HttpServletRequest request) {
         String root = request.getSession().getServletContext().getRealPath("resources");
         String savePath = root + "\\uploadFiles";
//         \\는 \를 의미함
         
         File folder = new File(savePath);
         if(!folder.exists()) {
            folder.mkdirs();
            // folder가 존재하지 않으면 make diretorys 폴더를 만들어줘
         }
         
         // 파일 저장소(물리적으로)에 저장할 수 있게끔 하는 코드
         SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
         int ranNum = (int)(Math.random()*100000);
         // 파일명 변경
         String originFileName = file.getOriginalFilename();
         String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + ranNum
                           + originFileName.substring(originFileName.lastIndexOf("."));
         
         String renamePath = folder + "\\" + renameFileName;
         
         try {
            file.transferTo(new File(renamePath));
         } catch (Exception e) {
            System.out.println("파일 전송 에러 :" + e.getMessage());
         }
         
         String[] returnArr = new String[2];
         
         returnArr[0] = savePath;
         returnArr[1] = renameFileName;
         
         return returnArr;
      }
      
      // deleteFile 메소드 만들기
      public void deleteFile(String fileName, HttpServletRequest request) {
         String root = request.getSession().getServletContext().getRealPath("resources");
         String savePath = root + "\\uploadFiles";
         
         File f = new File(savePath +"\\" + fileName);
         if(f.exists()) {
            f.delete();
         }
      }
      
      // 스크랩 insert
      @RequestMapping("insertScrap.bo")
      public ModelAndView insertScarp(@RequestParam("boardNum") int bId, @RequestParam("scrap") String scrap, @RequestParam("anonickName") String writer,
            @RequestParam("page") int page, HttpSession session, ModelAndView mv) {
         int memberNum  = ((Member) session.getAttribute("loginUser")).getMemberNum();
         
         System.out.println(memberNum);
         System.out.println(scrap);
         
         Scrap s = new Scrap();
         s.setBoardNum(bId);
         s.setMemberNum(memberNum);
         int result = bService.insertScrap(s);
         
         ModelAndView selectMv = selectBoard(bId, writer, page, session,  mv);
         
         if(result > 0) {
            selectMv.setViewName("boardDetail");
            return selectMv;
         }else {
            throw new BoardException("스크랩 실패");
         }
      }
   // 1. 메인페이지
   @RequestMapping("list.bo")
   public String selectBoardList(@RequestParam(value = "page", required = false) Integer page, Model model) {
      int currentPage = 1;
      if (page != null) {
         currentPage = page;
      }

      String boardCategory = "main";
      String Anonymity = "N";

      HashMap<String, String> map = new HashMap<String, String>();
      map.put("boardType", "1");
      map.put("Anonymity", Anonymity);

      int listCount = bService.getListCountMain(map);

      PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);

      ArrayList<Board> list = bService.selectBoardListMain(pi, map);

      if (list != null) {
         model.addAttribute("pi", pi);
         model.addAttribute("list", list);
         model.addAttribute("boardCategory", boardCategory);
         return "boardList";
      } else {
         throw new BoardException("게시글 조회 실패");
      }
   }

   // 1-1 QNA게시판
   @RequestMapping("boardQNA.bo")
   public String selectBoardListQNA(@RequestParam(value = "page", required = false) Integer page, Model model) {
      int currentPage = 1;
      if (page != null) {
         currentPage = page;
      }
      String boardCategory = "QNA";
      String Anonymity = "N";

      HashMap<String, String> map = new HashMap<String, String>();
      map.put("boardCategory", boardCategory);
      map.put("Anonymity", Anonymity);

      int listCount = bService.getListCount(map);

      PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);

      ArrayList<Board> list = bService.selectBoardList(pi, map);

      if (list != null) {
         model.addAttribute("pi", pi);
         model.addAttribute("list", list);
         model.addAttribute("boardCategory", boardCategory);

         return "boardList";
      } else {
         throw new BoardException("게시글 조회 실패");
      }
   }

   // 1-2 후기게시판
   @RequestMapping("boardReview.bo")
   public String selectBoardListReview(@RequestParam(value = "page", required = false) Integer page, Model model) {
      int currentPage = 1;
      if (page != null) {
         currentPage = page;
      }
      String boardCategory = "후기";
      String Anonymity = "N";

      HashMap<String, String> map = new HashMap<String, String>();
      map.put("boardCategory", boardCategory);
      map.put("Anonymity", Anonymity);

      int listCount = bService.getListCount(map);

      PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);

      ArrayList<Board> list = bService.selectBoardList(pi, map);

      if (list != null) {
         model.addAttribute("pi", pi);
         model.addAttribute("list", list);
         model.addAttribute("boardCategory", boardCategory);

         return "boardList";
      } else {
         throw new BoardException("게시글 조회 실패");
      }
   }

   // 1-3 자유게시판
   @RequestMapping("boardFree.bo")
   public String selectBoardListFree(@RequestParam(value = "page", required = false) Integer page, Model model) {
      int currentPage = 1;
      if (page != null) {
         currentPage = page;
      }
      String boardCategory = "자유";
      String Anonymity = "N";

      HashMap<String, String> map = new HashMap<String, String>();
      map.put("boardCategory", boardCategory);
      map.put("Anonymity", Anonymity);

      int listCount = bService.getListCount(map);

      PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);

      ArrayList<Board> list = bService.selectBoardList(pi, map);

      if (list != null) {
         model.addAttribute("pi", pi);
         model.addAttribute("list", list);
         model.addAttribute("boardCategory", boardCategory);

         return "boardList";
      } else {
         throw new BoardException("게시글 조회 실패");
      }
   }

   // 1-4 익명게시판.
   @RequestMapping("boardUnKnown.bo")
   public String selectBoardListAnonymity(@RequestParam(value = "page", required = false) Integer page, Model model) {
      int currentPage = 1;
      if (page != null) {
         currentPage = page;
      }
      String boardCategory = "익명";
      String Anonymity = "Y";

      HashMap<String, String> map = new HashMap<String, String>();
      map.put("boardCategory", boardCategory);
      map.put("Anonymity", Anonymity);

      int listCount = bService.getListCount(map);

      PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);

      ArrayList<Board> list = bService.selectBoardList(pi, map);

      if (list != null) {
         model.addAttribute("pi", pi);
         model.addAttribute("list", list);
         model.addAttribute("boardCategory", boardCategory);

         return "boardList";
      } else {
         throw new BoardException("게시글 조회 실패");
      }
   }

   // 2 검색
   @RequestMapping("Search.bo")
   public String selectBoardListSearch(@RequestParam(value = "page", required = false) Integer page,
         @RequestParam(value = "searchCondition", required = false) String searchCondition,
         @RequestParam(value = "searchValue", required = false) String searchName,
         @RequestParam(value = "boardCategory", required = false) String boardCategory,
         @RequestParam(value = "boardAnonymity", required = false) String boardAnonymity, Model model) {
      int currentPage = 1;
      if (page != null) {
         currentPage = page;
      }

      HashMap<String, String> map = new HashMap<String, String>();
      map.put("searchCondition", searchCondition);
      map.put("searchValue", searchName);
      map.put("boardCategory", boardCategory);
      map.put("boardAnonymity", boardAnonymity);

      int listCount = bService.getListCountSearch(map);

      PageInfo pi = Pagination.getPageInfo(currentPage, listCount, 10);

      ArrayList<Board> list = bService.selectBoardListSearch(pi, map);

      if (list != null) {
         model.addAttribute("pi", pi);
         model.addAttribute("list", list);
         model.addAttribute("searchCondition", searchCondition);
         model.addAttribute("searchValue", searchName);
         model.addAttribute("boardCategory", boardCategory);
         model.addAttribute("boardAnonymity", boardAnonymity);

         return "boardSearch";
      } else {
         throw new BoardException("게시글 조회 실패");
      }
   }

   // 일반회원 신고
   @RequestMapping("reportBoard.bo")
   public String reportBoard(@RequestParam(value = "boardDetailNum") int bId) {

      int result = bService.reportBoard(bId);

      if (result > 0) {
         return "redirect:list.bo";
      } else {
         throw new BoardException("게시글 조회 실패");
      }

   }

   // 관리자회원 신고 수락
   @RequestMapping("reportBoardAdmin.bo")
   public String reportBoardAdmin(@RequestParam(value = "boardDetailNum") int bId) {

      int result = bService.reportBoardAdmin(bId);

      if (result > 0) {
         return "redirect:managerPageView.my";
      } else {
         throw new BoardException("게시글 조회 실패");
      }

   }

   // 관리자회원 신고 x
   @RequestMapping("reportBoardAdmin2.bo")
   public String reportBoardAdmin2(@RequestParam(value = "boardDetailNum") int bId) {

      int result = bService.reportBoardAdmin2(bId);

      if (result > 0) {
         return "redirect:managerPageView.my";
      } else {
         throw new BoardException("게시글 조회 실패");
      }

   }

}