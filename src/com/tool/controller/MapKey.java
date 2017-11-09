package com.tool.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;


public class MapKey extends HttpServlet {
	Map<String, String> mapPro_display = null;
	
	@SuppressWarnings("unchecked")
	public void init() {
		
		ServletContext context = getServletContext();

		
		// table pro
		mapPro_display = new HashMap<String, String>();
		mapPro_display.put("上架", "上架");
		mapPro_display.put("下架", "下架");
		
		context.setAttribute("mapPro_display", mapPro_display);
		
//		ProMainClassMap = new ProDAO().find_distinct_ProMainClass();
//		context.setAttribute("ProMainClassMap", ProMainClassMap);
	}

	public void destroy() {
		mapPro_display = null;
	}
}
