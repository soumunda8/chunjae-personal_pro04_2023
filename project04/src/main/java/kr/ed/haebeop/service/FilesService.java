package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.FileDTO;

import java.util.List;

public interface FilesService {

    public List<FileDTO> fileListByPar(FileDTO fileDTO) throws Exception;
    public FileDTO fileByFno(int fno) throws Exception;
    public FileDTO fileByParForGrade(int par) throws Exception;
    public FileDTO fileByParForThumbnail(int par) throws Exception;
    public void filesInsert(FileDTO fileDTO) throws Exception;
    public void filesUpdateForTeacher(FileDTO fileDTO) throws Exception;
    public void filesDelete(int fno) throws Exception;
    public void filesDeleteAll(int par) throws Exception;

}