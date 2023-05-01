package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.repo.PurchaseObjectsRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public class DeletePurchaseObjectService {

    PurchaseObjectsRepository purchaseObjectsRepository;

    public void deletePurchaseObjectById(UUID id) {
        purchaseObjectsRepository.deleteById(id);
    }
}
