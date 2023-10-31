package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Delivery;
import kr.ed.haebeop.domain.Payment;
import kr.ed.haebeop.domain.PaymentVO;
import kr.ed.haebeop.domain.Study;
import kr.ed.haebeop.persistence.DeliveryMapper;
import kr.ed.haebeop.persistence.PaymentMapper;
import kr.ed.haebeop.persistence.StudyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.annotation.Commit;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PaymentServiceImpl implements PaymentService {

    @Autowired
    private PaymentMapper paymentMapper;

    @Autowired
    private DeliveryMapper deliveryMapper;

    @Autowired
    private StudyMapper studyMapper;

    @Override
    public List<PaymentVO> paymentList() throws Exception {
        return paymentMapper.paymentList();
    }

    @Override
    public PaymentVO paymentGet(String author) throws Exception {
        return paymentMapper.paymentGet(author);
    }

    @Override
    @Transactional(readOnly = true)
    @Commit
    public void paymentInsert(Study study, Delivery delivery, Payment payment) throws Exception {
        studyMapper.studyInsert(study);
        Study studyInfo = studyMapper.studyLast();

        deliveryMapper.deliveryInsert(delivery);
        Delivery deliveryInfo = deliveryMapper.deliveryLast();

        payment.setSno(studyInfo.getSno());
        payment.setDno(deliveryInfo.getDno());

        paymentMapper.paymentInsert(payment);

    }

    @Override
    public void paymentStatusUpdate(int payNo) throws Exception {
        paymentMapper.paymentStatusUpdate(payNo);
    }
}