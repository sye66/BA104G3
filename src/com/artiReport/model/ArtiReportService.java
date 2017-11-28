package com.artiReport.model;

import java.util.Set;

import com.artiForm.model.ArtiFormVO;
import com.artiReply.model.ArtiReplyVO;

public class ArtiReportService {
	
	private ArtiReportDAO_interface dao;
	
	public ArtiReportService(){
		dao = new ArtiReportDAO();
	}
	
	public ArtiReportVO addArtiReport (String mem_No, String arti_No, String report_Desc, java.sql.Timestamp report_Time, String rep_Re_Desc, String report_Status){
		
		ArtiReportVO artiReportVO = new ArtiReportVO();
		artiReportVO.setMem_No(mem_No);
		artiReportVO.setArti_No(arti_No);
		artiReportVO.setReport_Desc(report_Desc);
		artiReportVO.setReport_Time(report_Time);
		artiReportVO.setRep_Re_Desc(rep_Re_Desc);
		artiReportVO.setReport_Status(report_Status);
		dao.insertReport(artiReportVO);
		
		return artiReportVO;
	}
	
	public ArtiReportVO updateArtiReport (String report_No, String mem_No, String arti_No, String report_Desc, java.sql.Timestamp report_Time, String rep_Re_Desc, String report_Status){
		
		ArtiReportVO artiReportVO = new ArtiReportVO();
		artiReportVO .setReport_No(report_No);
		artiReportVO .setMem_No(mem_No);
		artiReportVO .setArti_No(arti_No);
		artiReportVO .setReport_Desc(report_Desc);
		artiReportVO .setReport_Time(report_Time);
		artiReportVO .setRep_Re_Desc(rep_Re_Desc);
		artiReportVO .setReport_Status(report_Status);
		dao.updateReport(artiReportVO);
		
		return artiReportVO;
	}
	

	
	public void deleteArtiReport(String report_No){
		dao.deleteReport(report_No);
	}
	
	public ArtiReportVO getOneArtiReport(String report_No){
		return dao.findByPrimaryKey(report_No);
	}
	
	public Set<ArtiReportVO> getAllReport(){
		return dao.getAllReport();
	}
	
	public Set<ArtiReportVO> findReportByArtiNo(String arti_No){
		return dao.findReportByArtiNo(arti_No);
	}
	
	public Set<ArtiReportVO> findReportByMemNo(String mem_No){
		return dao.findReportByMemNo(mem_No);
	}

}
