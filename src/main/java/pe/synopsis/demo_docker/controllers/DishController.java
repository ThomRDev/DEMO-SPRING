package pe.synopsis.demo_docker.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pe.synopsis.demo_docker.model.Dish;
import pe.synopsis.demo_docker.services.DishService;

import java.util.List;

@RestController
@RequestMapping("/v1/dishes")
public class DishController {

    @Autowired
    private DishService dishService;

    @GetMapping("")
    public ResponseEntity<List<Dish>> getDishes(){
        try {
            var dishes = dishService.getDishes();
            return ResponseEntity.status(HttpStatus.OK).body(dishes);
        }
        catch(Exception ex) {
            return ResponseEntity.internalServerError().build();
        }
    }

}
