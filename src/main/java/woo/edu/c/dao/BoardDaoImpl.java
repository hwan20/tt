package woo.edu.c.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import woo.edu.c.controller.HomeController;
import woo.edu.c.vo.BoardVo;
import woo.edu.c.vo.testVo;

@Repository
public class BoardDaoImpl implements BoardDao {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	// mybatis
	@Inject
	private SqlSession sql;
	
	private static String namespace = "boardMapper";

	@Override
	public List<testVo> test() {
		return sql.selectList(namespace + ".test");
	}

	//String형식이든 mView형식이든 dao는 바뀌질 않음?
	@Override
	public List<BoardVo> getList() {
		List<BoardVo> list=sql.selectList(namespace + ".boardList");
		//return list;
		return sql.selectList(namespace + ".boardList");
	}

//	@Override
//	public int insert(BoardVo vo) {
//		return sql.insert(namespace + ".insert", vo);
//	}

	@Override
	public BoardVo conDetail(int boardNum) {
		//하나의 게시글만 가져올 때는 selectOne
		return sql.selectOne(namespace + ".conDetail", boardNum);
	}

//	@Override
//	public void update(BoardVo vo) {
//		sql.update(namespace + ".update", vo);
//	}

	@Override
	public int delete(int boardNum) {
		return sql.delete(namespace + ".delete", boardNum);
	}

	@Override
	public int merge(BoardVo vo) {
//		이렇게 두 개를 같이 사용하면 X 
//		sql.update(namespace + ".update", vo);
		return sql.insert(namespace + ".merge", vo);
	}

	
}
