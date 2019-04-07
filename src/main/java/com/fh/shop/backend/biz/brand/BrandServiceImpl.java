package com.fh.shop.backend.biz.brand;

import com.fh.shop.backend.api.BrandApiVo;
import com.fh.shop.backend.mapper.brand.BrandDao;
import com.fh.shop.backend.po.brand.Brand;
import com.fh.shop.backend.util.RedisUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class BrandServiceImpl implements BrandService{
	@Resource
	private BrandDao brandDao;
	@Override
	public void add(Brand brand) {
		brand.setEntrtyTime(new Date());
		brand.setUpdateTime(new Date());
		brandDao.add(brand);
		RedisUtil.del("brandList");
	}
	@Override
	public List<Brand> query(Brand brand) {
		List<Brand> query = brandDao.query(brand);
		return query;
	}
	@Override
	public void deleteOne(Integer id) {
		brandDao.deleteOne(id);
	}
	@Override
	public Brand findOne(Integer id) {
		Brand findOne = brandDao.findOne(id);
		return findOne;
	}
	@Override
	public void update(Brand brand) {
		brand.setUpdateTime(new Date());
		brandDao.update(brand);
		RedisUtil.del("brandList");
	}
	@Override
	public void deleteAll(String ids) {
		if(StringUtils.isNotEmpty(ids)){
		List<Integer> list=new ArrayList<>();
		String[] split = ids.split(",");
		for (String id : split) {
			list.add(Integer.parseInt(id));
		}
		brandDao.deleteAll(list);
		
	}
	}
	@Override
	public Long queryCount(Brand brand) {
		Long queryCount = brandDao.queryCount(brand);
		return queryCount;
	}
	@Override
	public List<Brand> queryList() {
		String brandList = RedisUtil.get("brandList");
		Gson gson = new Gson();
		if (StringUtils.isEmpty(brandList)){
			List<Brand> queryList = brandDao.queryList();
			String brandListJson = gson.toJson(queryList);
			RedisUtil.set("brandList",brandListJson);
			return queryList;
		}else {
			Type type =  new TypeToken<List<Brand>>() {
			}.getType();
			List<Brand>list=gson.fromJson(brandList,type);
			return list;
		}


	}

    @Override
    public List<BrandApiVo> queryBrandApi() {
		List<Brand> queryBrandApi = brandDao.queryBrandApi();
		List<BrandApiVo> list=new ArrayList<>();
		for (int i = 0; i < queryBrandApi.size(); i++) {
			BrandApiVo brandApiVo = new BrandApiVo();
			brandApiVo.setId(queryBrandApi.get(i).getId());
			brandApiVo.setBrandName(queryBrandApi.get(i).getBrandName());
			list.add(brandApiVo);
		}
		return list;
    }


}
