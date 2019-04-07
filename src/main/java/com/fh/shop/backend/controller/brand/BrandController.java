package com.fh.shop.backend.controller.brand;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.shop.backend.biz.brand.BrandService;
import com.fh.shop.backend.common.ServerResponse;
import com.fh.shop.backend.controller.BaseController;
import com.fh.shop.backend.po.brand.Brand;
import com.fh.shop.backend.po.product.Product;

import net.sf.json.JSONObject;
	
@Controller
@RequestMapping("brand")
public class BrandController extends BaseController{
	//声明日志
	private static final Logger LOG=LoggerFactory.getLogger(BrandController.class);
	@Resource
	private BrandService brandService;
	/**
	 * <pre>toAdd(跳转到增加页面)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2018年12月27日 下午4:53:05    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2018年12月27日 下午4:53:05    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("toAdd")
	public String toAdd(){
		
		return "/brand/addBrand";
	}
	/**
	 * <pre>add(增加的方法)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2018年12月27日 下午4:54:09    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2018年12月27日 下午4:54:09    
	 * 修改备注： 
	 * @param brand
	 * @return</pre>
	 */
	@RequestMapping("add")
	public String add(Brand brand){
		brandService.add(brand);
		return "redirect:toqueryBrandList.jhtml";
	}
	
	@RequestMapping("queryBrandList")
	public String queryBrandList(){
		List<Brand> queryList = brandService.queryList();
		return null;
	}
	/**
	 * <pre>queryPage(分页查询+条件查询)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2018年12月27日 下午6:39:01    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2018年12月27日 下午6:39:01    
	 * 修改备注： 
	 * @param map
	 * @param brand
	 * @return</pre>
	 */
	@RequestMapping("query")
	@ResponseBody
	public Map queryPage(HttpServletRequest req, ModelMap map, Brand brand, Integer draw, Integer start, Integer length){
		String order = req.getParameter("order[0][column]");//排序的列号
		String orderDir = req.getParameter("order[0][dir]");//排序的顺序asc or desc
		String beanName = req.getParameter("columns[" + order + "][data]");//排序的列。注意，我认为页面上的列的名字要和表中列的名字一致，否则，会导致SQL拼接错误

		//给开始条数和每页条数赋值
		brand.setStartPos(start);
		brand.setPageSize(length);

		brand.setSort(orderDir);
		brand.setSortField(beanName);
		//获取总条数
		Long count=brandService.queryCount(brand);
		//给总条数赋值
		brand.setTotalCount(count);
		//获取分页列表
		List<Brand> list=brandService.query(brand);
		HashMap hashMap = new HashMap();
		hashMap.put("draw",draw);
		hashMap.put("recordsTotal",count);
		hashMap.put("recordsFiltered",count);
		hashMap.put("data",list);
		return hashMap;
	}
	/**
	* @Description:    跳转值分页查询页面
	* @Author:         ShangDongHai q540662261@126.com
	* @CreateDate:     2019/2/28 19:16
	* @UpdateUser:     Shangdonghai
	* @UpdateDate:     2019/2/28 19:16
	* @UpdateRemark:   修改内容
	* @Version:        1.0
	*/
	@RequestMapping("toqueryBrandList")
	public String toqueryBrandList(){
		return "brand/brandList";
	}
	/**
	 * <pre>findOne(跳转至修改页面)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月16日 下午9:41:27    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月16日 下午9:41:27    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("findOne")
	public ModelAndView findOne(Integer id){
		ModelAndView modelAndView = new ModelAndView("/brand/update");
			Brand brand=brandService.findOne(id);
			modelAndView.addObject("brand", brand);
		
		return modelAndView;
	}
	
	/**
	 * <pre>update(修改)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2018年12月27日 下午7:17:35    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2018年12月27日 下午7:17:35    
	 * 修改备注： 
	 * @param brand
	 * @return</pre>
	 */
	@RequestMapping("update")
	public String update(Brand brand){
			brandService.update(brand);
		return "redirect:toqueryBrandList.jhtml";
	}
	/**
	 * <pre>deleteAll(批量删除)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月6日 上午10:55:19    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月6日 上午10:55:19    
	 * 修改备注： 
	 * @param ids
	 * @param response</pre>
	 */
	@RequestMapping("deleteAll")
	@ResponseBody
	public ServerResponse deleteAll(String ids,HttpServletResponse response){
			brandService.deleteAll(ids);
		return ServerResponse.success();
	
		
	}
	/**
	 * <pre>deleteOne(单个删除)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月11日 下午7:58:23    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月11日 下午7:58:23    
	 * 修改备注： 
	 * @param id
	 * @return</pre>
	 */
	@RequestMapping("deleteOne")
	@ResponseBody
	public ServerResponse deleteOne(Integer id){
			brandService.deleteOne(id);
		return ServerResponse.success();
	}
	/**
	 * <pre>updateBland(在一个页面的修改方法)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月6日 上午10:56:16    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月6日 上午10:56:16    
	 * 修改备注： 
	 * @param brand
	 * @param response</pre>
	 */
	@RequestMapping("updateBland")
	@ResponseBody
	public ServerResponse updateBland(Brand brand,HttpServletResponse response){
			brandService.update(brand);
		return ServerResponse.success();
		
	}
	/**
	 * <pre>queryBrand(查询所有品牌)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月9日 下午10:38:04    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月9日 下午10:38:04    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("queryBrand")
	@ResponseBody 
	public ServerResponse queryBrand(){
		List<Brand> queryList = brandService.queryList();
		return ServerResponse.success(queryList);
	}
}
