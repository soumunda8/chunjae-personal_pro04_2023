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
    public List<FileDTO> fileListByPar(int par) throws Exception {
        return filesMapper.fileListByPar(par);
    }

    @Override
    public FileDTO fileListByFno(int fno) throws Exception {
        return filesMapper.fileListByFno(fno);
    }

    @Override
    public void filesInsert(FileDTO fileDTO) throws Exception {
        filesMapper.filesInsert(fileDTO);
    }
}