package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Product;

import java.util.List;

public interface ProductService {

    public List<Product> productList() throws Exception;
    public Product productGet(int proNo) throws Exception;
    public Product productInsert(Product product) throws Exception;
    public void productUpdate(Product product) throws Exception;
    public void productDelete(int proNo) throws Exception;

}