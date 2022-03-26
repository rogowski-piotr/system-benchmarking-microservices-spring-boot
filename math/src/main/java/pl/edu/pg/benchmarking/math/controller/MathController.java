package pl.edu.pg.benchmarking.math.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import pl.edu.pg.benchmarking.math.entity.Point;
import pl.edu.pg.benchmarking.math.dto.DistanceResponse;
import pl.edu.pg.benchmarking.math.dto.DistanceRequest;
import pl.edu.pg.benchmarking.math.service.DistanceService;

import java.util.List;
import java.util.logging.Logger;

@RestController
@RequestMapping("api/math")
public class MathController {

    private final Logger LOG = Logger.getLogger(this.getClass().getName());
    private final DistanceService distanceService;

    public MathController(DistanceService distanceService) {
        this.distanceService = distanceService;
    }

    @PostMapping
    public ResponseEntity<DistanceResponse> createPlace(@RequestBody DistanceRequest request, UriComponentsBuilder builder) {
        LOG.info("Post points");
        List<Point> points = DistanceRequest.dtoToEntityMapper().apply(request);
        Point point1 = points.get(0);
        Point point2 = points.get(1);

        Double distance = distanceService.calculateDistance(
                point1.getCoordinateX(), point1.getCoordinateY(),
                point2.getCoordinateX(), point2.getCoordinateY());

        return ResponseEntity.ok(DistanceResponse.entityToDtoMapper().apply(distance));
    }

}
