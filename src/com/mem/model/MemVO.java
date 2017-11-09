package com.mem.model;

import java.sql.Date;

public class MemVO {
	private String mem_no;
	private String mem_pw;
	private String mem_name;
	private String mem_id;
	private Date mem_bday;
	private String mem_tel;
	private String mem_pho;
	private Integer mem_gend;
	private String mem_email;
	private byte[] mem_pic;
	private String mem_intro;
	private Integer mem_code;
	private Integer mem_state;
	private Double mem_gps_lat;
	private Double mem_gps_lng;
	private String mem_ip;
	private Date mem_date;
	private Integer mission_count;
	private String mem_address;
	private Integer mem_search;
	private Integer mem_point;
	
	
	public MemVO() {
		super();
	}
	
	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public Date getMem_bday() {
		return mem_bday;
	}

	public void setMem_bday(Date mem_bday) {
		this.mem_bday = mem_bday;
	}

	public String getMem_tel() {
		return mem_tel;
	}

	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}

	public String getMem_pho() {
		return mem_pho;
	}

	public void setMem_pho(String mem_pho) {
		this.mem_pho = mem_pho;
	}

	public Integer getMem_gend() {
		return mem_gend;
	}

	public void setMem_gend(Integer mem_gend) {
		this.mem_gend = mem_gend;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public byte[] getMem_pic() {
		return mem_pic;
	}

	public void setMem_pic(byte[] mem_pic) {
		this.mem_pic = mem_pic;
	}

	public String getMem_intro() {
		return mem_intro;
	}

	public void setMem_intro(String mem_intro) {
		this.mem_intro = mem_intro;
	}

	public Integer getMem_code() {
		return mem_code;
	}

	public void setMem_code(Integer mem_code) {
		this.mem_code = mem_code;
	}

	public Integer getMem_state() {
		return mem_state;
	}

	public void setMem_state(Integer mem_state) {
		this.mem_state = mem_state;
	}

	public Double getMem_gps_lat() {
		return mem_gps_lat;
	}

	public void setMem_gps_lat(Double mem_gps_lat) {
		this.mem_gps_lat = mem_gps_lat;
	}

	public Double getMem_gps_lng() {
		return mem_gps_lng;
	}

	public void setMem_gps_lng(Double mem_gps_lng) {
		this.mem_gps_lng = mem_gps_lng;
	}

	public String getMem_ip() {
		return mem_ip;
	}

	public void setMem_ip(String mem_ip) {
		this.mem_ip = mem_ip;
	}

	public Date getMem_date() {
		return mem_date;
	}

	public void setMem_date(Date mem_date) {
		this.mem_date = mem_date;
	}

	public Integer getMission_count() {
		return mission_count;
	}

	public void setMission_count(Integer mission_count) {
		this.mission_count = mission_count;
	}

	public String getMem_address() {
		return mem_address;
	}

	public void setMem_address(String mem_address) {
		this.mem_address = mem_address;
	}

	public Integer getMem_search() {
		return mem_search;
	}

	public void setMem_search(Integer mem_search) {
		this.mem_search = mem_search;
	}

	public Integer getMem_point() {
		return mem_point;
	}

	public void setMem_point(Integer mem_point) {
		this.mem_point = mem_point;
	}

	@Override
	public String toString() {
		return "MemVO [mem_date=" + mem_date + "]";
	}
	
	
}
