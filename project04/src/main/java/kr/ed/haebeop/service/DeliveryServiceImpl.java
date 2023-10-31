package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Delivery;
import kr.ed.haebeop.persistence.DeliveryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DeliveryServiceImpl implements DeliveryService {

    @Autowired
    private DeliveryMapper deliveryMapper;

    @Override
    public void deliveryStatusUpdate(Delivery delivery) throws Exception {
        deliveryMapper.deliveryStatusUpdate(delivery);
    }

    @Override
    public void deliveryDeliveryDateUpdate(int dno) throws Exception {
        deliveryMapper.deliveryDeliveryDateUpdate(dno);
    }
}