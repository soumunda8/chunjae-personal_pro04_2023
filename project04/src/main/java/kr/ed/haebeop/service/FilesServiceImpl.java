package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.FileDTO;
import kr.ed.haebeop.persistence.FilesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FilesServiceImpl implements FilesService{

    @Autowired
    private FilesMapper filesMapper;

    @Override
    public List<FileDTO> fileListByPar(FileDTO fileDTO) throws Exception {
        return filesMapper.fileListByPar(fileDTO);
    }

    @Override
    public FileDTO fileByFno(int fno) throws Exception {
        return filesMapper.fileByFno(fno);
    }

    @Override
    public FileDTO fileByParForThumbnail(int par) throws Exception {
        return filesMapper.fileByParForThumbnail(par);
    }

    @Override
    public FileDTO fileByParForGrade(int par) throws Exception {
        return filesMapper.fileByParForGrade(par);
    }

    @Override
    public void filesInsert(FileDTO fileDTO) throws Exception {
        filesMapper.filesInsert(fileDTO);
    }

    @Override
    public void filesUpdateForTeacher(FileDTO fileDTO) throws Exception {
        filesMapper.filesUpdateForTeacher(fileDTO);
    }

    @Override
    public void filesDelete(int fno) throws Exception {
        filesMapper.filesDelete(fno);
    }

    @Override
    public void filesDeleteAll(int par) throws Exception {
        filesMapper.filesDeleteAll(par);
    }

}