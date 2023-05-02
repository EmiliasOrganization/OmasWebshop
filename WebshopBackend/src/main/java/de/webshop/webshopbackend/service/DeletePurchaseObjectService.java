package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.repo.ProductRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public class DeletePurchaseObjectService {

    ProductRepository productRepository;

    public void deletePurchaseObjectById(UUID id) {
        productRepository.deleteById(id);
    }
}
