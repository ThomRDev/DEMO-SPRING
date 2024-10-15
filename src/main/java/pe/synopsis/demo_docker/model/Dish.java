package pe.synopsis.demo_docker.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Dish {
    private int id;
    private String name;
    private String description;
    private double dishPrice;
}

