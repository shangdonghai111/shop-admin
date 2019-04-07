package com.fh.shop.backend.biz.brand;

import com.fh.shop.backend.api.BrandApiVo;
import com.fh.shop.backend.po.brand.Brand;

import java.util.List;

public interface BrandService {

	void add(Brand brand);

	List<Brand> query(Brand brand);

	void deleteOne(Integer id);

	Brand findOne(Integer id);

	void update(Brand brand);

	void deleteAll(String ids);

	Long queryCount(Brand brand);
	
	List<Brand> queryList();


    List<BrandApiVo> queryBrandApi();
}
