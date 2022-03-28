package pl.edu.pg.benchmarking.math.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.edu.pg.benchmarking.math.entity.Point;
import pl.edu.pg.benchmarking.math.dto.DistanceResponse;
import pl.edu.pg.benchmarking.math.dto.DistanceRequest;
import pl.edu.pg.benchmarking.math.service.SphericalDistanceService;

import java.util.List;

@RestController
@RequestMapping("api/math")
public class MathController {

    private final SphericalDistanceService distanceService;

    public MathController(SphericalDistanceService distanceService) {
        this.distanceService = distanceService;
    }

    @PostMapping
    public ResponseEntity<DistanceResponse> calculateDistance(@RequestBody DistanceRequest request) {
        List<Point> points = DistanceRequest.dtoToEntityMapper().apply(request);
        Point point1 = points.get(0);
        Point point2 = points.get(1);

        Double distance = distanceService.calculateDistance(
                point1.getLatitude(), point1.getLongitude(),
                point2.getLatitude(), point2.getLongitude());

        return ResponseEntity.ok(DistanceResponse.entityToDtoMapper().apply(distance));
    }

}
