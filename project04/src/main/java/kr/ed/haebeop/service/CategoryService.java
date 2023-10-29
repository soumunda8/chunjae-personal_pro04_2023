package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Category;

import java.util.List;

public interface CategoryService {

    public List<Category> categoryList() throws Exception;
    public List<Category> categoryKeywordList(String keyword) throws Exception;
    public Category categoryGet(String cateNo) throws Exception;
    public void categoryInsert(Category category) throws Exception;
    public void categoryUpdate(Category category) throws Exception;
    public void categoryDelete(String cateNo) throws Exception;

}