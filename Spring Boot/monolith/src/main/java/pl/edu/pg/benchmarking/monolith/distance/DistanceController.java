package pl.edu.pg.benchmarking.monolith.distance;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.pg.benchmarking.monolith.distance.dto.DistanceRequest;
import pl.edu.pg.benchmarking.monolith.distance.dto.DistanceResponse;

import java.util.List;

@RestController
@RequestMapping("api/distance")
public class DistanceController {

    private final SphericalDistanceService distanceService;

    public DistanceController(SphericalDistanceService distanceService) {
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