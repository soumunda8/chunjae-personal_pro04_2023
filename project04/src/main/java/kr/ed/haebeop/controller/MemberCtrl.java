package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.Member;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.PrintWriter;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/user/")
public class MemberCtrl {

    @Autowired
    private MemberService memberService;

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