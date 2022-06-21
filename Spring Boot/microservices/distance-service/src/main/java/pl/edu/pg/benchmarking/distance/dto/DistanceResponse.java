package pl.edu.pg.benchmarking.distance.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.function.Function;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class DistanceResponse {

    private Double distance;

    public static Function<Double, DistanceResponse> entityToDtoMapper() {
        return DistanceResponse::new;
    }
}
