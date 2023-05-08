package de.webshop.webshopbackend.repo;

import de.webshop.webshopbackend.model.PictureModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface PictureRepository extends JpaRepository<PictureModel, UUID> {

    Optional<PictureModel> findPicturesByFilenameContainingAndProductModelId(String filename, UUID id);
}
