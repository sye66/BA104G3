package com.emp.model;

import java.util.List;

public class EmpService {
	private EmpDAO_interface dao;

	public EmpService() {
		dao = new EmpDAO();
	}

	public EmpVO addEmp(String emp_Name, String emp_Pwd, String emp_Mail,
			String emp_Job, String emp_Phone, String emp_State) {

		EmpVO empVO = new EmpVO();

		empVO.setEmp_Name(emp_Name);
		empVO.setEmp_Pwd(emp_Pwd);
		empVO.setEmp_Mail(emp_Mail);
		empVO.setEmp_Job(emp_Job);
		empVO.setEmp_Phone(emp_Phone);
		empVO.setEmp_State(emp_State);
		dao.insert(empVO);

		return empVO;
		
	}

//	�w�d�� Struts 2 �Ϊ�
	public void addEmp(EmpVO empVO) {
		dao.insert(empVO);
	}
	
	public EmpVO updateEmp(String emp_No, String emp_Name,String emp_Mail,
			String emp_Job, String emp_Phone, String emp_State) {

		EmpVO empVO = new EmpVO();

		empVO.setEmp_No(emp_No);
		empVO.setEmp_Name(emp_Name);
//		empVO.setEmp_Pwd(emp_Pwd);
		empVO.setEmp_Mail(emp_Mail);
		empVO.setEmp_Job(emp_Job);
		empVO.setEmp_Phone(emp_Phone);
		empVO.setEmp_State(emp_State);
		dao.update(empVO);

		return empVO;
	}
	public EmpVO getOneEmp(String emp_No) {
		return dao.findByPrimaryKey(emp_No);
	}

	public List<EmpVO> getAll() {
		return dao.getAll();
	}
	
	public void deleteEmp(String emp_No) {
		dao.delete(emp_No);
	}
	
}
