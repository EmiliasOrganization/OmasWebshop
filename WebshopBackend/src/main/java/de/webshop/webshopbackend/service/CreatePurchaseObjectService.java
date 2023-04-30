package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.model.PurchaseObjectModel;
import de.webshop.webshopbackend.repo.PurchaseObjectsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CreatePurchaseObjectService {


    @Autowired
    public CreatePurchaseObjectService(PurchaseObjectsRepository purchaseObjectsRepository) {
        this.purchaseObjectsRepository = purchaseObjectsRepository;
    }

    private final PurchaseObjectsRepository purchaseObjectsRepository;

    public PurchaseObjectModel createPurchaseObject(PurchaseObjectModel purchaseObjectModel) {
        return purchaseObjectsRepository.save(purchaseObjectModel);
    }
}
