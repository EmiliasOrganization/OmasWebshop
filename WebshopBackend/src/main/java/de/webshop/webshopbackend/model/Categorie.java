package de.webshop.webshopbackend.model;


import lombok.AccessLevel;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RequiredArgsConstructor
@Getter
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public enum Categorie {

    BAGS("Bags"),
    CHILDREN("Children"),
    BACKPACKS("Backpacks"),
    GLOVES("Gloves"),
    HATS("Hats"),
    PILLOWS("Pillows"),
    SOCKS("Socks"),
    STUFFED_ANIMALS("Stuffed Animals");

    String categorie;

}
