package de.webshop.webshopbackend.repo;

import de.webshop.webshopbackend.model.Picture;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface PictureRepo extends JpaRepository<Picture, UUID> {

    Optional<Picture> findPicturesByFilenameAndProductModelId(String filename, UUID id);
}
