package de.webshop.webshopbackend.model;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RequiredArgsConstructor
@Getter
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public enum SubCategory {

    BAGS_SHOPPINGBAGS,
    BAGS_SHOULDERBAGS,
    BAGS_CROSSOVERS,
    //HATS
    HATS_HATS,
    HATS_HEADBANDS,
    HATS_TOQUES,
}
