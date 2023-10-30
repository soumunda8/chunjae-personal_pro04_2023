package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.*;
import kr.ed.haebeop.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminCtrl {

    @Autowired
    HttpSession session;

    @Autowired
    private MemberService memberService;

    @Autowired
    private MemberMgnService memberMgnService;

    @Autowired
    private BoardMgnService boardMgnService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private FilesService filesService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @GetMapping("/")
    public String home(Model model) throws Exception {
        return "/admin/home";
    }

    @GetMapping("/memberConf.do")
    public String memberList(HttpServletRequest request, Model model) throws Exception {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        int total = memberService.memberCount(page);
        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<Member> memberList = memberService.memberList(page);
        model.addAttribute("memberList", memberList);

        return "/admin/memberList";
    }

    @GetMapping("/memberMgnConf.do")
    public String memberMgnList(HttpServletRequest request, Model model) throws Exception {
        String type = request.getParameter("type") != null ? request.getParameter("type") : "";
        String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        int total = memberMgnService.memberMgnCount();

        Page page = new Page();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<MemberMgnVO> memberMgnList = memberMgnService.memberMgnList(page);
        for(MemberMgnVO member : memberMgnList) {
            Member mem = memberService.memberGet(member.getAuthor());
            FileDTO fileDTO = filesService.fileByParForGrade(mem.getMno());
            if(fileDTO != null) {
                member.setFno(fileDTO.getFno());
            }
        }
        model.addAttribute("memberMgnList", memberMgnList);

        return "/admin/memberApprove";
    }

    @GetMapping("/boardMgnConf.do")
    public String boardMgnList(HttpServletRequest request, Model model) throws Exception {
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        int total = boardMgnService.countBoardMgn(page);
        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<BoardMgn> boardMgnList = boardMgnService.listBoardMgn(page);
        model.addAttribute("boardMgnList", boardMgnList);


        return "/admin/boardTypeList";
    }

    @GetMapping("/getBoardMgn.do")
    public String boardMgnGet(HttpServletRequest request, Model model) throws Exception {
        int bmNo = Integer.parseInt(request.getParameter("no"));

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        return "/admin/boardTypeGet";
    }

    @GetMapping("/boardMgnAdd.do")
    public String boardMgnAdd(Model model) throws Exception {

        return "/admin/boardTypeAdd";
    }

    @PostMapping("/boardMgnAdd.do")
    public String boardMgnAddPro(BoardMgn boardMgn, Model model) throws Exception {
        boardMgnService.boardMgnInsert(boardMgn);

        return "redirect:/admin/boardMgnConf.do";
    }

    @GetMapping("/boardMgnModify.do")
    public String boardMgnModify(HttpServletRequest request, Model model) throws Exception {
        int bmNo = Integer.parseInt(request.getParameter("no"));

        BoardMgn boardMgn = boardMgnService.getBoardMgn(bmNo);
        model.addAttribute("boardMgn", boardMgn);

        return "/admin/boardTypeUpdate";
    }

    @PostMapping("/boardMgnModify.do")
    public String boardMgnModifyPro(BoardMgn boardMgn, Model model) throws Exception {

        int par = boardMgn.getPar();

        boardMgnService.boardMgnUpdate(boardMgn);

        return "redirect:/admin/getBoardMgn.do?no="+boardMgn.getBmNo();
    }

    @GetMapping("/boardMgnDel.do")
    public String boardMgnDeletePro(HttpServletRequest request, Model model) throws Exception {
        int bmNo = Integer.parseInt(request.getParameter("no"));

        List<BoardVO> boardList = boardService.boardListForAdmin(bmNo);

        for (BoardVO board : boardList) {
            int bno = board.getBno();

            FileDTO fileDTO = new FileDTO();
            fileDTO.setPar(bno);
            fileDTO.setToUse("board");
            List<FileDTO> fileList = filesService.fileListByPar(fileDTO);
            for(FileDTO files : fileList) {
                File file = new File(files.getSaveFolder() + File.separator + files.getSaveNm());
                if (file.exists()) {
                    file.delete();
                    filesService.filesDeleteAll(bno);
                }
            }
            commentService.commentDeleteAll(bno);
            boardService.boardDelete(bno);
        }

        boardMgnService.boardMgnDelete(bmNo);

        return "redirect:/admin/boardMgnConf.do";
    }

    @GetMapping("/lectureConf.do")
    public String lectureList(HttpServletRequest request, Model model) throws Exception {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        int total = lectureService.lectureCount(page);

        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<LectureVO> lectureList = lectureService.lectureList(page);
        model.addAttribute("lectureList", lectureList);

        return "/admin/lectureList";
    }

    @GetMapping("/lectureAdd.do")
    public String lectureAdd(Model model) throws Exception {

        List<Category> categoryList = categoryService.categoryKeywordList("su");
        model.addAttribute("categoryList", categoryList);

        return "/admin/lectureAdd";
    }

    @PostMapping("/lectureAdd.do")
    public String lectureAddPro(HttpServletRequest request,Lecture lecture, Model model, MultipartFile uploadThumbnail, MultipartFile uploadVideo) throws Exception {

        Lecture lec = lectureService.lectureInsert(lecture);

        ServletContext application = request.getSession().getServletContext();
        //String realPath = application.getRealPath("/resources/upload");                                                             // 운영 서버
        String realPath = "C:\\Dev\\IdeaProjects\\project\\personal\\project4\\project04\\src\\main\\webapp\\resources\\upload\\lecture";	  // 개발 서버
        File uploadPath = new File(realPath);
        if(!uploadPath.exists()) {uploadPath.mkdirs();}

        if(uploadThumbnail != null) {
            String originalFilename = uploadThumbnail.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String uploadFilename = uuid.toString() + "_" + originalFilename;

            FileDTO fileDTO = new FileDTO();
            fileDTO.setPar(lec.getLno());
            fileDTO.setSaveFolder("lecture");

            String fileType = uploadThumbnail.getContentType();
            String[] fileTypeArr = fileType.split("/");
            fileDTO.setFileType(fileTypeArr[0]);

            fileDTO.setOriginNm(originalFilename);
            fileDTO.setSaveNm(uploadFilename);
            fileDTO.setToUse("lecture");

            uploadThumbnail.transferTo(new File(uploadPath, uploadFilename));     // 서버에 파일 업로드 수행
            filesService.filesInsert(fileDTO);                                  // DB 등록
        }

        if(uploadVideo != null) {
            String originalFilename = uploadVideo.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String uploadFilename = uuid.toString() + "_" + originalFilename;

            FileDTO fileDTO = new FileDTO();
            fileDTO.setPar(lec.getLno());
            fileDTO.setSaveFolder("lecture");

            String fileType = uploadVideo.getContentType();
            String[] fileTypeArr = fileType.split("/");
            fileDTO.setFileType(fileTypeArr[0]);

            fileDTO.setOriginNm(originalFilename);
            fileDTO.setSaveNm(uploadFilename);
            fileDTO.setToUse("lecture");

            uploadThumbnail.transferTo(new File(uploadPath, uploadFilename));     // 서버에 파일 업로드 수행
            filesService.filesInsert(fileDTO);                                  // DB 등록
        }

        return "redirect:/admin/lectureConf.do";
    }

    @GetMapping("/getLecture.do")
    public String lectureGet(@RequestParam("no") int lno, Model model) throws Exception {

        LectureVO lecture = lectureService.lectureGet(lno);
        model.addAttribute("lecture", lecture);

        FileDTO fileDTO = new FileDTO();
        fileDTO.setPar(lecture.getLno());
        fileDTO.setToUse("lecture");
        List<FileDTO> fileList= filesService.fileListByPar(fileDTO);
        model.addAttribute("fileList", fileList);

        List<Category> categoryList = categoryService.categoryKeywordList("su");
        model.addAttribute("categoryList", categoryList);

        return "/admin/lectureGet";
    }

    @GetMapping("/lectureEdit.do")
    public String lectureUpdate(@RequestParam("no") int lno, Model model) throws Exception {

        LectureVO lecture = lectureService.lectureGet(lno);
        model.addAttribute("lecture", lecture);

        FileDTO fileDTO = new FileDTO();
        fileDTO.setPar(lecture.getLno());
        fileDTO.setToUse("lecture");
        List<FileDTO> fileList= filesService.fileListByPar(fileDTO);
        model.addAttribute("fileList", fileList);

        List<Category> categoryList = categoryService.categoryKeywordList("su");
        model.addAttribute("categoryList", categoryList);

        return "/admin/lectureUpdate";
    }

    @PostMapping("/lectureEdit.do")
    public String lectureUpdatePro(HttpServletRequest request,Lecture lecture, Model model, MultipartFile uploadThumbnail, MultipartFile uploadVideo) throws Exception {

        if(lecture.getLectureType() == 0) {
            lecture.setStartDate(request.getParameter("originStartDate"));
            lecture.setEndDate(request.getParameter("originEndDate"));
        }

        lectureService.lectureUpdate(lecture);

        ServletContext application = request.getSession().getServletContext();
        //String realPath = application.getRealPath("/resources/upload");                                                             // 운영 서버
        String realPath = "C:\\Dev\\IdeaProjects\\project\\personal\\project4\\project04\\src\\main\\webapp\\resources\\upload\\lecture";	  // 개발 서버
        File uploadPath = new File(realPath);
        if(!uploadPath.exists()) {uploadPath.mkdirs();}

        if(uploadThumbnail != null && uploadThumbnail.getSize() != 0) {;
            String originalFilename = uploadThumbnail.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String uploadFilename = uuid.toString() + "_" + originalFilename;

            FileDTO fileDTO = new FileDTO();
            fileDTO.setPar(lecture.getLno());
            fileDTO.setSaveFolder("lecture");

            String fileType = uploadThumbnail.getContentType();
            String[] fileTypeArr = fileType.split("/");
            fileDTO.setFileType(fileTypeArr[0]);

            fileDTO.setOriginNm(originalFilename);
            fileDTO.setSaveNm(uploadFilename);
            fileDTO.setToUse("lecture");

            uploadThumbnail.transferTo(new File(uploadPath, uploadFilename));     // 서버에 파일 업로드 수행
            filesService.filesInsert(fileDTO);                                  // DB 등록
        }

        if(uploadVideo != null && uploadVideo.getSize() != 0) {
            String originalFilename = uploadVideo.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String uploadFilename = uuid.toString() + "_" + originalFilename;

            FileDTO fileDTO = new FileDTO();
            fileDTO.setPar(lecture.getLno());
            fileDTO.setSaveFolder("lecture");

            String fileType = uploadVideo.getContentType();
            String[] fileTypeArr = fileType.split("/");
            fileDTO.setFileType(fileTypeArr[0]);

            fileDTO.setOriginNm(originalFilename);
            fileDTO.setSaveNm(uploadFilename);
            fileDTO.setToUse("lecture");

            uploadThumbnail.transferTo(new File(uploadPath, uploadFilename));     // 서버에 파일 업로드 수행
            filesService.filesInsert(fileDTO);                                  // DB 등록
        }

        return "redirect:/admin/getLecture.do?no=" + lecture.getLno();
    }

    @GetMapping("/lectureDel.do")
    public String lectureDeletePro(HttpServletRequest request, @RequestParam("no") int lno, Model model) throws Exception {

        ServletContext application = request.getSession().getServletContext();
        //String realPath = application.getRealPath("/resources/upload/");                                                            // 운영 서버
        String realPath = "C:\\Dev\\IdeaProjects\\project\\personal\\project4\\project04\\src\\main\\webapp\\resources\\upload";	  // 개발 서버

        FileDTO fileDTO = new FileDTO();
        fileDTO.setToUse("lecture");
        fileDTO.setPar(lno);
        List<FileDTO> fileList = filesService.fileListByPar(fileDTO);
        for(FileDTO files : fileList) {
            File file = new File( realPath + File.separator + files.getSaveFolder() + File.separator + files.getSaveNm());
            if (file.exists()) { // 해당 파일이 존재하면
                file.delete(); // 파일 삭제
                filesService.filesDelete(files.getFno());
            }
        }

        lectureService.lectureDelete(lno);

        return "redirect:/admin/lectureConf.do";
    }

    @GetMapping("/categoryConf.do")
    public String categoryList(HttpServletRequest request, Model model) throws Exception {

        List<Category> categoryList = categoryService.categoryList();
        model.addAttribute("categoryList", categoryList);

        return "/admin/categoryList";
    }

    @GetMapping("/categoryAdd.do")
    public String categoryAdd(Model model) throws Exception {
        return "/admin/categoryAdd";
    }

    @PostMapping("/categoryAdd.do")
    public String categoryAddPro(HttpServletRequest request, Model model) throws Exception {

        Category category = new Category();
        category.setCateNo(request.getParameter("cateNo"));
        category.setCName(request.getParameter("cName"));
        categoryService.categoryInsert(category);

        return "redirect:/admin/categoryConf.do";
    }

    @GetMapping("/getCategory.do")
    public String categoryGet(@RequestParam("no") String cateNo, Model model) throws Exception {

        Category category = categoryService.categoryGet(cateNo);
        model.addAttribute("category", category);

        return "/admin/categoryGet";
    }

    @GetMapping("/categoryEdit.do")
    public String categoryUpdate(@RequestParam("no") String cateNo, Model model) throws Exception {

        Category category = categoryService.categoryGet(cateNo);
        model.addAttribute("category", category);

        return "/admin/categoryUpdate";
    }

    @PostMapping("/categoryEdit.do")
    public String categoryUpdatePro(HttpServletRequest request, Model model) throws Exception {

        Category category = new Category();
        category.setCateNo(request.getParameter("cateNo"));
        category.setCName(request.getParameter("cName"));
        categoryService.categoryUpdate(category);

        return "redirect:/admin/getCategory.do?no=" + request.getParameter("cateNo");
    }

    @GetMapping("/categoryDel.do")
    public String categoryDeletePro(@RequestParam("no") String cateNo, Model model) throws Exception {

        categoryService.categoryDelete(cateNo);

        return "redirect:/admin/categoryConf.do";
    }

    @GetMapping("/productConf.do")
    public String productList(HttpServletRequest request, Model model) throws Exception {

        List<Product> productList = productService.productList();
        model.addAttribute("productList", productList);

        return "/admin/productList";
    }

    @GetMapping("/productAdd.do")
    public String productAdd(Model model) throws Exception {
        return "/admin/productAdd";
    }

    @PostMapping("/productAdd.do")
    public String productAddPro(HttpServletRequest request, Model model, MultipartFile uploadThumbnail) throws Exception {

        Product product = new Product();
        product.setProNm(request.getParameter("proNm"));
        product.setProPrice(Integer.parseInt(request.getParameter("proPrice")));
        Product pro = productService.productInsert(product);

        if(uploadThumbnail != null) {
            ServletContext application = request.getSession().getServletContext();
            //String realPath = application.getRealPath("/resources/upload/product");                                                             // 운영 서버
            String realPath = "C:\\Dev\\IdeaProjects\\project\\personal\\project4\\project04\\src\\main\\webapp\\resources\\upload\\product";	  // 개발 서버

            File uploadPath = new File(realPath);
            if(!uploadPath.exists()) {uploadPath.mkdirs();}

            String originalFilename = uploadThumbnail.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String uploadFilename = uuid.toString() + "_" + originalFilename;

            FileDTO fileDTO = new FileDTO();
            fileDTO.setPar(pro.getProNo());
            fileDTO.setSaveFolder("product");

            String fileType = uploadThumbnail.getContentType();
            String[] fileTypeArr = fileType.split("/");
            fileDTO.setFileType(fileTypeArr[0]);

            fileDTO.setOriginNm(originalFilename);
            fileDTO.setSaveNm(uploadFilename);
            fileDTO.setToUse("product");

            uploadThumbnail.transferTo(new File(uploadPath, uploadFilename));     // 서버에 파일 업로드 수행
            filesService.filesInsert(fileDTO);                                    // DB 등록

        }

        return "redirect:/admin/productConf.do";
    }

    @GetMapping("/getProduct.do")
    public String productGet(@RequestParam("no") int proNo, Model model) throws Exception {

        Product product = productService.productGet(proNo);
        model.addAttribute("product", product);

        FileDTO fileDTO = new FileDTO();
        fileDTO.setPar(proNo);
        fileDTO.setToUse("product");
        List<FileDTO> fileList = filesService.fileListByPar(fileDTO);
        model.addAttribute("fileList", fileList);

        return "/admin/productGet";
    }

    @GetMapping("/productEdit.do")
    public String productUpdate(@RequestParam("no") int proNo, Model model) throws Exception {

        Product product = productService.productGet(proNo);
        model.addAttribute("product", product);

        FileDTO fileDTO = new FileDTO();
        fileDTO.setPar(proNo);
        fileDTO.setToUse("product");
        List<FileDTO> fileList = filesService.fileListByPar(fileDTO);
        model.addAttribute("fileList", fileList);

        return "/admin/productUpdate";
    }

    @PostMapping("/productEdit.do")
    public String productUpdatePro(HttpServletRequest request, Model model, MultipartFile uploadThumbnail) throws Exception {

        int proNo = request.getParameter("proNo") != null ? Integer.parseInt(request.getParameter("proNo")) : 0;

        Product product = new Product();
        product.setProPrice(Integer.parseInt(request.getParameter("proPrice")));
        product.setProNo(proNo);
        product.setProNm(request.getParameter("proNm"));

        if(uploadThumbnail != null) {
            ServletContext application = request.getSession().getServletContext();
            //String realPath = application.getRealPath("/resources/upload/product");                                                             // 운영 서버
            String realPath = "C:\\Dev\\IdeaProjects\\project\\personal\\project4\\project04\\src\\main\\webapp\\resources\\upload\\product";	  // 개발 서버

            File uploadPath = new File(realPath);
            if(!uploadPath.exists()) {uploadPath.mkdirs();}

            String originalFilename = uploadThumbnail.getOriginalFilename();
            UUID uuid = UUID.randomUUID();
            String uploadFilename = uuid.toString() + "_" + originalFilename;

            FileDTO fileDTO = new FileDTO();
            fileDTO.setPar(proNo);
            fileDTO.setSaveFolder("product");

            String fileType = uploadThumbnail.getContentType();
            String[] fileTypeArr = fileType.split("/");
            fileDTO.setFileType(fileTypeArr[0]);

            fileDTO.setOriginNm(originalFilename);
            fileDTO.setSaveNm(uploadFilename);
            fileDTO.setToUse("product");

            uploadThumbnail.transferTo(new File(uploadPath, uploadFilename));     // 서버에 파일 업로드 수행
            filesService.filesInsert(fileDTO);                                    // DB 등록

        }

        return "redirect:/admin/getProduct.do?no=" + proNo;
    }

    @GetMapping("/productDel.do")
    public String categoryDeletePro(HttpServletRequest request, @RequestParam("no") int proNo, Model model) throws Exception {

        ServletContext application = request.getSession().getServletContext();
        //String realPath = application.getRealPath("/resources/upload/");                                                            // 운영 서버
        String realPath = "C:\\Dev\\IdeaProjects\\project\\personal\\project4\\project04\\src\\main\\webapp\\resources\\upload";	  // 개발 서버

        FileDTO fileDTO = new FileDTO();
        fileDTO.setToUse("product");
        fileDTO.setPar(proNo);
        List<FileDTO> fileList = filesService.fileListByPar(fileDTO);
        for(FileDTO files : fileList) {
            File file = new File( realPath + File.separator + files.getSaveFolder() + File.separator + files.getSaveNm());
            if (file.exists()) { // 해당 파일이 존재하면
                file.delete(); // 파일 삭제
                filesService.filesDelete(files.getFno());
            }
        }

        productService.productDelete(proNo);

        return "redirect:/admin/productConf.do";
    }

    @GetMapping("/findPro.do")
    public String findPro(HttpServletRequest request, Model model) throws Exception {

        List<Product> proList = productService.productList();
        model.addAttribute("proList", proList);

        return "/admin/findPro";
    }

    @GetMapping("/findTeacher.do")
    public String findTeacher(HttpServletRequest request, Model model) throws Exception {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        int total = memberService.memberTeacherCount(page);

        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<Member> teacherList = memberService.memberTeacherList(page);
        model.addAttribute("teacherList", teacherList);

        return "/admin/findTeacher";
    }

    @GetMapping("/findLecture.do")
    public String findLecture(HttpServletRequest request, Model model) throws Exception {
        String type = request.getParameter("type");
        String keyword = request.getParameter("keyword");
        int curPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        Page page = new Page();
        page.setSearchType(type);
        page.setSearchKeyword(keyword);
        int total = lectureService.lectureCount(page);

        page.makeBlock(curPage, total);
        page.makeLastPageNum(total);
        page.makePostStart(curPage, total);

        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("curPage", curPage);

        List<LectureVO> lectureList = lectureService.lectureList(page);
        model.addAttribute("lectureList", lectureList);

        return "/admin/findLecture";
    }

}