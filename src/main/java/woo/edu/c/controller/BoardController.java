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
	
	
	// 리스트
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
		System.out.println(list); 
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
		
//		System.out.println("list==="+list);		  
		return list;
	}

//	ajax사용 삭제
	@RequestMapping(value="/board/boardAjaxDelete", method = RequestMethod.GET)
	public void boardAjaxDelete(@RequestParam("getBoardNum") int boardNum) {
		
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
	
	
	
	// 글 작성
	@RequestMapping(value="/board/boardwrite", method = RequestMethod.GET)
	public String getWrite() {

		return "board/boardwrite";
	}
	
	@RequestMapping(value="/board/boardwrite", method = RequestMethod.POST)
	public ModelAndView postWrite(BoardVo vo){
		boardService.write(vo);
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
	
	
	//게시글 보기
	@RequestMapping(value = "/board/boardconDetail", method = RequestMethod.GET)
	public String detail(Model model, int boardNum) {
		BoardVo data = boardService.conDetail(boardNum);
		model.addAttribute("data",data);
		return "board/boardconDetail";
	}
	
	//게시글 수정
	@RequestMapping(value="/board/boardupdate", method = RequestMethod.GET)
	public String getUpdate(Model model, int boardNum) {
//		int boardNum, Model model
		BoardVo data = boardService.conDetail(boardNum);
		model.addAttribute("data", data);
		
		return "board/boardupdate";
	}
	
	@RequestMapping(value="/board/boardupdate", method = RequestMethod.POST)
	public String postUpdate(BoardVo vo) {
		boardService.update(vo);
		return "redirect:boardList";
		
	}
	
	//게시글 삭제
	@RequestMapping(value="/board/delete")
	public String delete(int boardNum) {
		boardService.delete(boardNum);
		return "redirect:boardList";
	}
	
}




