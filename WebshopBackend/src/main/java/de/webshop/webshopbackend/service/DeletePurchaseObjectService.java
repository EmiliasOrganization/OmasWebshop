package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.repo.PurchaseObjectsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DeletePurchaseObjectService {

    PurchaseObjectsRepository purchaseObjectsRepository;

    public void deletePurchaseObjectById(UUID id) {
        purchaseObjectsRepository.deleteById(id);
    }
}
