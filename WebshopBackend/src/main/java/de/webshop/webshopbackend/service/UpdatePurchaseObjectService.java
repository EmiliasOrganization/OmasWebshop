package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.model.PurchaseObjectModel;
import de.webshop.webshopbackend.repo.PurchaseObjectsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UpdatePurchaseObjectService {

    PurchaseObjectsRepository purchaseObjectsRepository;

    public PurchaseObjectModel updatePurchaseObject(PurchaseObjectModel purchaseObjectModel) {
        return purchaseObjectsRepository.save(purchaseObjectModel);
    }
}
