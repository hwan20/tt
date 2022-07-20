package woo.edu.c.vo;

public class BoardVo {

	private int boardNum;
	private String boardTitle;
	private String boardName;
	private String boardDate;
	private String boardCon;
	
	
	@Override
	public String toString() {
		return "BoardVo [boardNum=" + boardNum + ", boardTitle=" + boardTitle + ", boardName=" + boardName
				+ ", boardDate=" + boardDate + ", boardCon=" + boardCon + "]";
	}
	public BoardVo() {}

	//하나의 생성자도 없을 경우에 자동으로 생성자를 생성해줌, 작성 안 해도 자동으로 생성해 주니 무방하다
	//객체(인스턴스) 변수를 초기화해주는 기능
	//https://aljjabaegi.tistory.com/408
	public BoardVo(int boardNum, String boardTitle, String boardName, String boardDate, String boardCon) {
		super();//오브젝트
		this.boardNum = boardNum;
		this.boardTitle = boardTitle;
		this.boardName = boardName;
		this.boardDate = boardDate;
		this.boardCon = boardCon;
	}

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardName() {
		return boardName;
	}

	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}

	public String getBoardCon() {
		return boardCon;
	}

	public void setBoardCon(String boardCon) {
		this.boardCon = boardCon;
	}

	
}
