package de.webshop.webshopbackend.model;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import java.util.List;
import java.util.UUID;

@Entity
@Data
public class PurchaseObjectModel {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @OneToMany
    private List<Pictures> pictures;

    @Column(name = "Name", nullable = false)
    private String name;

    @Column(name = "Beschreibung")
    private String description;

//    @Column(name = "Preis", nullable = false)
//    private MonetaryAmount pice;

    @Column(name = "Kategorie")
    private Categorie category;

}
