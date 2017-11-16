/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *        所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */

package com.tool.controller;

import java.util.*;

public class jdbcUtil_CompositeQuery_Pro {

	public static String get_aCondition_For_Oracle(String columnName, String value) {

		String aCondition = null;

		if ("pro_Price".equals(columnName) || "pro_Discount".equals(columnName) ) //其他
			aCondition = columnName + "=" + value;
		else if ("pro_No".equals(columnName) || "pro_Class_No".equals(columnName)|| "pro_Name".equals(columnName)|| "pro_Info".equals(columnName)|| "pro_Status".equals(columnName)) // 用於varchar
			aCondition = columnName + " like '%" + value + "%'";
		else if ("pro_Dis_StartDate".equals(columnName)||"pro_Dis_EndDate".equals(columnName)) // 用於Oracle的date 其他資料庫可以把to_char去掉
			aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')='" + value + "'";

		return aCondition + " ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0	&& !"action".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());

				if (count == 1)
					whereCondition.append(" where " + aCondition);//where and 前後記得留空
				else
					whereCondition.append(" and " + aCondition);

			}
		}
		
		return whereCondition.toString();
	}

	public static void main(String argv[]) {

		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("pro_No", new String[] { "" });
		map.put("pro_Name", new String[] { "小" });
		map.put("pro_Class_No", new String[] { "" });
		map.put("pro_Info", new String[] { "" });
		map.put("pro_Price", new String[] { "" });
		map.put("pro_Status", new String[] { "" });
		map.put("pro_Discount", new String[] { "" });
		map.put("pro_Dis_StartDate", new String[] { "" }); 
		map.put("pro_Dis_EndDate", new String[] { "" }); 
		map.put("action", new String[] { "getXXX" });// 注意Map裡面會含有action的key
		String finalSQL = "select * from pro "
				          + jdbcUtil_CompositeQuery_Pro.get_WhereCondition(map)
				          + "order by pro_No";

	}
}
