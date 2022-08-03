package woo.edu.c.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import woo.edu.c.controller.HomeController;
import woo.edu.c.dao.BoardDao;
import woo.edu.c.vo.BoardVo;
import woo.edu.c.vo.testVo;


@Service
public class BoardServiceImpl implements BoardService{
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Resource
	private BoardDao boardDao;
	
	@Override
	public List<testVo> test() {
		return boardDao.test();
	}

//	@Override
//	public void getList(ModelAndView mView) {
//		List<BoardVo> list = boardDao.getList();
//		System.out.println("list===="+list);
//		mView.addObject("list", list);
//	}

//	String형식으로 list만들기 위해
	@Override
	public List<BoardVo> getList() {

		return boardDao.getList();
	}

	
//	@Override
//	public int write(BoardVo vo) {
//		return boardDao.insert(vo);
//	}

	@Override
	public BoardVo conDetail(int boardNum) {
		
		return boardDao.conDetail(boardNum);
	}

//	@Override
//	public void update(BoardVo vo) {
//		boardDao.update(vo);
//	}

	@Override
	public int delete(int boardNum) {
		return boardDao.delete(boardNum);
	}

	@Override
	public int merge(BoardVo vo) {
		return boardDao.merge(vo);
	}



	
}
