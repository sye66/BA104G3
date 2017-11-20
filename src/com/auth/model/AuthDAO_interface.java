package com.auth.model;

import java.util.List;

import com.auth.model.AuthVO;

public interface AuthDAO_interface {
	public void insert(AuthVO authVO);
    public void update(AuthVO authVO);
    public void delete(String auth_No);
    public AuthVO findByPrimaryKey(String auth_No);
    public List<AuthVO> getAll();
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<EmpVO> getAll(Map<String, String[]> map);
    public List<AuthVO> getAuth_No();
}
