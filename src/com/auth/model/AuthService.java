package com.auth.model;

import java.util.List;

public class AuthService {
	private AuthDAO_interface dao;
	
	public AuthService(){
		dao = new AuthDAO();
	}
	
	public AuthVO addAuth(String auth_Name){
		
		AuthVO authVO = new AuthVO();
		
		authVO.setAuth_Name(auth_Name);
		dao.insert(authVO);
		return authVO;
	}
	
	public AuthVO updateAuth(String auth_No,String auth_Name){
		
		AuthVO authVO = new AuthVO();
		
		authVO.setAuth_No(auth_No);
		authVO.setAuth_Name(auth_Name);
		dao.update(authVO);
		return authVO;
	}
	
	public AuthVO getOneAuth(String auth_No){
		return dao.findByPrimaryKey(auth_No);
	}
	
	public List<AuthVO> getAll(){
		return dao.getAll();
	}
	
	public void deleteAuth(String auth_No) {
		dao.delete(auth_No);
	}
}
