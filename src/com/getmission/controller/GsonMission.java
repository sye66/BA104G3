package com.getmission.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.getmission.model.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;


public class GsonMission  {

	public static void main(String[] args) {
		
		Gson gson=  new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String jsonStr = "";
		
		GetMissionService getMissionSvc = new GetMissionService();
		List<GetMissionVO> list = getMissionSvc.getAllValidMission();
		jsonStr = gson.toJson(list);
		System.out.println(jsonStr);
		
	}

	
	

}
