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
public class MyReply {
	private int replyNum;
	private String boardCategory;
	private String replyContent;
	private Date replyCreateDate;
	private int memberNum;
	private int boardNum;

}
