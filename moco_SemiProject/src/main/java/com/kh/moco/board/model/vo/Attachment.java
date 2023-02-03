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
public class Attachment {
	private int attmNum;
	private String attmOriginName;
	private String  attmRename;
	private Date attmCreateDate;
	private String attmStatus;
	private int attmLevel;
	private int refBoardId;
}

