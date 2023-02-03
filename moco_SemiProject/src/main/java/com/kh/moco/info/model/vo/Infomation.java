package com.kh.moco.info.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString

public class Infomation {

	private int infoNum;
	private String infoClassName;
	private String infoAcademyName;
	private String infoPeriod;
	private String infoTime;
	private String infoManager;
	private String infoCategory;
	private String infoPhone;
	private String infoAddress;
	private float infoAddressLat;
	private float infoAddressLong;
	private String infoPrice;
	private String infoOnOff;
	private String infoDetail;
	private String infoAddInfomation;
	private String infoStatus;
	private Date infoCreateDate;
	private Date infoModifyDate;
	private String infoApprove;
	private String infoCount;
	private int memberNum; 
	
	
}
