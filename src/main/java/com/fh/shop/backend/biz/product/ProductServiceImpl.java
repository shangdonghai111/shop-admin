package com.fh.shop.backend.biz.product;

import com.fh.shop.backend.api.ProductApiVo;
import com.fh.shop.backend.biz.BaseService;
import com.fh.shop.backend.biz.brand.BrandService;
import com.fh.shop.backend.common.DataTableResult;
import com.fh.shop.backend.gloable.Gloable;
import com.fh.shop.backend.mapper.product.productDao;
import com.fh.shop.backend.po.images.Images;
import com.fh.shop.backend.po.product.Product;
import com.fh.shop.backend.vo.ProductVo;
import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

//<bean id="productServiceImpl" class="com.fh.shop.backend.biz.product.ProductServiceImpl"></bean>
@Service
public class ProductServiceImpl extends BaseService implements IProductService{
	@Resource
	private productDao productDao;//引入dao层
	@Autowired
	private BrandService brandService;

    @Override
    public DataTableResult buildProductDataTable(HttpServletRequest req, Integer draw, Integer start, Integer length, Product product, Map<String, String[]> stringMap, Map fildeMapping) {
		//构建排序信息
    	buildOrder(product, stringMap, fildeMapping);
		String order = req.getParameter("order[0][column]");//排序的列号
		String orderDir = req.getParameter("order[0][dir]");//排序的顺序asc or desc
		String beanName = req.getParameter(getColumnData(order));//排序的列。注意，我认为页面上的列的名字要和表中列的名字一致，否则，会导致SQL拼接错误
		//给开始条数和每页条数赋值
		product.setStartPos(start);
		product.setPageSize(length);
		//当实体类属性和数据库不一样需要处理,并把处理过的放进属性中传到sql语句中进行排序
		buildBeanName(product, orderDir, beanName);

		// 获取总条数
		Long totalCount = findProductListCount(product);
		// 获取分页列表
		List<Product> list = queryProductList(product);
		//po转vo
		List<ProductVo> productVoList=wrapperProductVo(list);
		//组装结果
		return DataTableResult.build(draw, totalCount, totalCount, list);
    }

	private List<ProductVo> wrapperProductVo(List<Product> list) {
		List<ProductVo>productVoList=new ArrayList<>();
		for (Product productInfo : list) {
			ProductVo productVo = new ProductVo();
			productVo.setId(productInfo.getId());
			productVo.setProductName(productInfo.getProductName());
			productVo.setProductPrice(productInfo.getProductPrice());
			productVo.setEntrtyTime(productInfo.getEntrtyTime());
			productVo.setUpdateTime(productInfo.getUpdateTime());
			productVo.setPathUrl(productInfo.getPathUrl());
			productVo.setBrandName(productInfo.getBrand().getBrandName());
			productVoList.add(productVo);
		}

		return productVoList;
	}

	private void buildBeanName(Product product, String orderDir, String beanName) {
		if (beanName.equals("productPrice")) {
			beanName = "price";
		}
		if (beanName.equals("entrtyTime")) {
			beanName = "entrtyDate";
		}
		if (beanName.equals("updateTime")) {
			beanName = "updateDate";
		}
		product.setSort(orderDir);
		product.setSortField(beanName);
	}

	private void buildOrder(Product product, Map<String, String[]> stringMap, Map fildeMapping) {
		Gson gson = new Gson();
		fildeMapping = gson.fromJson(Gloable.ORDER_MAPPING, Map.class);
	/*	fildeMapping.put("productPrice","price");
		fildeMapping.put("entrtyTime","entrtyDate");
		fildeMapping.put("updateTime","updateDate");*/
		//排序的字段
		String orderFiled="";
		if (stringMap.get(Gloable.ORDER_COLUMN)!=null){
			//排序的列
			String orderColumn = stringMap.get(Gloable.ORDER_COLUMN)[0];
			//排序的字段
			String orderFileds = stringMap.get(getColumnData(orderColumn))[0];

			String orderInfo = (String) fildeMapping.get("orderFileds");
			orderFiled = StringUtils.isEmpty(orderInfo) ? orderFileds : orderInfo;
		}
		//排序的方向
		String orderFangxiang="";
		if (stringMap.get(Gloable.ORDER_DIR)!=null){
			orderFangxiang = stringMap.get(Gloable.ORDER_DIR)[0];
		}
		//把字段的排序的方向通过对象的属性传到sql语句中
		product.setSortField(orderFiled);
		product.setSort(orderFangxiang);
	}



	@Override
	public void add(Product product) {
		Date now = new Date();
		product.setEntrtyTime(now);
		product.setUpdateTime(now);
		productDao.add(product);

	}
	@Override
	public List<Product> queryProductList(Product product) {
		List<Product> list=productDao.queryProductList(product);
		return list;
	}
	@Override
	public void deleteProduct(Integer id) {
		productDao.deleteProduct(id);
	}
	@Override
	public void deleteAll(String ids) {
		if(StringUtils.isNotEmpty(ids)){
	List<Integer> list=new ArrayList<>();
		String[] split = ids.split(",");
		for (String id : split) {
			list.add(Integer.parseInt(id));
			
		}productDao.deleteAll(list);
	}
		}
	@Override
	public Product findProduct(Integer id) {
		Product findProduct = productDao.findProduct(id);
		return findProduct;
	}
	@Override
	public void update(Product product) {
		product.setUpdateTime(new Date());
		productDao.update(product);
		
	}
	@Override
	public Long findProductListCount(Product product) {
		Long count=productDao.findProductListCount(product);
		return count;
		
		
	}

	@Override
	public List<Product> findProductList(Product product) {
		List<Product> productList = productDao.findProductList(product);
		return productList;
	}

	@Override
	public Long queryTotal(Integer id) {
		return productDao.queryTotal(id);
	}

	@Override
	public List<Product> findProductListByBrand(Integer id) {
		return productDao.findProductListByBrand(id);
	}

	@Override
	public List<Images> queryImages(Integer id) {
		return productDao.queryImages(id);
	}

    @Override
    public List<ProductApiVo> queryProductApi() {
		List<Product> productList = productDao.queryProductApi();
		List<ProductApiVo>productApiVoList=new ArrayList<>();
		for (int i = 0; i < productList.size(); i++) {
			ProductApiVo productApiVo = new ProductApiVo();
			productApiVo.setId(productList.get(i).getId());
			productApiVo.setDeptName(productList.get(i).getProductName());
			productApiVo.setPrice(productList.get(i).getProductPrice());
			productApiVo.setProductImage(productList.get(i).getProductImage());
			productApiVoList.add(productApiVo);
		}
		return productApiVoList;
    }


}
