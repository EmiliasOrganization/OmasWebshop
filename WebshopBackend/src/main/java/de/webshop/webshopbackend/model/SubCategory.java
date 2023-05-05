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
    BAGS_CROSSOVER,
    //HATS
    HATS_HAT,
    HATS_HEADBAND,
    HATS_TOQUE,
}
