package com.comp.model;

public class CompVO implements java.io.Serializable{
	private String emp_No;
	private String auth_No;
	
	
	public String getEmp_No() {
		return emp_No;
	}
	public void setEmp_No(String emp_No) {
		this.emp_No = emp_No;
	}
	public String getAuth_No() {
		return auth_No;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((auth_No == null) ? 0 : auth_No.hashCode());
		result = prime * result + ((emp_No == null) ? 0 : emp_No.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CompVO other = (CompVO) obj;
		if (auth_No == null) {
			if (other.auth_No != null)
				return false;
		} else if (!auth_No.equals(other.auth_No))
			return false;
		if (emp_No == null) {
			if (other.emp_No != null)
				return false;
		} else if (!emp_No.equals(other.emp_No))
			return false;
		return true;
	}
	public void setAuth_No(String auth_No) {
		this.auth_No = auth_No;
	}
	
	
}
