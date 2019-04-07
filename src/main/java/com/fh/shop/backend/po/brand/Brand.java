package com.fh.shop.backend.po.brand;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fh.shop.backend.po.Page;

public class Brand extends Page implements Serializable{
	private static final long serialVersionUID = -3652528176476491626L;
	private Integer id;
	private String brandName;

	private Date entrtyTime;
	private Date updateTime;
	//条件查询时间区间
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date minEntrtyTime;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date maxEntrtyTime;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date minUpdateTime;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date maxUpdateTime;
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

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public Date getEntrtyTime() {
		return entrtyTime;
	}
	public void setEntrtyTime(Date entrtyTime) {
		this.entrtyTime = entrtyTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Date getMinEntrtyTime() {
		return minEntrtyTime;
	}
	public void setMinEntrtyTime(Date minEntrtyTime) {
		this.minEntrtyTime = minEntrtyTime;
	}
	public Date getMaxEntrtyTime() {
		return maxEntrtyTime;
	}
	public void setMaxEntrtyTime(Date maxEntrtyTime) {
		this.maxEntrtyTime = maxEntrtyTime;
	}
	public Date getMinUpdateTime() {
		return minUpdateTime;
	}
	public void setMinUpdateTime(Date minUpdateTime) {
		this.minUpdateTime = minUpdateTime;
	}
	public Date getMaxUpdateTime() {
		return maxUpdateTime;
	}
	public void setMaxUpdateTime(Date maxUpdateTime) {
		this.maxUpdateTime = maxUpdateTime;
	}

	
	
	
}
