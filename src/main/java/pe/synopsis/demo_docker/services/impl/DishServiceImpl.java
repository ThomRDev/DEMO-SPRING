package pe.synopsis.demo_docker.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pe.synopsis.demo_docker.model.Dish;
import pe.synopsis.demo_docker.repositories.DishRepository;
import pe.synopsis.demo_docker.services.DishService;

import java.util.List;

@Service
public class DishServiceImpl implements DishService {

    @Autowired
    private DishRepository dishRepository;

    @Override
    public List<Dish> getDishes() {
        var dishes = dishRepository.getDishes();
        return dishes;
    }

    @Override
    public Dish getDishById(int id) {
        return null;
    }

}
