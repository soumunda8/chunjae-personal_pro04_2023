package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Study;
import kr.ed.haebeop.persistence.StudyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudyServiceImpl implements StudyService {

    @Autowired
    private StudyMapper studyMapper;

    @Override
    public void studyTotalTimeUpdate(Study study) throws Exception {
        studyMapper.studyTotalTimeUpdate(study);
    }

    @Override
    public void studyYnUpdate(Study study) throws Exception {
        studyMapper.studyYnUpdate(study);
    }

    @Override
    public void studyCanYnUpdate(Study study) throws Exception {
        studyMapper.studyCanYnUpdate(study);
    }
}
