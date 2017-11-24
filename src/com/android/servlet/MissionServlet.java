package com.android.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.android.model.*;




@WebServlet("/MissionServlet")
public class MissionServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		doPost(req, res);
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		BufferedReader br = req.getReader();
		StringBuffer jsonIn = new StringBuffer();
		String line = null;
		while ((line = br.readLine()) != null) {
			jsonIn.append(line);
		}
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(),
				JsonObject.class);
		MissionDAO missionDAO = new MissionDAO();
		Mission_ImagesDAO mission_ImagesDAO = new Mission_ImagesDAO();
		Case_CandidateDAO case_CandidateDAO = new Case_CandidateDAO();
		AccuseCaseDAO accuseCaseDAO = new AccuseCaseDAO(); 
		Case_CandidateService case_CandidateSvc = new Case_CandidateService();
		Mission_ImagesService mission_ImagesSvc = new Mission_ImagesService();
		MissionService missionSvc = new MissionService();
		DisputeCaseService disputcaseSvc = new DisputeCaseService();
		DisputeCaseDAO disputcaseDAO = new DisputeCaseDAO();
		String action = jsonObject.get("action").getAsString();

		//�d��������
		if ("getAll".equals(action)) {
			List<MissionVO> missionList = missionDAO.getAll();
			writeText(res, gson.toJson(missionList));
		}else
		if("getSearchMission".equals(action)){
			List<MissionVO> missionList = missionDAO.getSearchMission();
			writeText(res, gson.toJson(missionList));
		}else //���פH������
		if("getByTakecaseMem".equals(action)) {
			String takecase_Mem_No = jsonObject.get("mem_No").getAsString();
			System.out.println(takecase_Mem_No);
			List<MissionVO> takeList = missionDAO.getByTakecaseMem(takecase_Mem_No);
			writeText(res,gson.toJson(takeList));
		}else //�i�椤
		if ("getByTakecaseMemUnfinished".equals(action)){
			String takecase_Mem_No = jsonObject.get("mem_No").getAsString();
			System.out.println(takecase_Mem_No);
			List<MissionVO> takeList = missionDAO.getByTakecaseMemUnfinished(takecase_Mem_No);
			writeText(res,gson.toJson(takeList));
		}else //���פH�w���ת�����
		if("getByTakecaseMemClosed".equals(action)) {
				String takecase_Mem_No = jsonObject.get("mem_No").getAsString();
				System.out.println(takecase_Mem_No);
				List<MissionVO> takeList = missionDAO.getByTakecaseMemClosed(takecase_Mem_No);
				writeText(res,gson.toJson(takeList));
		}else //�d���Ƚs��
		if("findByPrimaryKey".equals(action)) {
			String mission_No = jsonObject.get("mission_No").getAsString();
			MissionVO mission = missionDAO.findByPrimaryKey(mission_No);
			writeText(res,gson.toJson(mission));
		}else //�dfa�פH
			if("getByIssuerMem".equals(action)){
			String issuer_Mem_No = jsonObject.get("mem_No").getAsString();
			List<MissionVO> issuerList = missionDAO.getByIssuerMem(issuer_Mem_No);
			writeText(res,gson.toJson(issuerList));
		} else //�dfa�פH
			if("getByIssuerMemResponse".equals(action)){
			String issuer_Mem_No = jsonObject.get("mem_No").getAsString();
			List<MissionVO> issuerList = missionDAO.getByIssuerMemResponse(issuer_Mem_No);
			writeText(res,gson.toJson(issuerList));
		} else //�dfa�פH
			if("getByIssuerMemProcess".equals(action)){
			String issuer_Mem_No = jsonObject.get("mem_No").getAsString();
			List<MissionVO> issuerList = missionDAO.getByIssuerMemProcess(issuer_Mem_No);
			writeText(res,gson.toJson(issuerList));
		} else //�dfa�פH
			if("getByIssuerMemClosed".equals(action)){
			String issuer_Mem_No = jsonObject.get("mem_No").getAsString();
			List<MissionVO> issuerList = missionDAO.getByIssuerMemClosed(issuer_Mem_No);
			writeText(res,gson.toJson(issuerList));
		} else //�R������ �٭n�R���Կ�H��Ϥ�
			if("delete".equals(action)){
			String mission_No = jsonObject.get("mission_No").getAsString();
			case_CandidateSvc.deleteCaseCandidateByMissionNo(mission_No);
			mission_ImagesSvc.deleteMissionImagesByMissionNo(mission_No);
//�᭱�٦����|��ĳ����
			missionDAO.deleteAccuse_Case(mission_No);
			missionDAO.delete(mission_No);
		} else //�s�W�Χ�s
			if ("insert".equals(action) || "update".equals(action)) {
				String missionJson = jsonObject.get("mission").getAsString();
				MissionVO mission = gson.fromJson(missionJson, MissionVO.class);
				String imageBase64 = null;
				try{
					imageBase64 = jsonObject.get("imageBase64").getAsString();
				} catch (Exception e){
					e.printStackTrace();
				}
				byte[] mission_Pic = null;
				if(imageBase64!=null){
					mission_Pic = Base64.getMimeDecoder().decode(imageBase64);			
				}
				if ("insert".equals(action)) { //�s�W����
					try{
						missionDAO.insert(mission);			
						List<MissionVO> issuerList = missionDAO.getByIssuerMem(mission.getIssuer_Mem_No());
						System.out.println(mission_Pic);
						if(mission_Pic==null){
							Mission_ImagesVO mission_ImagesVO=mission_ImagesSvc.insertMissionImagesNoimage(issuerList.get(issuerList.size()-1).getMission_No(),mission.getIssuer_Mem_No());
						} else{
							Mission_ImagesVO mission_ImagesVO=mission_ImagesSvc.insertMissionImages(issuerList.get(issuerList.size()-1).getMission_No(),mission.getIssuer_Mem_No(),mission_Pic);
						}
						System.out.println("ok");
					}catch(Exception e){
						System.out.println("nok");
						System.out.println(mission_Pic);
						e.printStackTrace();
					}
				} else if (action.equals("update")) { //��s ������
					try{
						missionDAO.update(mission);			
						List<MissionVO> issuerList = missionDAO.getByIssuerMem(mission.getIssuer_Mem_No());
						System.out.println(mission_Pic);
						if(mission_Pic==null){
							Mission_ImagesVO mission_ImagesVO=mission_ImagesSvc.insertMissionImagesNoimage(issuerList.get(issuerList.size()-1).getMission_No(),mission.getIssuer_Mem_No());
						} else{
							Mission_ImagesVO mission_ImagesVO=mission_ImagesSvc.insertMissionImages(issuerList.get(issuerList.size()-1).getMission_No(),mission.getIssuer_Mem_No(),mission_Pic);
						}
						System.out.println("ok");
					}catch(Exception e){
						System.out.println("nok");
						System.out.println(mission_Pic);
						e.printStackTrace();
					}
				}	
		} else //���Ƚs���d�Ϥ��s��
		if (action.equals("getImage_NoByMission_No")){
			String mission_No = jsonObject.get("mission_No").getAsString();
			List<String> image_NoList = mission_ImagesDAO.getImageNoByMissionNo(mission_No);
			writeText(res,gson.toJson(image_NoList));
			
		} else //���Ƚs���d�Ϥ�
		if ("getIssuer_ImageByMission_No".equals(action)){
			OutputStream os = res.getOutputStream();
			int imageSize = jsonObject.get("imageSize").getAsInt();
			String mission_No = jsonObject.get("mission_No").getAsString();
			System.out.println(mission_No);
			byte[] issuer_Image = mission_ImagesDAO.getIssuerImageByMissionNo(mission_No);
			if (issuer_Image != null) {
				issuer_Image = ImageUtil.shrink(issuer_Image, imageSize);
				res.setContentType("image/png");
				res.setContentLength(issuer_Image.length);
			}
			try{
				os.write(issuer_Image);
			} catch (Exception e){
		
				System.out.println("no pic");
			}
		} else //�s�W���ȭԿ�H 
		if ("insert_case_candidate".equals(action)){
//�W�[���A
				try{
					String case_Candidate_No = jsonObject.get("mem_No").getAsString();
					String mission_No = jsonObject.get("mission_No").getAsString();
					Integer issuer_Inviting = jsonObject.get("issuer_Inviting").getAsInt();
					System.out.println("�s�W���ȭԿ�H"+case_Candidate_No +"\n����" + mission_No);
					case_CandidateSvc.insertCaseCandidate(case_Candidate_No, mission_No, issuer_Inviting);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
		} else //�R�����ȭԿ�H
			if ("delete_case_candidate".equals(action)){
				try{
					String case_Candidate_No = jsonObject.get("mem_No").getAsString();
					String mission_No = jsonObject.get("mission_No").getAsString();
					System.out.println("�R�����ȭԿ�H"+case_Candidate_No +"\n����" + mission_No);
					case_CandidateSvc.deleteCaseCandidate(case_Candidate_No, mission_No);
				} catch (Exception e) {
					e.printStackTrace();
				}
		} else //�R���Կ����
			if ("deleteCaseCandidateByMissionNo".equals(action)){
				try{
//					String case_Candidate_No = jsonObject.get("mem_No").getAsString();
					String mission_No = jsonObject.get("mission_No").getAsString();
					System.out.println("�R��mission_NO" + mission_No);
					case_CandidateSvc.deleteCaseCandidateByMissionNo(mission_No);
				} catch (Exception e) {
					e.printStackTrace();
				}		
		}else //�Կ�H������
		  if ("getMissionByCandidateMemNo1".equals(action)) {
			try{
				String candidate_Mem_No = jsonObject.get("mem_No").getAsString();
				List<String> missionList = case_CandidateDAO.getAllMissionNoByCandidateMemNo1(candidate_Mem_No);
				List<MissionVO> candidateMissionList = new ArrayList();
				for(String mission_No: missionList ){
					candidateMissionList.add(missionSvc.getOneMission(mission_No));
				}
				writeText(res,gson.toJson(candidateMissionList));
			}catch(Exception e){
				e.printStackTrace();
			}
		} else //�Կ�H������
			  if ("getMissionByCandidateMemNo2".equals(action)) {
					try{
						String candidate_Mem_No = jsonObject.get("mem_No").getAsString();
						System.out.println(candidate_Mem_No);
						List<String> missionList = case_CandidateDAO.getAllMissionNoByCandidateMemNo2(candidate_Mem_No);
						List<MissionVO> candidateMissionList = new ArrayList();
						for(String mission_No: missionList ){
							candidateMissionList.add(missionSvc.getOneMission(mission_No));
						}
						writeText(res,gson.toJson(candidateMissionList));
					}catch(Exception e){
						e.printStackTrace();
					}
		}else //�Կ�H�����Ƚs��
		if ("getAllMissionNoByCandidateMemNo".equals(action)) {
			try{
				String candidate_Mem_No = jsonObject.get("mem_No").getAsString();
				List<String> missionNoList = case_CandidateSvc.getAllMissionNoByCandidateMemNo(candidate_Mem_No);
				writeText(res,gson.toJson(missionNoList));
			}catch(Exception e){
				e.printStackTrace();
			}
		} else
		if ("getMissionByKeyword".equals(action)){
			String keyword = jsonObject.get("keyword").getAsString();
			String keyvalue = jsonObject.get("keyvalue").getAsString();
			List<MissionVO> missionList = missionSvc.getMissionByKeyword(keyword, keyvalue);
			writeText(res,gson.toJson(missionList));
		} else
		if ("addTakeCaseMem".equals(action)) {
			String mission_No = jsonObject.get("mission_No").getAsString();
			String take_Case_NO = jsonObject.get("takecase_NO").getAsString();
			Date mission_Start_Time = new Date(System.currentTimeMillis());
			Date mission_End_Time = new Date(System.currentTimeMillis()+60*60*24*1000*5);
			case_CandidateSvc.deleteCaseCandidateByMissionNo(mission_No);
			missionDAO.addTakeCaseMem(take_Case_NO, mission_No, mission_Start_Time, mission_End_Time);
			
		} else 
		if ("updateMissionState".equals(action)){
			Integer mission_State = jsonObject.get("mission_State").getAsInt();
			String mission_No = jsonObject.get("mission_No").getAsString();	
			missionDAO.updateMissionState(mission_State, mission_No);
			
		} else
		if ("addAccuseCase".equals(action)){
			String mission_No = jsonObject.get("mission_No").getAsString();
			String accuser_No = jsonObject.get("mem_No").getAsString();
			Date accuse_Date = new Date(System.currentTimeMillis());
			String accuse_Detail = jsonObject.get("accuse_Detail").getAsString();
			Integer accuse_State = 1;
//			case_CandidateSvc.deleteCaseCandidateByMissionNo(mission_No);
			accuseCaseDAO.addAccuseCase(mission_No, accuser_No, accuse_Date, accuse_Detail, accuse_State);
		} else
		if ("deleteAccuseCase".equals(action)){
			String accuser_No = jsonObject.get("accuser_No").getAsString();
			String mission_No = jsonObject.get("mission_No").getAsString();
			System.out.println( mission_No +" and "+accuser_No );
			accuseCaseDAO.deleteAccuseCase(mission_No,accuser_No);
		} else
		if ("findAccuseCaseByMissionNo".equals(action)){
			String mission_No = jsonObject.get("mission_No").getAsString();
			List<String> accusr_NoList =  accuseCaseDAO.findAccuseCaseByMissionNo(mission_No);
			writeText(res,gson.toJson(accusr_NoList));
		} else //�s�W��ĳ
		if ("addDisputeCase".equals(action)){
			String mission_No = jsonObject.get("mission_No").getAsString();
			String dispute_Mem_No = jsonObject.get("mem_No").getAsString();
			String dispute_Content = jsonObject.get("dispute_Content").getAsString();
			System.out.println(mission_No +"  "+dispute_Mem_No+"  "+dispute_Content);
			disputcaseDAO.insert(mission_No, dispute_Mem_No, dispute_Content);
			missionDAO.updateMissionState(8, mission_No);
			
			
		}else //�R����ĳ
		if ("deleteDisputeCase".equals(action)){
			String mission_No = jsonObject.get("mission_No").getAsString();
			String dispute_Mem_No = jsonObject.get("mem_No").getAsString();	
			System.out.println(mission_No +"  "+dispute_Mem_No);
			disputcaseDAO.delete(mission_No,dispute_Mem_No);
			if(disputcaseDAO.findByMission(mission_No)==null){
				missionDAO.updateMissionState(3, mission_No);
			}			
		}else //�d��ĳ�ץ�
		if ("findByMem".equals(action)){
			String dispute_Mem_No = jsonObject.get("mem_No").getAsString();
			List<DisputeCaseVO> disputeCaseList = disputcaseDAO.findByMem(dispute_Mem_No);
			writeText(res,gson.toJson(disputeCaseList));
		}else
		if ("findByMission".equals(action)){
			String mission_No = jsonObject.get("mission_No").getAsString();
			List<DisputeCaseVO> disputeCaseList = disputcaseDAO.findByMission(mission_No);
			writeText(res,gson.toJson(disputeCaseList));
		}

	}
	
	private void writeText(HttpServletResponse res, String outText)
			throws IOException {
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		System.out.println("outText: " + outText);
		out.print(outText);
	}
	
	
}

