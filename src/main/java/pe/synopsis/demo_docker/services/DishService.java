package pe.synopsis.demo_docker.services;

import pe.synopsis.demo_docker.model.Dish;

import java.util.List;

public interface DishService {
    List<Dish> getDishes();
    Dish getDishById(int id);
}
