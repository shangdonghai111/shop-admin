package com.fh.shop.backend.mapper.product;

import com.fh.shop.backend.po.images.Images;
import com.fh.shop.backend.po.product.Product;

import java.util.List;

public interface productDao {
	
	public void add(Product product);

	public List<Product> queryProductList(Product product);

	public void deleteProduct(Integer id);

	public void deleteAll(List<Integer> list);

	public Product findProduct(Integer id);

	public void update(Product product);

	public Long findProductListCount(Product product);


    List<Product> findProductList(Product product);

    Long queryTotal(Integer id);

	List<Product> findProductListByBrand(Integer id);

    List<Images> queryImages(Integer id);

    List<Product> queryProductApi();
}
