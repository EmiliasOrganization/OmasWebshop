package de.webshop.webshopbackend.repo;


import de.webshop.webshopbackend.model.Categorie;
import de.webshop.webshopbackend.model.Picture;
import de.webshop.webshopbackend.model.ProductModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;


@Repository
public interface PurchaseObjectsRepository extends JpaRepository<ProductModel, UUID> {

    @Override
    void deleteById(UUID uuid);

    Optional<ProductModel> findById(UUID uuid);

    Optional<ProductModel> findByCategory(Categorie category);


}
