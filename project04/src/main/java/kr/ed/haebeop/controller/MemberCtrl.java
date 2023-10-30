package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.FileDTO;
import kr.ed.haebeop.domain.Member;
import kr.ed.haebeop.domain.MemberMgn;
import kr.ed.haebeop.domain.MemberMgnVO;
import kr.ed.haebeop.service.FilesService;
import kr.ed.haebeop.service.MemberMgnService;
import kr.ed.haebeop.service.MemberService;
import kr.ed.haebeop.util.CheckValidator;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/user/")
public class MemberCtrl {

    @Autowired
    private MemberService memberService;

    @Autowired
    private MemberMgnService memberMgnService;

    @Autowired
    private FilesService filesService;

    @Autowired
    HttpSession session;

    @GetMapping("term.do")
    public String term(Model model) throws Exception {
        return "/member/joinTerm";
    }

    @GetMapping("join.do")
    public String join(Model model) throws Exception {
        return "/member/join";
    }

    @RequestMapping(value="idCheckPro.do", method=RequestMethod.POST)
    public ResponseEntity idCheck(@RequestBody Member member) throws Exception {
        String id = member.getId();
        boolean result = memberService.idCheck(id);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @PostMapping("joinPro.do")
    public String joinPro(Member member, Model model) throws Exception {
        memberService.insert(member);
        return "redirect:/user/finish.do";
    }

    @GetMapping("finish.do")
    public String joinFinish(Model model) throws Exception {
        return "/member/joinFinish";
    }

    @GetMapping("login.do")
    public String login(HttpServletRequest request, Model model) throws Exception {
        String msg = request.getParameter("msg") != null ? request.getParameter("msg") : "";
        model.addAttribute("msg", msg);
        return "/member/login";
    }

    @PostMapping("loginPro.do")
    public String loginPro(@RequestParam String id, @RequestParam String pw, Model model) throws Exception {
        boolean pass = memberService.loginPro(id, pw);
        if (pass) {
            session.setAttribute("sid", id);
            return "redirect:/";
        } else {
            return "redirect:/user/login.do?msg=fail";
        }
    }

    @GetMapping("/logout.do")
    public String logout(Model model) throws Exception {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/myPage.do")
    public String myPage(Model model) throws Exception {
        String sid = (String) session.getAttribute("sid");
        Member member = memberService.memberGet(sid);
        model.addAttribute("member", member);

        boolean canUpgrade = true;
        MemberMgnVO memberMgn = memberMgnService.memberMgnGet(sid);
        if(memberMgn != null && (memberMgn.getMStatus() == 1 || memberMgn.getMStatus() == 3 || memberMgn.getMStatus() == 4)) {
            canUpgrade = false;
        }
        model.addAttribute("canUpgrade", canUpgrade);

        return "/member/myPage";
    }

    @GetMapping("/myPageEdit.do")
    public String memberUpdate(Model model) throws Exception {
        String sid = (String) session.getAttribute("sid");
        Member member = memberService.memberGet(sid);
        model.addAttribute("member", member);
        return "/member/myPageEdit";
    }

    @PostMapping("/myPageEdit.do")
    public String memberUpdatePro(Member member, Model model) throws Exception {
        member.setId((String) session.getAttribute("sid"));
        memberService.updateMember(member);
        return "redirect:/user/myPage.do";
    }

    @GetMapping("/mypageRemoveUser.do")
    public String memberDeletePost(HttpServletRequest request, Model model) throws Exception {
        String sid = (String) session.getAttribute("sid");
        String id = request.getParameter("id");
        memberService.removeMember(id);
        if(sid.equals("admin")) {
            return "redirect:/admin/memberConf.do";
        } else {
            return "redirect:/user/logout.do";
        }
    }

    @GetMapping("/mypageChangePw.do")
    public String memberUpdatePw(Model model) throws Exception {
        String sid = (String) session.getAttribute("sid");
        Member member = memberService.memberGet(sid);
        model.addAttribute("member", member);
        return "/member/myPageEditPw";
    }

    @PostMapping("/mypageChangePw.do")
    public String memberUpdatePwPro(HttpServletRequest request, Model model, RedirectAttributes rttr) throws Exception {
        String sid = (String) session.getAttribute("sid");

        String checkPw = request.getParameter("checkPw");
        String pw = request.getParameter("pw");

        boolean pass = false;
        if(sid != "admin") {
            pass = memberService.loginPro(sid, checkPw);
            if(pass) {
                Member member = new Member();
                member.setId(sid);
                member.setPw(pw);
                memberService.updatePw(member);
                rttr.addFlashAttribute("msg", "pwSuccess");
                return "redirect:/user/myPage.do";
            } else {
                rttr.addFlashAttribute("msg", "fail");
                return "redirect:/user/mypageChangePw.do";
            }
        } else {
            return "redirect:/user/myPage.do";
        }
    }

    @GetMapping("/mypageChangeGrade.do")
    public String memberUpgrade(Model model) throws Exception {
        String sid = (String) session.getAttribute("sid");
        Member member = memberService.memberGet(sid);
        model.addAttribute("member", member);

        boolean showFailContent = false;
        MemberMgnVO memberMgnVO = memberMgnService.memberMgnGet(sid);
        model.addAttribute("memberMgnVO", memberMgnVO);
        if(memberMgnVO != null && memberMgnVO.getMStatus() == 2) {
            showFailContent = true;
        }
        model.addAttribute("showFailContent", showFailContent);

        return "/member/myPageUpgrade";
    }

    @PostMapping("/mypageChangeGrade.do")
    public String memberUpgradePro(HttpServletRequest request, List<MultipartFile> uploadFiles) throws Exception {
        String sid = (String) session.getAttribute("sid");
        //String checkTeacher = request.getParameter("checkTeacher") != null ? request.getParameter("checkTeacher") : "'";
        Member member = memberService.memberGet(sid);
        MemberMgnVO memberMgnVO = memberMgnService.memberMgnGet(sid);

        if (sid != null) {

            if(memberMgnVO == null || memberMgnVO.getMStatus() == 0) {
                memberMgnService.memberMgnInsert(sid);
            }

            if(memberMgnVO != null && memberMgnVO.getMStatus() == 2) {
                int par = member.getMno();
                FileDTO fileList = filesService.fileByParForGrade(par);
                File file = new File(fileList.getSaveFolder() + File.separator + fileList.getSaveNm());
                if (file.exists()) { // 해당 파일이 존재하면
                    file.delete(); // 파일 삭제
                    filesService.filesDelete(fileList.getFno());
                }

                MemberMgn memberMgn = new MemberMgn();
                memberMgn.setMStatus(4);
                memberMgn.setAuthor(sid);
                memberMgnService.memberMgnStatusUpdate(memberMgn);
            }

            if(uploadFiles != null) {

                ServletContext application = request.getSession().getServletContext();
                //String realPath = application.getRealPath("/resources/upload/teacher");                                                             // 운영 서버
                String realPath = "D:\\park\\project\\personal\\personal_pro04_2023\\project04\\src\\main\\webapp\\resources\\upload\\teacher";	  // 개발 서버

                File uploadPath = new File(realPath);
                if(!uploadPath.exists()) {uploadPath.mkdirs();}

                for(MultipartFile multipartFile : uploadFiles) {
                    if(multipartFile.isEmpty()) {continue;}

                    String originalFilename = multipartFile.getOriginalFilename();
                    UUID uuid = UUID.randomUUID();
                    String uploadFilename = uuid.toString() + "_" + originalFilename;

                    FileDTO fileDTO = new FileDTO();
                    fileDTO.setPar(member.getMno());
                    fileDTO.setSaveFolder("teacher");

                    String fileType = multipartFile.getContentType();
                    String[] fileTypeArr = fileType.split("/");
                    fileDTO.setFileType(fileTypeArr[0]);

                    fileDTO.setOriginNm(originalFilename);
                    fileDTO.setSaveNm(uploadFilename);
                    fileDTO.setToUse("member");

                    multipartFile.transferTo(new File(uploadPath, uploadFilename));     // 서버에 파일 업로드 수행
                    filesService.filesInsert(fileDTO);                                  // DB 등록
                }

            }
        }

        return "redirect:/user/myPage.do";
    }


    @GetMapping("/memberMgnAccept.do")
    public String memberUpgradeAccept(HttpServletRequest request, Model model) throws Exception {
        String urlPath = request.getHeader("referer");
        String id = request.getParameter("id");

        memberMgnService.memberMgnUpdateAccept(id);
        memberService.updateMemberForTeacher(id);

        return "redirect:" + urlPath;
    }

    @PostMapping("/memberMgnRefuse.do")
    @ResponseBody
    public boolean memberUpgradeRefuse(@RequestParam("no") int mmNo, @RequestParam("content") String content) throws Exception {
        MemberMgn memberMgn = new MemberMgn();
        memberMgn.setMmNo(mmNo);
        memberMgn.setContent(content);
        memberMgnService.memberMgnUpdate(memberMgn);
        return true;
    }

    /*
    @InitBinder
    protected void initBinder(WebDataBinder binder){
        binder.setValidator(new CheckValidator());
    }

    @PostMapping("idCheck.do")
    public void idCheck(@ModelAttribute @Valid Member member, BindingResult result, HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
        String id = request.getParameter("id");
        //Member mem = memberService.getMember(id);
        boolean result = false;

        if(!result.hasErrors()) {
            result = true;
        }

        JSONObject json = new JSONObject();
        json.put("result", result);
        PrintWriter out = response.getWriter();
        out.println(json.toString());
    }
    */

}