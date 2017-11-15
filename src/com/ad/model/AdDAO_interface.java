package com.ad.model;

import java.util.Set;

public interface AdDAO_interface {
	public void insertAd(AdVO adVO);
	public void updateAd(AdVO adVO);
	public void deleteAd(String ad_No);
	public AdVO findByPrimaryKey(String ad_No);
	public Set<AdVO> getAllAd();

}
