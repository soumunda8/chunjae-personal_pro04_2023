package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Category;
import kr.ed.haebeop.persistence.CategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<Category> categoryList() throws Exception {
        return categoryMapper.categoryList();
    }

    @Override
    public List<Category> categoryKeywordList(String keyword) throws Exception {
        return categoryMapper.categoryKeywordList(keyword);
    }

    @Override
    public Category categoryGet(String cateNo) throws Exception {
        return categoryMapper.categoryGet(cateNo);
    }

    @Override
    public void categoryInsert(Category category) throws Exception {
        categoryMapper.categoryInsert(category);
    }

    @Override
    public void categoryUpdate(Category category) throws Exception {
        categoryMapper.categoryUpdate(category);
    }

    @Override
    public void categoryDelete(String cateNo) throws Exception {
        categoryMapper.categoryDelete(cateNo);
    }
}