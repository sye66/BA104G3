package com.pro.model;
import java.sql.Date;
import java.util.List;
import java.util.Map;


public class ProService {
	private ProDAO_interface dao;
	public ProService(){
		dao = new ProDAO();
	}

	
	public ProVO addPro(String pro_Name,Integer pro_Price,String pro_Info,
			String pro_Class_No,String pro_Status,Integer pro_Discount,
			Date pro_Dis_StartDAte,Date pro_Dis_EndDate,byte[] pro_Pic){
		ProVO proVO = new ProVO();
		proVO.setPro_Name(pro_Name);
		proVO.setPro_Price(pro_Price);
		proVO.setPro_Info(pro_Info);
		proVO.setPro_Class_No(pro_Class_No);
		proVO.setPro_Status(pro_Status);
		proVO.setPro_Discount(pro_Discount);
		proVO.setPro_Dis_StartDate(pro_Dis_StartDAte);
		proVO.setPro_Dis_EndDate(pro_Dis_EndDate);
		proVO.setPro_Pic(pro_Pic);
		dao.insert(proVO);
		return proVO;
		
	}

	public ProVO updatePro(String pro_Name,Integer pro_Price,String pro_Info,
			String pro_Class_No,String pro_Status,Integer pro_Discount
			,Date pro_Dis_StartDate,Date pro_Dis_EndDate,byte[] pro_Pic,String pro_No
			){
		ProVO proVO = new ProVO();
		proVO.setPro_Name(pro_Name);
		proVO.setPro_Price(pro_Price);
		proVO.setPro_Info(pro_Info);
		proVO.setPro_Class_No(pro_Class_No);
		proVO.setPro_Status(pro_Status);
		proVO.setPro_Discount(pro_Discount);
		proVO.setPro_Dis_StartDate(pro_Dis_StartDate);
		proVO.setPro_Dis_EndDate(pro_Dis_EndDate);
		proVO.setPro_Pic(pro_Pic);
		proVO.setPro_No(pro_No);
		dao.update(proVO);
		return proVO;
		
	}	
	public List<ProVO> getAll() {
		return dao.getAll();

	}
	public ProVO getOnePro(String pro_No){
		return dao.findByPrimaryKey(pro_No);
	}
	
	public void deletePro(String pro_No){
		dao.delete(pro_No);
	}
	public List<ProVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	public List<ProVO> getHot() {
		return dao.getHot();
	}
	public List<ProVO> getTop10() {
		return dao.getTop10();
	}
}
