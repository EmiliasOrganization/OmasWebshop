package de.webshop.webshopbackend.repo;


import de.webshop.webshopbackend.model.Category;
import de.webshop.webshopbackend.model.ProductModel;
import de.webshop.webshopbackend.model.ProductSummary;
import de.webshop.webshopbackend.model.SubCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;


@Repository
public interface ProductRepository extends JpaRepository<ProductModel, UUID> {


    List<ProductSummary> findAllProjectedBy();

    List<ProductSummary> findAllProjectedByCategory(Category category);

    List<ProductSummary> findAllProjectedByCategoryAndSubCategory(Category category, SubCategory subCategory);

    List<ProductSummary> findAllProjectedBySubCategory(SubCategory subCategory);

    @Override
    void deleteById(UUID uuid);

    Optional<ProductModel> findById(UUID uuid);

}
