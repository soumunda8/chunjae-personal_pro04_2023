package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Delivery;
import kr.ed.haebeop.domain.Payment;
import kr.ed.haebeop.domain.PaymentVO;
import kr.ed.haebeop.domain.Study;

import java.util.List;

public interface PaymentService {

    public List<PaymentVO> paymentList() throws Exception;
    public PaymentVO paymentGet(String author) throws Exception;
    public void paymentInsert(Study study, Delivery delivery, Payment payment) throws Exception;
    public void paymentStatusUpdate(int payNo) throws Exception;

}