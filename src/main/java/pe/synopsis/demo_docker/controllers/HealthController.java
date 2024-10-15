package pe.synopsis.demo_docker.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/health")
public class HealthController {

    @GetMapping()
    public ResponseEntity<String> getHealth(){
        return ResponseEntity.status(HttpStatus.OK).body("OK");
    }
}
