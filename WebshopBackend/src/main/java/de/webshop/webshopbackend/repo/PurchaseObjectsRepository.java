package de.webshop.webshopbackend.repo;


import de.webshop.webshopbackend.model.Categorie;
import de.webshop.webshopbackend.model.PurchaseObjectModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;


@Repository
public interface PurchaseObjectsRepository extends JpaRepository<PurchaseObjectModel, UUID> {

    @Override
    void deleteById(UUID uuid);

    Optional<PurchaseObjectModel> findById(UUID uuid);

    Optional<PurchaseObjectModel> findByCategory(Categorie category);

}
