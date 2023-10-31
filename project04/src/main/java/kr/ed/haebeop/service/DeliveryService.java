package kr.ed.haebeop.service;

import kr.ed.haebeop.domain.Delivery;

public interface DeliveryService {

    public void deliveryStatusUpdate(Delivery delivery) throws Exception;
    public void deliveryDeliveryDateUpdate(int dno) throws Exception;

}