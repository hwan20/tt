package woo.edu.c.dao;

import java.util.List;

import woo.edu.c.vo.BoardVo;
import woo.edu.c.vo.testVo;

public interface BoardDao {

	List<testVo> test();
	
	public List<BoardVo> getList(); //String형식이든 mView형식이든 dao는 바뀌질 않는듯?
	public int insert(BoardVo vo);
	public BoardVo conDetail(int boardNum);
	public void update(BoardVo vo);
	public int delete(int boardNum);
}
