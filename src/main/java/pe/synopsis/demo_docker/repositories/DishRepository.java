package pe.synopsis.demo_docker.repositories;

import pe.synopsis.demo_docker.model.Dish;
import java.util.List;

public interface DishRepository {
    List<Dish> getDishes();
    Dish getDishById(int id);
}
