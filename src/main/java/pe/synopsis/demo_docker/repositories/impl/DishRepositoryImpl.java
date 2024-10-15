package pe.synopsis.demo_docker.repositories.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import pe.synopsis.demo_docker.model.Dish;
import pe.synopsis.demo_docker.repositories.DishRepository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class DishRepositoryImpl implements DishRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Dish mapToDish(ResultSet rs) throws SQLException {
        var dish = new Dish();
        dish.setDishPrice(rs.getDouble("dishPrice"));
        dish.setId(rs.getInt("id"));
        dish.setName(rs.getString("name"));
        dish.setDescription(rs.getString("description"));
        return dish;
    }


    @Override
    public List<Dish> getDishes() {
        String sql = "EXEC dbo.GET_DISHES";
        List<Dish> dishes = jdbcTemplate.query(sql,(rs, rowNum) -> mapToDish(rs));
        return dishes;
    }

    @Override
    public Dish getDishById(int id) {
        return null;
    }
}
