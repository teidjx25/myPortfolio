package com.exam.vo;

import java.sql.Timestamp;

//VO 대신에 Map 컬렉션을 사용해도 됨

public class MemberVo {
	
//변수들을 관리하는 클래스
	
	private String  id;
	private String password;
	private String name;
	private int age;
	private String email;
	private Timestamp regDate;
	private String address;
	private String tel;
	
	private int gm_lev;		//관리 레벨
	private int gm_area;	//관리 지역번호
	public String getId() {
		return id;
	}
	public String getPassword() {
		return password;
	}
	public String getName() {
		return name;
	}
	public int getAge() {
		return age;
	}
	public String getEmail() {
		return email;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public String getAddress() {
		return address;
	}
	public String getTel() {
		return tel;
	}
	public int getGm_lev() {
		return gm_lev;
	}
	public int getGm_area() {
		return gm_area;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public void setGm_lev(int gm_lev) {
		this.gm_lev = gm_lev;
	}
	public void setGm_area(int gm_area) {
		this.gm_area = gm_area;
	}
	@Override
	public String toString() {
		return "MemberVo [id=" + id + ", password=" + password + ", name=" + name + ", age=" + age + ", email=" + email
				+ ", regDate=" + regDate + ", address=" + address + ", tel=" + tel + ", gm_lev=" + gm_lev + ", gm_area="
				+ gm_area + "]";
	}
	
	


}