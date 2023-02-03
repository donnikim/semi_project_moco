package com.kh.moco.info.model.service;

import java.util.ArrayList;

import com.kh.moco.attachment.model.vo.Attachment;
import com.kh.moco.common.model.vo.PageInfo;
import com.kh.moco.info.model.vo.Infomation;


public interface InfoService {

	int insertInfo(Infomation info);

	int insertAttm(ArrayList<Attachment> list);

	ArrayList<Infomation> selectInfoList(int i, PageInfo pi);


	ArrayList<Attachment> selectAttmList(int i);

	Infomation selectInfo(int infoId, boolean yn);

	ArrayList<Attachment> selectAttmListDetail(int infoId);

	Infomation selectInfoDetail(int infoId, boolean yn);

	int getListCount();

	ArrayList<Infomation> selectCount(int i, PageInfo pi);

	ArrayList<Attachment> selectCountAttm(int i);

	int deleteInfo(int infoNum);

	int deleteAttmBefore(int infoId);


	int updateAttm(ArrayList<Attachment> list);

	int updateInfo(Infomation info);

}
