package woo.edu.c.vo;

public class ScheduleVo {

	private int calno;
	private String calyear;
	private String calmonth;
	private String calday;
	private String caltime;
	private String calreq;
	private String caldate;
	private String calcontents;

	public ScheduleVo() {}
	
	@Override
	public String toString() {
		return "ScheduleVo [calno=" + calno + ", calyear=" + calyear + ", calmonth=" + calmonth + ", calday=" + calday
				+ ", caltime=" + caltime + ", calreq=" + calreq + ", caldate=" + caldate + ", calcontents="
				+ calcontents + "]";
	}
	
	public int getCalno() {
		return calno;
	}

	public void setCalno(int calno) {
		this.calno = calno;
	}

	public String getCalyear() {
		return calyear;
	}

	public void setCalyear(String calyear) {
		this.calyear = calyear;
	}

	public String getCalmonth() {
		return calmonth;
	}

	public void setCalmonth(String calmonth) {
		this.calmonth = calmonth;
	}

	public String getCalday() {
		return calday;
	}

	public void setCalday(String calday) {
		this.calday = calday;
	}

	public String getCaltime() {
		return caltime;
	}

	public void setCaltime(String caltime) {
		this.caltime = caltime;
	}

	public String getCalreq() {
		return calreq;
	}

	public void setCalreq(String calreq) {
		this.calreq = calreq;
	}

	public String getCaldate() {
		return caldate;
	}

	public void setCaldate(String caldate) {
		this.caldate = caldate;
	}

	public String getCalcontents() {
		return calcontents;
	}

	public void setCalcontents(String calcontents) {
		this.calcontents = calcontents;
	}
	
	
	
}
