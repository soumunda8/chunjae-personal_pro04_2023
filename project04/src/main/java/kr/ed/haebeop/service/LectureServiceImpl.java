package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Lecture;
import kr.ed.haebeop.domain.LectureVO;
import kr.ed.haebeop.persistence.LectureMapper;
import kr.ed.haebeop.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LectureServiceImpl implements LectureService {

    @Autowired
    private LectureMapper lectureMapper;

    @Override
    public List<LectureVO> lectureList(Page page) throws Exception {
        return lectureMapper.lectureList(page);
    }

    @Override
    public int lectureCount(Page page) throws Exception {
        return lectureMapper.lectureCount(page);
    }

    @Override
    public Lecture lectureGet(int lno) throws Exception {
        return lectureMapper.lectureGet(lno);
    }

    @Override
    public Lecture lectureInsert(Lecture lecture) throws Exception {
        lectureMapper.lectureInsert(lecture);
        Lecture lec = lectureMapper.lectureListLast();
        return lec;
    }
}