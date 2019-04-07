package com.fh.shop.backend.po.product;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fh.shop.backend.po.Page;
import com.fh.shop.backend.po.brand.Brand;

public class Product extends Page implements Serializable{
	private static final long serialVersionUID = -7892237708232023588L;
	//品牌对象
	private Brand brand=new Brand();
	
	private String ids;
	private Integer id;
	private String productName;
	private Float productPrice;
	private Date entrtyTime;
	private Date updateTime;
	private String productImage;
	private String pathUrl;


	//条件查询
	private Float minPrice;
	private Float maxPrice;
	@DateTimeFormat(pattern="yyyy-MM-dd HH")
	private Date minEntrtyTime;
	@DateTimeFormat(pattern="yyyy-MM-dd HH")
	private Date maxEntrtyTime;
	@DateTimeFormat(pattern="yyyy-MM-dd HH")
	private Date minUpdateTime;
	@DateTimeFormat(pattern="yyyy-MM-dd HH")
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

	private Integer status;

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Float getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(Float productPrice) {
		this.productPrice = productPrice;
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

	public Float getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(Float minPrice) {
		this.minPrice = minPrice;
	}

	public Float getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(Float maxPrice) {
		this.maxPrice = maxPrice;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getPathUrl() {
		return pathUrl;
	}

	public void setPathUrl(String pathUrl) {
		this.pathUrl = pathUrl;
	}
}
