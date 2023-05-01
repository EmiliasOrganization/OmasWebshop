package de.webshop.webshopbackend.controller;

import de.webshop.webshopbackend.Utils.ImageCompressionUtil;
import de.webshop.webshopbackend.model.Categorie;
import de.webshop.webshopbackend.model.Picture;
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
import java.util.Arrays;
import java.util.Base64;
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
    ResponseEntity<ProductModel> deletePurchaseObjectById(@PathVariable UUID id) {
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
    ResponseEntity<ProductModel> findPurchaseObjectById(@PathVariable UUID id) {
        return ResponseEntity.ok(findPurchaseObjectService.findPurchaseObjectById(id));
    }
    @GetMapping("/category/{category}")
    ResponseEntity<ProductModel> findPurchaseObjectByCategory(@PathVariable Categorie category) {
        return ResponseEntity.ok(findPurchaseObjectService.findPurchaseObjectByCategory(category));
    }
    @GetMapping("/all")
    ResponseEntity<List<ProductModel>> findPurchaseObjectByPrice() {
        return ResponseEntity.ok(findPurchaseObjectService.findAllPurchaseObjectModel());
    }
    @GetMapping("/picture/{id}")
    ResponseEntity<?> findPictureById(@PathVariable UUID id) {

        Picture picture = pictureService.getPicturebyFilenameAndProductId("image1.png", id);
        byte[] data = ImageCompressionUtil.decompressImage(picture.getData());
//        String dataUrl = "data:image/png;base64," + Base64.getEncoder().encodeToString(ImageCompressionUtil.decompressImage(picture.getData()));
//        String html = "<html><body><img src='" + dataUrl +  "' /></body></html>";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);
        return new ResponseEntity<>(data, headers, HttpStatus.OK);

    }
}
