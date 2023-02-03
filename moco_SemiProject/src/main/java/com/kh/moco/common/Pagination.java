package com.kh.moco.common;

import com.kh.moco.common.model.vo.PageInfo;

public class Pagination {
	
	public static PageInfo getPageInfo(int currentPage, int listCount,int boardLimit) {
		int pageLimit=10;
		int maxPage;
		int startPage;
		int endPage;

		
		maxPage=(int)Math.ceil((double)listCount/boardLimit);
		startPage=(currentPage-1)/pageLimit*pageLimit+1;
		endPage=startPage+pageLimit-1;
		if(maxPage<endPage) {
			endPage=maxPage;
		}
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit,maxPage,startPage,endPage,boardLimit);
		return pi;
	}
}
