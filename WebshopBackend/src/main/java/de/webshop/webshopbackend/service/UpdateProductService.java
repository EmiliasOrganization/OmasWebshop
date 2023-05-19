package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.model.ProductModel;
import de.webshop.webshopbackend.repo.ProductRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public class UpdateProductService {

    ProductRepository productRepository;

    public void updatePurchaseObject(ProductModel productModel) {
        productRepository.save(productModel);
    }
}
