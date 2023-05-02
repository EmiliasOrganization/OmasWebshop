package de.webshop.webshopbackend.model;

import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public interface ProductSummary {
    UUID getId();
    String getName();
    String getDescription();
    String getCategory();
}
