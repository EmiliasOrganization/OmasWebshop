package de.webshop.webshopbackend.model;


import lombok.AccessLevel;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RequiredArgsConstructor
@Getter
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public enum Category {

    BAGS,
    CHILDREN,
    BACKPACKS,
    GLOVES,
    HATS,
    CUSHIONS,
    SOCKS,
    CUDDLY_TOYS;

}
