package com.faq.model;

import java.sql.Date;
import java.util.List;

public class FaqService {

	private FaqDAO_interface dao;
	
	public FaqService(){
		dao = new FaqDAO();
	}
	
	public FaqVO addFaq(String faq_Content, Date faq_Date){
		
		FaqVO faqVO = new FaqVO();
		
		faqVO.setFaq_Content(faq_Content);
		faqVO.setFaq_Date(faq_Date);
		
		dao.insert(faqVO);
		return faqVO;
	}
	
	public FaqVO updateFaq(String faq_No, String faq_Content, Date faq_Date){
		
		FaqVO faqVO = new FaqVO();
		
		faqVO.setFaq_No(faq_No);
		faqVO.setFaq_Content(faq_Content);
		faqVO.setFaq_Date(faq_Date);
		
		dao.update(faqVO);
		return faqVO;
	}
	
	public void deleteFaq(String faq_No){
		dao.delete(faq_No);
		
	}
	
	public List<FaqVO> getAll(){
		return dao.getAll();
	}
}
