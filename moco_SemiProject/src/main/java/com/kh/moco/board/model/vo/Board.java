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
public class Board {
	private int boardNum;
	private String boardTitle;
	private String boardContent;
	private int boardView;
	private Date boardCreateDate;
	private Date boardModifyDate;
	private String boardAnonymity;
	private String boardCategory;
	private String boardStatus;
	private String boardReport;
	private int boardType;
	private int memberNum;
	private String nickName;
	

}
