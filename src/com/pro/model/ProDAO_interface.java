package com.pro.model;
import java.util.List;
import java.util.Map;


public interface ProDAO_interface {
		public void insert(ProVO proVO);
		public void update(ProVO proVO);
		public void delete(String pro_no);
		public List<ProVO>getAll();
		public ProVO findByPrimaryKey(String pro_no);
		 //萬用複合查詢(傳入參數型態Map)(回傳 List)
        public List<ProVO> getAll(Map<String, String[]> map);
        //查促銷商品
        public List<ProVO>getHot();
        //查詢TOP10
        public List<ProVO>getTop10();
}
