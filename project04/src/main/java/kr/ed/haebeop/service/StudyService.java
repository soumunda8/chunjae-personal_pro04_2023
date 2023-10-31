package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Study;

public interface StudyService {

    public void studyTotalTimeUpdate(Study study) throws Exception;
    public void studyYnUpdate(Study study) throws Exception;
    public void studyCanYnUpdate(Study study) throws Exception;

}