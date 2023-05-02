package de.webshop.webshopbackend.Utils;

import de.webshop.webshopbackend.model.PictureModel;
import de.webshop.webshopbackend.model.ProductModel;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


public class ImageUploaderUtil {

    public static void imageUpload( MultipartFile[] files, ProductModel productModel) throws IOException {
        List<PictureModel> pictureModelList = new ArrayList<>();
        for (MultipartFile file : files){
            int imageNumber = 1;
            String str = file.getOriginalFilename();
            String extension = Objects.requireNonNull(str).substring(str.lastIndexOf(".") + 1);

            PictureModel pictureModel = new PictureModel();
            pictureModel.setProductModel(productModel);
            pictureModel.setFilename("image"+ imageNumber + "." + extension);
            pictureModel.setData(ImageCompressionUtil.compressImage(file.getBytes()));


            pictureModelList.add(pictureModel);
            imageNumber++;
        }
        productModel.setPictureModels(pictureModelList);
    }
}
