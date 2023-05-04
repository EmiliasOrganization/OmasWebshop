package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.Exceptions.ElementNotFoundException;
import de.webshop.webshopbackend.model.Category;
import de.webshop.webshopbackend.model.ProductModel;
import de.webshop.webshopbackend.model.ProductSummary;
import de.webshop.webshopbackend.repo.ProductRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public class FindPurchaseObjectService {

    ProductRepository productRepository;

    @Transactional
    public ProductModel findPurchaseObjectById(UUID id) {
        return productRepository.findById(id).orElseThrow(() -> new ElementNotFoundException("Product with id: " + id + " not found!"));
    }
    @Transactional
    public List<ProductSummary> findPurchaseObjectByCategory(Category category) {
        return productRepository.findAllProjectedByCategory(category);
    }
    @Transactional
    public List<ProductSummary> findAllSummary() {
        return productRepository.findAllProjectedBy();
    }


}
