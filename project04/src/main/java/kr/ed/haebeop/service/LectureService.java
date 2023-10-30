package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Lecture;
import kr.ed.haebeop.domain.LectureVO;
import kr.ed.haebeop.util.Page;

import java.util.List;

public interface LectureService {

    public List<LectureVO> lectureList(Page page) throws Exception;
    public int lectureCount(Page page) throws Exception;
    public LectureVO lectureGet(int lno) throws Exception;
    public Lecture lectureInsert(Lecture lecture) throws Exception;
    public void lectureUpdate(Lecture lecture) throws Exception;

}