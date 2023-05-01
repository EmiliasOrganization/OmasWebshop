package de.webshop.webshopbackend.Utils;

import de.webshop.webshopbackend.model.Picture;
import de.webshop.webshopbackend.model.ProductModel;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


public class ImageUploaderUtil {

    public static void imageUpload(@RequestPart(name = "Files", required = false) MultipartFile[] files, @RequestPart("ObjectData") ProductModel productModel) throws IOException {
        List<Picture> pictureList = new ArrayList<>();
        for (MultipartFile file : files){
            int imageNumber = 1;
            String str = file.getOriginalFilename();
            String extension = Objects.requireNonNull(str).substring(str.lastIndexOf(".") + 1);

            Picture picture = new Picture();
            picture.setProductModel(productModel);
            picture.setFilename("image"+ imageNumber + "." + extension);
            picture.setData(ImageCompressionUtil.compressImage(file.getBytes()));


            pictureList.add(picture);
            imageNumber++;
        }
        productModel.setPictures(pictureList);
    }
}
