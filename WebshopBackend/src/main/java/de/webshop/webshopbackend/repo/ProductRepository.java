package de.webshop.webshopbackend.repo;


import de.webshop.webshopbackend.model.Category;
import de.webshop.webshopbackend.model.ProductModel;
import de.webshop.webshopbackend.model.ProductSummary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;


@Repository
public interface ProductRepository extends JpaRepository<ProductModel, UUID> {


    List<ProductSummary> findAllProjectedBy();

    @Override
    void deleteById(UUID uuid);

    Optional<ProductModel> findById(UUID uuid);

    Optional<ProductModel> findByCategory(Category category);


}
