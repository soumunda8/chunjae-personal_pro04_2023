package kr.ed.haebeop.controller;

import kr.ed.haebeop.domain.*;
import kr.ed.haebeop.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/payment")
public class PaymentCtrl {

    @Autowired
    HttpSession session;

    @Autowired
    private MemberService memberService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private DeliveryService deliveryService;

    @Autowired
    private StudyService studyService;

    @GetMapping("/pay.do")
    public String pay(@RequestParam("no") int lno, Model model) throws Exception {

        String id = (String) session.getAttribute("sid");

        if(id != null && !id.equals("admin")) {
            LectureVO lecture = lectureService.lectureGet(lno);
            model.addAttribute("lecture", lecture);

            Member member = memberService.memberGet(id);
            model.addAttribute("member", member);

            int sumPrice = lecture.getLPrice() + lecture.getProPrice();
            model.addAttribute("sumPrice", sumPrice);

            return "/payment/payment";
        } else {
            return "redirect:/user/login.do";
        }
    }
    @PostMapping("/pay.do")
    public String payPro(HttpServletRequest request, Model model) throws Exception {

        String id = (String) session.getAttribute("sid");

        if(id != null && !id.equals("admin")) {
            Member member = memberService.memberGet(id);

            int lno = Integer.parseInt(request.getParameter("lno"));
            String name = member.getNm();
            String tel = member.getTel();
            String addr = "[" + request.getParameter("cusPostcode") + "] " + request.getParameter("cusAddr1") + request.getParameter("cusAddr2");

            String dTel = "XXX-XXXX-XXXX";
            String dCode = "XXXXXXXX";

            String pMethod = request.getParameter("pMethod");
            String pCom = request.getParameter("pCom");
            String pNum = request.getParameter("pNum");
            int payPrice = Integer.parseInt(request.getParameter("payPrice"));

            Study study = new Study();
            study.setLno(lno);
            study.setStudentId(id);

            Delivery delivery = new Delivery();
            delivery.setCusNm(name);
            delivery.setCusTel(tel);
            delivery.setCusAddr(addr);
            delivery.setDTel(dTel);
            delivery.setDCode(dCode);
            delivery.setAuthor(id);

            Payment payment = new Payment();
            payment.setAuthor(id);
            payment.setPMethod(pMethod);
            payment.setPCom(pCom);
            payment.setPNum(pNum);
            payment.setPayPrice(payPrice);
            paymentService.paymentInsert(study, delivery, payment);

            return "redirect:/user/myPage.do";
        } else {
            return "redirect:/user/login.do";
        }
    }

}