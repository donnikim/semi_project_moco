package com.kh.moco.board.model.vo;

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
public class Reply {
	private int replyNum;
	private String replyContent;
	private Date replyCreateDate;
	private Date replyModifyDate;
	private String replyStatus;
	private String replyAnonymity;
	private int memberNum;
	private int boardNum;
	private String boardCategory;
	private String nickName; 
}
