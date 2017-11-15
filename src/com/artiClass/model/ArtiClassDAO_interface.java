package com.artiClass.model;

import java.util.*;

import com.artiForm.model.ArtiFormVO;

public interface ArtiClassDAO_interface {
    public void insert(ArtiClassVO artiClassVO);
    public void update(ArtiClassVO artiClassVO);
    public void delete(Integer arti_Cls_No);
    public ArtiClassVO findByPrimaryKey(Integer arti_Cls_No);
    public List<ArtiClassVO> getAll();
    //查詢某部門的員工(一對多)(回傳 Set)
    public Set<ArtiFormVO> getArti_NoByArti_Cls_No(Integer arti_Cls_No);
	
}
