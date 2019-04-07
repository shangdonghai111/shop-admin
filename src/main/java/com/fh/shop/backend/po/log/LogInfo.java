package com.fh.shop.backend.po.log;

import com.fh.shop.backend.po.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

public class LogInfo extends Page {
	private String id;
	private String userName;
	private String operate;
	private Date operateTime;
	private String ipAdress;
	private long executeTime;
	private int status;
	private String content;

	//条件查询
	private long minexecuteTime;
	private long maxexecuteTime;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date minOperateTime;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date maxOperateTime;
	//排序
	private String sort;
	private String sortField;

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getSortField() {
		return sortField;
	}

	public void setSortField(String sortField) {
		this.sortField = sortField;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getOperate() {
		return operate;
	}

	public void setOperate(String operate) {
		this.operate = operate;
	}

	public Date getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	public String getIpAdress() {
		return ipAdress;
	}

	public void setIpAdress(String ipAdress) {
		this.ipAdress = ipAdress;
	}

	public long getExecuteTime() {
		return executeTime;
	}

	public void setExecuteTime(long executeTime) {
		this.executeTime = executeTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public long getMinexecuteTime() {
		return minexecuteTime;
	}

	public void setMinexecuteTime(long minexecuteTime) {
		this.minexecuteTime = minexecuteTime;
	}

	public long getMaxexecuteTime() {
		return maxexecuteTime;
	}

	public void setMaxexecuteTime(long maxexecuteTime) {
		this.maxexecuteTime = maxexecuteTime;
	}

	public Date getMinOperateTime() {
		return minOperateTime;
	}

	public void setMinOperateTime(Date minOperateTime) {
		this.minOperateTime = minOperateTime;
	}

	public Date getMaxOperateTime() {
		return maxOperateTime;
	}

	public void setMaxOperateTime(Date maxOperateTime) {
		this.maxOperateTime = maxOperateTime;
	}
}
