package com.fh.shop.backend.biz.product;

import com.fh.shop.backend.api.ProductApiVo;
import com.fh.shop.backend.common.DataTableResult;
import com.fh.shop.backend.po.images.Images;
import com.fh.shop.backend.po.product.Product;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface IProductService {
/**
 * 增加
 */
public DataTableResult buildProductDataTable(HttpServletRequest req, Integer draw, Integer start, Integer length,
                                             Product product, Map<String, String[]> stringMap, Map fildeMapping);
	public void add(Product pro) ;

public List<Product> queryProductList(Product product);

public void deleteProduct(Integer id);

public void deleteAll(String ids);

public Product findProduct(Integer id);

public void update(Product product);

public Long findProductListCount(Product product);

    List<Product> findProductList(Product product);

    Long queryTotal(Integer id);

    List<Product> findProductListByBrand(Integer id);

    List<Images> queryImages(Integer id);

    List<ProductApiVo> queryProductApi();
}
