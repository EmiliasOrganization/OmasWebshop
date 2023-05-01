package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.model.ProductModel;
import de.webshop.webshopbackend.repo.PurchaseObjectsRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public class UpdatePurchaseObjectService {

    PurchaseObjectsRepository purchaseObjectsRepository;

    public void updatePurchaseObject(ProductModel productModel) {
        purchaseObjectsRepository.save(productModel);
    }
}
