package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Product;
import kr.ed.haebeop.persistence.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;

    @Override
    public List<Product> productList() throws Exception {
        return productMapper.productList();
    }

    @Override
    public Product productGet(int proNo) throws Exception {
        return productMapper.productGet(proNo);
    }

    @Override
    public Product productInsert(Product product) throws Exception {
        productMapper.productInsert(product);
        return productMapper.productLast();
    }

    @Override
    public void productUpdate(Product product) throws Exception {
        productMapper.productUpdate(product);
    }

    @Override
    public void productDelete(int proNo) throws Exception {
        productMapper.productDelete(proNo);
    }
}