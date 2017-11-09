package com.pro.shoppingcart;


public class ProCartVO implements java.io.Serializable{
	private String proCar_No;
	private String proCar_Name;
	private String proCar_Info;
	private Double proCar_Price;
	private Integer proCar_Quantity;
	
	public ProCartVO(){
		proCar_No = "";
		proCar_Name = "";
		proCar_Info = "";
		proCar_Price = 0.0;
		proCar_Quantity = 0;
	}

	public String getProCar_No() {
		return proCar_No;
	}


	public void setProCar_No(String proCar_No) {
		this.proCar_No = proCar_No;
	}

	public String getProCar_Name() {
		return proCar_Name;
	}

	public void setProCar_Name(String proCar_Name) {
		this.proCar_Name = proCar_Name;
	}

	public String getProCar_Info() {
		return proCar_Info;
	}

	public void setProCar_Info(String proCar_Info) {
		this.proCar_Info = proCar_Info;
	}

	public Double getProCar_Price() {
		return proCar_Price;
	}

	public void setProCar_Price(Double proCar_Price) {
		this.proCar_Price = proCar_Price;
	}

	public Integer getProCar_Quantity() {
		return proCar_Quantity;
	}

	public void setProCar_Quantity(Integer proCar_Quantity) {
		this.proCar_Quantity = proCar_Quantity;
	}


	@Override
	public String toString() {
		return "ProCartVO [proCar_No=" + proCar_No + ", proCar_Name=" + proCar_Name + ", proCar_Info=" + proCar_Info
				+ ", proCar_Price=" + proCar_Price + ", proCar_Quantity=" + proCar_Quantity + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((proCar_Name == null) ? 0 : proCar_Name.hashCode());
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
		ProCartVO other = (ProCartVO) obj;
		if (proCar_Name == null) {
			if (other.proCar_Name != null)
				return false;
		} else if (!proCar_Name.equals(other.proCar_Name))
			return false;
		return true;
	}

	
	
}
