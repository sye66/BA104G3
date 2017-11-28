package com.artiReport.model;

import java.util.Set;

public interface ArtiReportDAO_interface {
	
	public void insertReport(ArtiReportVO artiReportVO);
	public void updateReport (ArtiReportVO artiReportVO);
	public void deleteReport (String report_No);
	
	public ArtiReportVO findByPrimaryKey (String report_No);
	public Set<ArtiReportVO> getAllReport();
	public Set<ArtiReportVO> findReportByArtiNo(String arti_No);
	public Set<ArtiReportVO> findReportByMemNo(String mem_No);
	

}
