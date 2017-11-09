package com.pro.model;
import java.util.List;

public interface ProDAO_interface {
		public void insert(ProVO proVO);
		public void update(ProVO proVO);
		public void delete(String pro_no);
		public List<ProVO>getAll();
		public ProVO findByPrimaryKey(String pro_no);
}
