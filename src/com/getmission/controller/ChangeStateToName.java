package com.getmission.controller;

public class ChangeStateToName {

	
	public String ChangeStateToName(int mission_State){
		String StateName=null;
		
		if(mission_State ==1){
			StateName= "還沒有人接案喔";
		}else if(mission_State ==2){
			StateName= "哇~已經有人接囉~要參與請趕快";
		}else if(mission_State ==3){
			StateName= "親愛的會員請趕快與發案人聯繫確認身分";
		}else if(mission_State ==4){
			StateName= "親愛的會員請快快完成任務喔~";
		}else if(mission_State ==5){
			StateName= "嘿~此任務已完成囉";
		}else if(mission_State ==6){
			StateName= "糟糕這個任務已經失敗囉!";
		}else if(mission_State ==7){
			StateName= "恩..此任務正在被檢舉中,要接取請考慮喔";
		}else if(mission_State ==72){
			StateName= "有人接案但是被檢舉中,請會員考慮要不要參與";
		}else if(mission_State ==8){
			StateName= "目前任務已完成但進入爭議事件中~";
		}else if(mission_State ==9){
			StateName="不好意思,目前任務已失效囉~請去瞧瞧別的吧~";
		}
		return StateName;
	}
	
	public String ChangePatternToName(int mission_Pattern){
		String Pattern  = null;
		if(mission_Pattern==1){
			Pattern = "緊急";
		}else if(mission_Pattern==2){
			Pattern = "一般";
		}
		return Pattern;
		
		
	}
}
