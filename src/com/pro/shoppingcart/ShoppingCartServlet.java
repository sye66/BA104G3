package com.pro.shoppingcart;

import java.io.IOException;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;





public class ShoppingCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ShoppingCartServlet() {
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		@SuppressWarnings("unchecked")//清除警告提示
		List<ProCartVO> buylist = (Vector<ProCartVO>) session.getAttribute("shoppingcart");
		String action = req.getParameter("action");
System.out.println(action);		
		if (!action.equals("checkOut")) {
System.out.println("商品");		
			if (action.equals("deletePro")) {
				String del = req.getParameter("del");
				int d = Integer.parseInt(del);
				buylist.remove(d);
System.out.println("刪除商品");				
				
			}else if(action.equals("addPro")){
System.out.println("加入商品");				
				ProCartVO proCartVO = getProCartVO(req);
System.out.println("getProCartVO"+proCartVO.getProCar_Name());				
				if(buylist==null){
					buylist = new Vector<ProCartVO>();
					buylist.add(proCartVO);
System.out.println("空的加入"+buylist.size());
				}else{
					if(buylist.contains(proCartVO)){
						ProCartVO innerProCartVO = buylist.get(buylist.indexOf(proCartVO));
						innerProCartVO.setProCar_Quantity(innerProCartVO.getProCar_Quantity()+proCartVO.getProCar_Quantity());
System.out.println("重複的加入"+buylist.size());					
					}else{
						buylist.add(proCartVO);
System.out.println("沒重複的加入"+buylist.size());						
					}
				}
			}
			
			session.setAttribute("shoppingcart", buylist);
System.out.println(buylist.size());			
//			String url = req.getParameter("requestURL");
			String url = "/frontdesk/pro/cart.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);
			
		}else if(action.equals("CheckOut")){
System.out.println("結帳");
			double total = 0;
			for (int i = 0; i < buylist.size(); i++) {
				ProCartVO proCartVO = buylist.get(i);
				Double price = proCartVO.getProCar_Price();
				Integer quantity = proCartVO.getProCar_Quantity();
				total += (price * quantity);
			}

			String amount = String.valueOf(total);
			req.setAttribute("amount", amount);
System.out.println("暫時回商城首頁");			
			String url = "/frontdesk/showAllPro/cart.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);

		}
		
	}

	
	
	
	private ProCartVO getProCartVO(HttpServletRequest req) {

		String proCar_No = req.getParameter("proCar_No");
		String proCar_Name = req.getParameter("proCar_Name");
		String proCar_Info = req.getParameter("proCar_Info");
		String proCar_Price = req.getParameter("proCar_Price");
		String proCar_Quantity = req.getParameter("proCar_Quantity");

	System.out.println(proCar_No);	
	System.out.println(proCar_Name);
	System.out.println(proCar_Info);
	System.out.println(proCar_Price);
	System.out.println(proCar_Quantity);
	
	
		ProCartVO proCartVO = new ProCartVO();
		
		proCartVO.setProCar_No(proCar_No);
		proCartVO.setProCar_Name(proCar_Name);
		proCartVO.setProCar_Info(proCar_Info);
		proCartVO.setProCar_Price(new Double(proCar_Price));
		proCartVO.setProCar_Quantity((new Integer(proCar_Quantity)).intValue());
		return proCartVO;
	}
	
	
	
}
