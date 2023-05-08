package de.webshop.webshopbackend.service;

import de.webshop.webshopbackend.Exceptions.ElementNotFoundException;
import de.webshop.webshopbackend.model.PictureModel;
import de.webshop.webshopbackend.repo.PictureRepository;
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

    PictureRepository pictureRepository;

    @Transactional
    public PictureModel getPicturebyFilenameAndProductId(String filename, UUID id) {


        return pictureRepository.findPicturesByFilenameContainingAndProductModelId(filename, id).orElseThrow(() -> new ElementNotFoundException("Picture not found!"));
    }


}
