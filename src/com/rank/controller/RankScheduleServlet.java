package com.rank.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;



public class RankScheduleServlet extends HttpServlet{    
	private static final long serialVersionUID = 1L;
	Timer timer ; 
    int count = 0;
    
    public void destroy(){
        timer.cancel();
    }
    
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
    	
    }
            
    public void init(){        
        timer = new Timer();
        Calendar cal = new GregorianCalendar(2011, Calendar.MARCH, 5, 0, 0, 0);        
        TimerTask task = new TimerTask(){
                   
            public void run(){
               
            }
        };
        timer.scheduleAtFixedRate(task, cal.getTime(), 60*60*1000); 
    }
}
