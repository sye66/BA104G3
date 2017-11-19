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

import com.mem.model.MemVO;
import com.pro.model.ProService;
import com.pro.model.ProVO;
import com.protrack.model.ProTrackService;

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

		@SuppressWarnings("unchecked") // 清除警告提示
		List<ProCartVO> buylist = (Vector<ProCartVO>) session.getAttribute("shoppingcart");
		String action = req.getParameter("action");
		String requestURL = req.getParameter("requestURL");
		String mem_No =	req.getParameter("mem_No");					  
System.out.println("購物車來源網頁: "+ requestURL);



		if (!action.equals("checkOut")) {
			//刪除購物車商品
			if (action.equals("deletePro")) {
				String del = req.getParameter("del");
System.out.println("購物車刪除商品 index: "+del);
				int d = Integer.parseInt(del);
				buylist.remove(d);
		
			} else if (action.equals("addPro")) { //購物車加入商品
System.out.println("購物車增加商品");				
				ProCartVO proCartVO = getProCartVO(req);
				if (buylist == null) {
					buylist = new Vector<ProCartVO>();
					buylist.add(proCartVO);
				} else {
					if (buylist.contains(proCartVO)) {
						ProCartVO innerProCartVO = buylist.get(buylist.indexOf(proCartVO));
						innerProCartVO.setProCar_Quantity(
								innerProCartVO.getProCar_Quantity() + proCartVO.getProCar_Quantity());
					} else {
						buylist.add(proCartVO);
					}
				}
			}else if (action.equals("addPro2")) { //從最愛加入 購物車商品
System.out.println("從清單 放商品 到購物車");
				ProCartVO proCartVO = getProCartVO2(req);
				if (buylist == null) {
					buylist = new Vector<ProCartVO>();
					buylist.add(proCartVO);
				} else {
					if (buylist.contains(proCartVO)) {
						ProCartVO innerProCartVO = buylist.get(buylist.indexOf(proCartVO));
						innerProCartVO.setProCar_Quantity(
								innerProCartVO.getProCar_Quantity() + proCartVO.getProCar_Quantity());
					} else {
						buylist.add(proCartVO);
					}
				}
			}

			session.setAttribute("shoppingcart", buylist);
			String url = null;
			
			if(requestURL.equals("/frontdesk/pro/cart.jsp")){
				url = "/frontdesk/pro/cart.jsp";
				System.out.println("刪除購物車商品 回購物車 url: "+url);	
			}else{
					
				url = "/frontdesk/pro/showProIndex.jsp";
System.out.println("回商城首頁 url: "+url); 
			}
//System.out.println("購物車引入路徑"+requestURL);			
//				 url=requestURL;
//			}else{
//				 url = "/frontdesk/pro/cart.jsp";
					 
//			}
			// String url = req.getParameter("requestURL");
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);

		} else if (action.equals("checkOut")) {
			Integer total = 0;
			for (int i = 0; i < buylist.size(); i++) {
				ProCartVO proCartVO = buylist.get(i);
				Integer price = proCartVO.getProCar_Price();
				Integer quantity = proCartVO.getProCar_Quantity();
				total += (price * quantity);
			}

			String totalPrice = String.valueOf(total);
			req.setAttribute("totalPrice", totalPrice);
			String url = "/frontdesk/proOrder/addProOrder.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url);
			rd.forward(req, res);

		}

	}

	private ProCartVO getProCartVO(HttpServletRequest req) {

		String proCar_No = req.getParameter("proCar_No");
		String proCar_Name = req.getParameter("proCar_Name");
		String proCar_Info = req.getParameter("proCar_Info");
		Integer proCar_Price = new Integer(req.getParameter("proCar_Price"));
		Integer proCar_Quantity = new Integer(req.getParameter("proCar_Quantity"));

		//刪除在清單商品
//		String mem_No = req.getParameter("mem_No");
//		ProTrackService proTrackSvc = new ProTrackService();
//		proTrackSvc.deleteProTrack(mem_No,proCar_No);
		
		ProCartVO proCartVO = new ProCartVO();

		proCartVO.setProCar_No(proCar_No);
		proCartVO.setProCar_Name(proCar_Name);
		proCartVO.setProCar_Info(proCar_Info);
		proCartVO.setProCar_Price(new Integer(proCar_Price));
		proCartVO.setProCar_Quantity((new Integer(proCar_Quantity)).intValue());
		return proCartVO;
	}
	
	private ProCartVO getProCartVO2(HttpServletRequest req) {

		String pro_No = req.getParameter("proCar_No");
		String mem_No = req.getParameter("mem_No");
		//刪除在清單商品
		ProTrackService proTrackSvc = new ProTrackService();
		proTrackSvc.deleteProTrack(mem_No,pro_No);
		
		ProService proSvc = new ProService();
		ProVO proVO = proSvc.getOnePro(pro_No);
		//折扣價
		Integer price =(Integer) (proVO.getPro_Price()*proVO.getPro_Discount()/100);
		
		ProCartVO proCartVO = new ProCartVO();
		
		proCartVO.setProCar_No(proVO.getPro_No());
		proCartVO.setProCar_Name(proVO.getPro_Name());
		proCartVO.setProCar_Info(proVO.getPro_Info());
		proCartVO.setProCar_Price(new Integer(price));
		proCartVO.setProCar_Quantity(new Integer(1));
		
		return proCartVO;
	}

}
