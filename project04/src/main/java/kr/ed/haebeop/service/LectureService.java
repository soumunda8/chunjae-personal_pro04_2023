package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.LectureVO;
import kr.ed.haebeop.util.Page;

import java.util.List;

public interface LectureService {

    public List<LectureVO> lectureList(Page page) throws Exception;
    public int lectureCount(Page page) throws Exception;

}