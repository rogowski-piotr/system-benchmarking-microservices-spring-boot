package pl.edu.pg.benchmarking.monolith.algorithm2;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("api/route2")
public class Route2Controller {
    private final Route2Service routeService;

    public Route2Controller(Route2Service routeService) {
        this.routeService = routeService;
    }

    @GetMapping
    public ResponseEntity<List<Integer>> computeRoute(@RequestParam Set<Integer> id) {
        return ResponseEntity.ok(routeService.computeRoute(id));
    }

}