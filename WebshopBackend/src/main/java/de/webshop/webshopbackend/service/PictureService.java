package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.Exceptions.ElementNotFoundException;
import de.webshop.webshopbackend.model.Picture;
import de.webshop.webshopbackend.repo.PictureRepo;
import jakarta.transaction.Transactional;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class PictureService {

    PictureRepo pictureRepo;

    @Transactional
    public Picture getPicturebyFilenameAndProductId(String filename, UUID id) {


        return pictureRepo.findPicturesByFilenameAndProductModelId(filename, id).orElseThrow(() -> new ElementNotFoundException("Picture not found!"));
    }


}
