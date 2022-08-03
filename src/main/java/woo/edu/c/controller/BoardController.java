package woo.edu.c.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import woo.edu.c.service.BoardService;
import woo.edu.c.vo.BoardVo;
import woo.edu.c.vo.testVo;

@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private BoardService boardService;
	//service객체를 의존받은 후 이걸 이용해서 비즈니스 로직을 수행함

	// 메인 화면
	@RequestMapping(value = "/board/home")
	public String home(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception {
		logger.info("/board/home");
		return "board/boardhome";
	}
	
	// test
	@RequestMapping(value = "/board/test", method = RequestMethod.GET)
	public String boardList(Model model) throws Exception {
		logger.info("/board/test");
		List<testVo> test = boardService.test();
		model.addAttribute("boardList", test);
		return "/board/boardhome";
	}
	
	
//	 리스트
//	@RequestMapping(value="/board/boardList", method = RequestMethod.GET)
//	public ModelAndView list (ModelAndView mView) {
//		boardService.getList(mView);
//		mView.setViewName("board/boardlist");
//		return mView;
//	}
	
	//boardAjaxList에서 String형식을 사용하기 때문에 바꿔줌
	//https://velog.io/@msriver/Spring-Model-%EA%B0%9D%EC%B2%B4
	@RequestMapping(value="/board/boardList", method = RequestMethod.GET)
	public String list(Model model) throws Exception{
		//model은 SELECT나 UPDATE 등의 조건 데이터를 넘겨준다?
		List<BoardVo> list = boardService.getList();
		model.addAttribute("list", list);
//		System.out.println(list); 
		return "board/boardlist";
	}

	
	//보여줄 페이지 메소드 따로 데이터 전송해주는 메소드 따로 
	//ajax사용 리스트
	@RequestMapping(value="/board/boardAjaxList", method = RequestMethod.GET)
	public String ajaxList (){

		return "/board/boardAjaxList";
	}
	
//	ajax사용 리스트 조회
	@ResponseBody
	@RequestMapping(value="/board/boardAjaxListSel", method = RequestMethod.GET)
	public List<BoardVo> boardAjaxListSel () {
		
		List<BoardVo> list = boardService.getList();
//		Vo의 source에서 toString해야 인코딩 되어 있는 데이터 볼 수 있음
		
		System.out.println("list==="+list);		  
		return list;
	}

//	ajax사용 삭제
	@ResponseBody
	@RequestMapping(value="/board/boardAjaxDelete", method = RequestMethod.GET, produces = "application/text; charset=UTF-8")
	public String boardAjaxDelete(@RequestParam("getBoardNum") int boardNum) {
//		타입을 뭘로 지정??
//		void타입은 받은 url을 자동으로 view로 지정해줌
//		ex) board/boardAjaxDelete?getBoardNum=75
		
//		여기서 if문으로 삭제 성공 여부를 확인한 후 return
//		ajax에서 처리
		System.out.println("boardNum======="+boardNum);
		
		int result = boardService.delete(boardNum); //성공 여부를 리턴받음 . 0 or 1
		String resultStr = "";
		if(result == 1) {
			resultStr = "성공";
		} else {
			resultStr = "실패";
		}
		System.out.println("resultStr=="+resultStr);
		System.out.println("result====="+result);
		return resultStr;
	}
	
//	ajax 체크박스 삭제
	@ResponseBody
	@RequestMapping(value="/board/boardCbDelete", method = RequestMethod.GET, produces = "application/text; charset=UTF-8")
//	public String cbDelete(@RequestParam("chk_arr") String chk_arr) {
	public String cbDelete(@RequestParam(value="chk_arr[]") List<Integer> chk_arr) {
		System.out.println(chk_arr);
//		System.out.println("chk_arr타입 == "+chk_arr.getClass());
		
//		https://go-coding.tistory.com/60

		
//		리스트로 받고 향상된 포문 사용해서 하나씩 뽑아 삭제하기
		
		String resultStr="";
		try {
			for(Integer i:chk_arr) {
				System.out.println(i);
				int result = boardService.delete(i); 
			}			
			resultStr = "성공";
		} catch (Exception e) {
			resultStr = "실패";
			// TODO: handle exception
		}

		
		System.out.println("resultStr==" +resultStr);
		
		return resultStr;
	}
	
	
	
//	ajax사용 글 작성
	@ResponseBody
	@RequestMapping(value="/board/boardAjaxWrite", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String boardAjaxWrite(BoardVo vo) {		//produces = "application/text; charset=UTF-8" 넘어오는 text를 한글화 해줌 
//		public String boardAjaxWrite(@RequestBody BoardVo vo) { //ajax로 json문자가 전달될 때 @RequestBody를 사용해야한다.
		System.out.println("boardAjaxWrite==="+vo);
		int wr = boardService.merge(vo);
//		int wr = boardService.write(vo);
		String str = "";
		if(wr == 1) {
			str = "성공";
		}else {
			str = "실패";
		}
		System.out.println("wr====="+wr);
		
//		return null; //위애서 데이터를 인설트 하므로 return null을 줘도 데이터가 입력됨
		return str; //성공, 실패 여부를 알기 위해
	}
	
	
	
	
//	ajax사용 게시글 보기
	@ResponseBody
	@RequestMapping(value="/board/boardAjaxcDetail", method = RequestMethod.GET)
	public BoardVo boardAjaxListSel (@RequestParam("getBoardNum") int boardNum) {
//		System.out.println(boardNum);
		BoardVo vo = new BoardVo();
		vo = boardService.conDetail(boardNum);
//		System.out.println(vo);

		return vo;
	}
	
	
	
//	 글 작성
	@RequestMapping(value="/board/boardwrite", method = RequestMethod.GET)
	public String getWrite() {

		return "board/boardwrite";
	}
	
	@RequestMapping(value="/board/boardwrite", method = RequestMethod.POST)
	public ModelAndView postWrite(BoardVo vo){
		
		System.out.println("insert boardVo=="+vo);
		boardService.merge(vo); //merge로 해보기
		
//		boardService.write(vo);
//		return new ModelAndView("redirect:boardList");
		ModelAndView mView = new ModelAndView();
		mView.setViewName("redirect:boardList");

		return mView;
	}

//	@RequestMapping(value="/board/boardwrite", method = RequestMethod.POST)
//	public String postWrite(BoardVo vo) {
//		boardService.write(vo);
//	
//		return "redirect:boardList";
//	}
	
	
//	게시글 보기
	@RequestMapping(value = "/board/boardconDetail", method = RequestMethod.GET)
	public String detail(Model model, int boardNum) {
		BoardVo data = boardService.conDetail(boardNum);
		model.addAttribute("data",data);
		return "board/boardconDetail";
	}
	
//	게시글 수정
	@RequestMapping(value="/board/boardupdate", method = RequestMethod.GET)
	public String getUpdate(Model model, int boardNum) {
//		int boardNum, Model model
		BoardVo data = boardService.conDetail(boardNum);
		model.addAttribute("data", data);
		
		return "board/boardupdate";
	}
	
	@RequestMapping(value="/board/boardupdate", method = RequestMethod.POST)
	public String postUpdate(BoardVo vo) {
		//merge사용해서 글쓰기와 업데이트 동시
		boardService.merge(vo);
		System.out.println("update vo=="+vo);
		
//		boardService.update(vo);
		return "redirect:boardList";
		
	}
	
//	게시글 삭제
	@RequestMapping(value="/board/delete")
	public String delete(int boardNum) {
		boardService.delete(boardNum);
		return "redirect:boardList";
	}
	
	
//	PPT 3번째 화면 설계
	@RequestMapping(value="/board/jstest", method = RequestMethod.GET)
	public String jsTest() {
		
		return "board/test";
	}
	
//	계산기
	@RequestMapping(value="/board/calculator", method = RequestMethod.GET)
	public String calculator() {
		
		return "board/calculator"; 
	}

	
	
}




