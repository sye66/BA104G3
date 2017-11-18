package com.proorder.model;

import java.sql.Date;
import java.util.List;

import com.pro.shoppingcart.ProCartVO;

public class ProOrderService {
	private ProOrderDAO_interface dao;
	public ProOrderService(){
		dao = new ProOrderJDBCDAO();
	}
	
	public ProOrderVO addProOrder(String mem_No ,Date ord_Date,Integer ord_Price,String ord_Consignee,String ord_Address,String ord_Phone,String ord_Shipinfo,Date ord_Ship_Date){
		ProOrderVO proOrderVO = new ProOrderVO();
		
		proOrderVO.setMem_No(mem_No);
		proOrderVO.setOrd_Date(ord_Date);
		proOrderVO.setOrd_Price(ord_Price);
		proOrderVO.setOrd_Consignee(ord_Consignee);
		proOrderVO.setOrd_Address(ord_Address);
		proOrderVO.setOrd_Phone(ord_Phone);
		proOrderVO.setOrd_Shipinfo(ord_Shipinfo);
		proOrderVO.setOrd_Ship_Date(ord_Ship_Date);
		
		dao.insert(proOrderVO);
		return proOrderVO;
	}
	
	public ProOrderVO updateProOrder(String mem_No ,Date ord_Date,Integer ord_Price,String ord_Consignee,String ord_Address,String ord_Phone,String ord_Shipinfo,Date ord_Ship_Date){
		ProOrderVO proOrderVO = new ProOrderVO();
		
		proOrderVO.setMem_No(mem_No);
		proOrderVO.setOrd_Date(ord_Date);
		proOrderVO.setOrd_Price(ord_Price);
		proOrderVO.setOrd_Consignee(ord_Consignee);
		proOrderVO.setOrd_Address(ord_Address);
		proOrderVO.setOrd_Phone(ord_Phone);
		proOrderVO.setOrd_Shipinfo(ord_Shipinfo);
		proOrderVO.setOrd_Ship_Date(ord_Ship_Date);
		
		dao.insert(proOrderVO);
		return proOrderVO;
	}
	
	public List<ProOrderVO> getAll() {
		return dao.getAll();

	}
	public ProOrderVO getOneProOrder(String ord_No){
		return dao.findByPrimaryKey(ord_No);
		          
	}
	
	public void deleteProOrder(String ord_No){
		dao.delete(ord_No);
	}
	
	public void addProOrd_OrdList(ProOrderVO proOrderVO , List<ProCartVO> list){
		dao.insertProOrder_ProOrdList(proOrderVO, list);
	}
	public List<ProOrderVO> listProOrder(String mem_No) {
		return dao.listProOrder(mem_No);

	}
	public ProOrderVO updateProOrderUp(String ord_No,String ord_Shipinfo,Date ord_Ship_Date){
		ProOrderVO proOrderVO = new ProOrderVO();
		
		proOrderVO.setMem_No(ord_No);
		proOrderVO.setOrd_Shipinfo(ord_Shipinfo);
		proOrderVO.setOrd_Ship_Date(ord_Ship_Date);
		
		dao.updateOrderUp(proOrderVO);
		return proOrderVO;
	}
}
