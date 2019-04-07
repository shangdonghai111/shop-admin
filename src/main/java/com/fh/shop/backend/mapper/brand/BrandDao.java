package com.fh.shop.backend.mapper.brand;

import com.fh.shop.backend.po.brand.Brand;

import java.util.List;

public interface BrandDao {

	void add(Brand brand);

	List<Brand> query(Brand brand);

	void deleteOne(Integer id);

	Brand findOne(Integer id);

	void update(Brand brand);

	void deleteAll(List<Integer> list);

	Long queryCount(Brand brand);

	List<Brand> queryList();


    List<Brand> queryBrandApi();
}
