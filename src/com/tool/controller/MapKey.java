package com.tool.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;


public class MapKey extends HttpServlet {
	Map<Integer, String> mapPro_display = null;
	Map<String, String> mapPro_display2 = null;
//	@SuppressWarnings("unchecked")
	
	public void init() {
		
		ServletContext context = getServletContext();

		
		// table pro
		mapPro_display = new HashMap<Integer, String>();
		mapPro_display.put(0, "上架");
		mapPro_display.put(1, "下架");
		
		mapPro_display2 = new HashMap<String, String>();
		mapPro_display2.put("up", "上架");
		mapPro_display2.put("under", "下架");
System.out.println("MapKey已執行");		
		
		context.setAttribute("mapPro_display", mapPro_display);
		context.setAttribute("mapPro_display2", mapPro_display2);
//		ProMainClassMap = new ProDAO().find_distinct_ProMainClass();
//		context.setAttribute("ProMainClassMap", ProMainClassMap);
	}

	public void destroy() {
		mapPro_display = null;
		mapPro_display2 = null;
System.out.println("MapKey已清空");
	}
}
