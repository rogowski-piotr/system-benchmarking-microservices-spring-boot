package pl.edu.pg.benchmarking.math.dto;

import java.util.function.Function;

public class DistanceResponse {

    private Double distance;

    public Double getDistance() {
        return distance;
    }

    private DistanceResponse(Double distance) {
        this.distance = distance;
    }

    public static Function<Double, DistanceResponse> entityToDtoMapper() {
        return DistanceResponse::new;
    }

}
