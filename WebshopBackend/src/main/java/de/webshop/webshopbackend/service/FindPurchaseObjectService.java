package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.Exceptions.ElementNotFoundException;
import de.webshop.webshopbackend.model.Categorie;
import de.webshop.webshopbackend.model.PurchaseObjectModel;
import de.webshop.webshopbackend.repo.PurchaseObjectsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class FindPurchaseObjectService {

    PurchaseObjectsRepository purchaseObjectsRepository;

    public PurchaseObjectModel findPurchaseObjectById(UUID id) {
        return purchaseObjectsRepository.findById(id).orElseThrow(() -> new ElementNotFoundException("Product with id: " + id + " not found!"));
    }

    public PurchaseObjectModel findPurchaseObjectByCategory(Categorie category) {
        return purchaseObjectsRepository.findByCategory(category).orElseThrow(() -> new ElementNotFoundException("Product with category: " + category + " not found!"));
    }

    public List<PurchaseObjectModel> findAllPurchaseObjectModel() {
        return purchaseObjectsRepository.findAll();
    }


}
