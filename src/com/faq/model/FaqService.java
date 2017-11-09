package com.faq.model;

import java.sql.Date;
import java.util.List;

public class FaqService {

	private FaqDAO_interface dao;
	
	public FaqService(){
		dao = new FaqDAO();
	}
	
	public FaqVO addFaq(String faq_content, Date faq_date){
		
		FaqVO faqVO = new FaqVO();
		
		faqVO.setFaq_content(faq_content);
		faqVO.setFaq_date(faq_date);
		
		dao.insert(faqVO);
		return faqVO;
	}
	
	public FaqVO updateFaq(String faq_no, String faq_content, Date faq_date){
		
		FaqVO faqVO = new FaqVO();
		
		faqVO.setFaq_no(faq_no);
		faqVO.setFaq_content(faq_content);
		faqVO.setFaq_date(faq_date);
		
		dao.update(faqVO);
		return faqVO;
	}
	
	public void deleteFaq(String faq_no){
		dao.delete(faq_no);
		
	}
	
	public List<FaqVO> getAll(){
		return dao.getAll();
	}
}
