package de.webshop.webshopbackend.model;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import java.util.UUID;

@Data
@Entity
public class Pictures {

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

    @Lob
    byte[] picture1;

    @Lob
    byte[] picture2;

    @Lob
    byte[] picture3;

    @Lob
    byte[] picture4;

    @Lob
    byte[] picture5;

    @Lob
    byte[] picture6;

    @Lob
    byte[] picture7;

    @Lob
    byte[] picture8;

    @Lob
    byte[] picture9;


    byte[] picture10;

}
