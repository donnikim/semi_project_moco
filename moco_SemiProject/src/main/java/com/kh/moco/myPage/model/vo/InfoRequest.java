package com.kh.moco.myPage.model.vo;

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
public class InfoRequest {
	private int infoNum;
	private String infoAcademyName;
	private String infoClassName;
	private Date infoCreateDate;
	private String infoApprove;
	private String memberName;
}
