package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.FileDTO;

import java.util.List;

public interface FilesService {

    public List<FileDTO> fileListByPar(int par) throws Exception;
    public FileDTO fileListByFno(int fno) throws Exception;
    public void filesInsert(FileDTO fileDTO) throws Exception;

}