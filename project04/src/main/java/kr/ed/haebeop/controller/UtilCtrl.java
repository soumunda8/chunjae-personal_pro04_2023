package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.BoardMgn;
import kr.ed.haebeop.domain.FileDTO;
import kr.ed.haebeop.service.BoardMgnService;
import kr.ed.haebeop.service.FilesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.List;

@Controller
@RequestMapping("/util/")
public class UtilCtrl {

    @Autowired
    private FilesService filesService;

    @Autowired
    private BoardMgnService boardMgnService;

    @GetMapping("fileDownload.do")
    public String fileDownload(@RequestParam int no, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String urlPath = request.getHeader("referer");

        FileDTO files = filesService.fileByFno(no);

        String saveFolder = files.getSaveFolder();
        String originalFile = files.getOriginNm();
        String saveFile = files.getSaveNm();
        File file = new File(saveFolder, saveFile);

        response.setContentType("apllication/download; charset=UTF-8");
        response.setContentLength((int) file.length());

        String header = request.getHeader("User-Agent");
        boolean isIE = header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1;
        String fileName = null;
        // IE는 다르게 처리
        if (isIE) {
            fileName = URLEncoder.encode(originalFile, "UTF-8").replaceAll("\\+", "%20");
        } else {
            fileName = new String(originalFile.getBytes("UTF-8"), "ISO-8859-1");
        }
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        OutputStream out = response.getOutputStream();
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, out);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(fis != null) {
                try {
                    fis.close();
                    out.flush();
                }catch (IOException e) {
                    e.printStackTrace();
                }
            }
            out.close();
        }

        return "redirect:" + urlPath;
    }

    @RequestMapping(value="fileRemove.do", method=RequestMethod.POST)
    public ResponseEntity fileRemove(@RequestBody FileDTO fileDTO) throws Exception {
        boolean result = false;
        int fno = fileDTO.getFno();
        FileDTO files = filesService.fileByFno(fno);
        File file = new File(files.getSaveFolder() + File.separator + files.getSaveNm());
        if (file.exists()) { // 해당 파일이 존재하면
            file.delete(); // 파일 삭제
            filesService.filesDelete(fno);
            result = true;
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @RequestMapping(value="getBoardMgnList.do", method=RequestMethod.POST)
    public ResponseEntity getBoardMgnList() throws Exception {
        List<BoardMgn> boardMgnListForHeader = boardMgnService.listBoardMgnForHeader();
        return new ResponseEntity<>(boardMgnListForHeader, HttpStatus.OK);
    }

}