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
public class CreatePurchaseObjectService {


    PurchaseObjectsRepository purchaseObjectsRepository;


    public void createPurchaseObject(ProductModel productModel) {
        purchaseObjectsRepository.save(productModel);
    }
}
