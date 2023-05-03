package de.webshop.webshopbackend.controller;

import de.webshop.webshopbackend.Utils.ImageCompressionUtil;
import de.webshop.webshopbackend.model.Category;
import de.webshop.webshopbackend.model.PictureModel;
import de.webshop.webshopbackend.model.ProductModel;
import de.webshop.webshopbackend.service.*;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import static de.webshop.webshopbackend.Utils.ImageUploaderUtil.imageUpload;

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
    PictureService pictureService;

    @PostMapping("/create")
    ResponseEntity<?> createPurchaseObject(@RequestPart(name = "Files", required = false) MultipartFile[] files, @RequestPart("ObjectData") ProductModel productModel) throws IOException {

        if (files == null || files.length == 0){
            createPurchaseObjectService.createPurchaseObject(productModel);
            return ResponseEntity.ok("Only ObjectData uploaded successfully!");
        }

        imageUpload(files, productModel);
        createPurchaseObjectService.createPurchaseObject(productModel);

        return ResponseEntity.ok("Files uploaded successfully!");
    }

    @DeleteMapping("/delete/{id}")
    ResponseEntity<?> deletePurchaseObjectById(@PathVariable UUID id) {
        deletePurchaseObjectService.deletePurchaseObjectById(id);
        return ResponseEntity.noContent().build();
    }
    @PutMapping("/update")
    ResponseEntity<?> updatePurchaseObject(@RequestPart(name = "Files", required = false) MultipartFile[] files, @RequestPart("ObjectData") ProductModel productModel) throws IOException {

        if (files == null || files.length == 0){
            createPurchaseObjectService.createPurchaseObject(productModel);
            return ResponseEntity.ok("Data updated successfully!");
        }

        imageUpload(files, productModel);
        updatePurchaseObjectService.updatePurchaseObject(productModel);

        return ResponseEntity.ok("Files updated successfully!");
    }

    @GetMapping("/id/{id}")
    ResponseEntity<?> findPurchaseObjectById(@PathVariable UUID id) {
        return ResponseEntity.ok(findPurchaseObjectService.findPurchaseObjectById(id));
    }
    @GetMapping("/category/{category}")
    ResponseEntity<?> findPurchaseObjectByCategory(@PathVariable Category category) {
        return ResponseEntity.ok(findPurchaseObjectService.findPurchaseObjectByCategory(category));
    }
    @GetMapping("/all")
    ResponseEntity<List<?>> findAllSummary() {
        return ResponseEntity.ok(findPurchaseObjectService.findAllSummary());
    }
    @GetMapping("/picture/{id}/{pictureName}")
    ResponseEntity<?> findPictureById(@PathVariable String pictureName, @PathVariable UUID id) {
        PictureModel pictureModel = pictureService.getPicturebyFilenameAndProductId(pictureName, id);
        byte[] data = ImageCompressionUtil.decompressImage(pictureModel.getData());
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);
        return new ResponseEntity<>(data, headers, HttpStatus.OK);

    }
}
