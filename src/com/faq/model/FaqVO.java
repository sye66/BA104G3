package com.faq.model;

import java.sql.Date;

public class FaqVO {
	private String faq_No;
	private String faq_Content;
	private Date faq_Date;
	public String getFaq_No() {
		return faq_No;
	}
	public void setFaq_No(String faq_No) {
		this.faq_No = faq_No;
	}
	public String getFaq_Content() {
		return faq_Content;
	}
	public void setFaq_Content(String faq_Content) {
		this.faq_Content = faq_Content;
	}
	public Date getFaq_Date() {
		return faq_Date;
	}
	public void setFaq_Date(Date faq_Date) {
		this.faq_Date = faq_Date;
	}
	
	
	
	
}
