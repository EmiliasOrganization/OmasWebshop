package de.webshop.webshopbackend.controller;

import de.webshop.webshopbackend.Utils.ImageCompressionUtil;
import de.webshop.webshopbackend.model.Category;
import de.webshop.webshopbackend.model.PictureModel;
import de.webshop.webshopbackend.model.ProductModel;
import de.webshop.webshopbackend.model.SubCategory;
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

    CreateProductService createProductService;
    DeleteProductService deleteProductService;
    FindProductService findProductService;
    UpdateProductService updateProductService;
    PictureService pictureService;

    @PostMapping("/create")
    ResponseEntity<?> createProduct(@RequestPart(name = "Files", required = false) MultipartFile[] files, @RequestPart("ObjectData") ProductModel productModel) throws IOException {

        if (files == null || files.length == 0){
            createProductService.createPurchaseObject(productModel);
            return ResponseEntity.ok("Uploadet Data with no Picture");
        }

        imageUpload(files, productModel);
        createProductService.createPurchaseObject(productModel);

        return ResponseEntity.ok("Files uploaded successfully!");
    }

    @DeleteMapping("/delete/{id}")
    ResponseEntity<?> deleteProduct(@PathVariable UUID id) {
        deleteProductService.deletePurchaseObjectById(id);
        return ResponseEntity.noContent().build();
    }
    @PutMapping("/update")
    ResponseEntity<?> updateProduct(@RequestPart(name = "Files", required = false) MultipartFile[] files, @RequestPart("ObjectData") ProductModel productModel) throws IOException {

        if (files == null || files.length == 0){
            createProductService.createPurchaseObject(productModel);
            return ResponseEntity.ok("Data updated successfully!");
        }

        imageUpload(files, productModel);
        updateProductService.updatePurchaseObject(productModel);

        return ResponseEntity.ok("Files updated successfully!");
    }
    @GetMapping("/id/{id}")
    ResponseEntity<?> findProductById(@PathVariable UUID id) {
        return ResponseEntity.ok(findProductService.findProductById(id));
    }
    @GetMapping("/category/{category}")
    ResponseEntity<?> findProductByCategory(@PathVariable Category category) {
        return ResponseEntity.ok(findProductService.findProductCategory(category));
    }
    @GetMapping("/category/sub/{subCategory}")
    ResponseEntity<?> findProductBySubCategory(@PathVariable SubCategory subCategory) {
        return ResponseEntity.ok(findProductService.findProductBySubCategory(subCategory));
    }
    @GetMapping("/category/{category}/{subCategory}")
    ResponseEntity<?> findProductByCategoryAndSubCategory(@PathVariable Category category, @PathVariable SubCategory subCategory) {
        return ResponseEntity.ok(findProductService.findProductByCategoryAndSubCategory(category, subCategory));
    }
    @GetMapping("/all")
    ResponseEntity<List<?>> findAllSummary() {
        return ResponseEntity.ok(findProductService.findAllSummary());
    }

    @GetMapping("/picture/{id}/{pictureName}")
    ResponseEntity<?> findPictureById(@PathVariable String pictureName, @PathVariable UUID id) {
        byte[] data = pictureService.getPicturebyFilenameAndProductId(pictureName, id);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);
        return new ResponseEntity<>(data, headers, HttpStatus.OK);
    }
    @GetMapping ("/picture/count/{id}")
    ResponseEntity<?> countPictureByProductId(@PathVariable UUID id) {
        return ResponseEntity.ok(pictureService.countAllByProductModelId(id));
    }
}
