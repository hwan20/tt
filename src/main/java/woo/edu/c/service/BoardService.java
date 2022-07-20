package woo.edu.c.service;

import java.util.List;

import woo.edu.c.vo.BoardVo;
import woo.edu.c.vo.testVo;

public interface BoardService {

	List<testVo> test();
	
//	public void getList(ModelAndView mView); //boardList에서 mView형식으로 사용할 때
	public List<BoardVo> getList(); //boardAjaxList에서 String형식으로 사용하기 위해 선언 
	public void write(BoardVo vo);
	public BoardVo conDetail(int boardNum);
	public void update(BoardVo vo);
	public void delete(int boardNum);
}
