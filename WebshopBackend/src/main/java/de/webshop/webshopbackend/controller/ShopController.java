package de.webshop.webshopbackend.controller;

import de.webshop.webshopbackend.model.Categorie;
import de.webshop.webshopbackend.model.PurchaseObjectModel;
import de.webshop.webshopbackend.service.CreatePurchaseObjectService;
import de.webshop.webshopbackend.service.DeletePurchaseObjectService;
import de.webshop.webshopbackend.service.FindPurchaseObjectService;
import de.webshop.webshopbackend.service.UpdatePurchaseObjectService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/shop")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public class ShopController {

    CreatePurchaseObjectService createPurchaseObjectService;
    DeletePurchaseObjectService deletePurchaseObjectService;
    FindPurchaseObjectService findPurchaseObjectService;
    UpdatePurchaseObjectService updatePurchaseObjectService;

    @PostMapping("/create")
    ResponseEntity<PurchaseObjectModel> createPurchaseObject(@RequestBody PurchaseObjectModel purchaseObjectModel) {
        return ResponseEntity.ok(createPurchaseObjectService.createPurchaseObject(purchaseObjectModel));
    }

    @DeleteMapping("/delete/{id}")
    ResponseEntity<PurchaseObjectModel> deletePurchaseObjectById(@PathVariable UUID id) {
        deletePurchaseObjectService.deletePurchaseObjectById(id);
        return ResponseEntity.noContent().build();
    }
    @PutMapping("/update")
    ResponseEntity<PurchaseObjectModel> updatePurchaseObject(@RequestBody PurchaseObjectModel purchaseObjectModel) {
        return ResponseEntity.ok(updatePurchaseObjectService.updatePurchaseObject(purchaseObjectModel));
    }
    @GetMapping("/{id}")
    ResponseEntity<PurchaseObjectModel> findPurchaseObjectById(@PathVariable UUID id) {
        return ResponseEntity.ok(findPurchaseObjectService.findPurchaseObjectById(id));
    }
    @GetMapping("/{category}")
    ResponseEntity<PurchaseObjectModel> findPurchaseObjectByCategory(@PathVariable Categorie category) {
        return ResponseEntity.ok(findPurchaseObjectService.findPurchaseObjectByCategory(category));
    }
    @GetMapping("/all")
    ResponseEntity<List<PurchaseObjectModel>> findPurchaseObjectByPrice() {
        return ResponseEntity.ok(findPurchaseObjectService.findAllPurchaseObjectModel());
    }
}
