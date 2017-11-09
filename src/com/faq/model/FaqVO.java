package com.faq.model;

import java.sql.Date;

public class FaqVO {
	private String faq_no;
	private String faq_content;
	private Date faq_date;
	
	public String getFaq_no() {
		return faq_no;
	}
	public void setFaq_no(String faq_no) {
		this.faq_no = faq_no;
	}
	public String getFaq_content() {
		return faq_content;
	}
	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}
	public Date getFaq_date() {
		return faq_date;
	}
	public void setFaq_date(Date faq_date) {
		this.faq_date = faq_date;
	}
	
	
}
