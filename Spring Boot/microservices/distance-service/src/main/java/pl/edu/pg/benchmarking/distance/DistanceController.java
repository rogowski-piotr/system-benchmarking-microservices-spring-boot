package pl.edu.pg.benchmarking.distance;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import pl.edu.pg.benchmarking.distance.dto.DistanceRequest;
import pl.edu.pg.benchmarking.distance.dto.DistanceResponse;

import java.util.List;

@RestController
@RequestMapping("api/distance")
public class DistanceController {

    private final SphericalDistanceService distanceService;

    public DistanceController(SphericalDistanceService distanceService) {
        this.distanceService = distanceService;
    }

    @PostMapping
    public ResponseEntity<List<DistanceResponse>> calculateDistance(@RequestBody List<DistanceRequest> request) {
        List<Point> points = DistanceRequest.dtoToEntityMapper().apply(request);
        List<Double> distances = points.stream()
                .map(pointPair -> distanceService.calculateDistance(
                        pointPair.getLatitude1(), pointPair.getLongitude1(),
                        pointPair.getLatitude2(), pointPair.getLongitude2())
                ).toList();
        return ResponseEntity.ok(DistanceResponse.entityToDtoMapper().apply(points, distances));
    }
}
